"""Handler for authentication."""

import json
import sys
from pathlib import Path

from aiohttp import web
from google.oauth2.credentials import Credentials
from requests_oauthlib import OAuth2Session

routes = web.RouteTableDef()


class AuthHandler:
    """Some logic to handle granting access to Google."""

    def __init__(self, user_data:dict, cred_file:Path):
        """Initialize."""
        self.cred_file = cred_file
        self.user_data = user_data

        self.oauth2 = OAuth2Session(
            self.user_data["client_id"],
            redirect_uri="urn:ietf:wg:oauth:2.0:oob",
            scope="https://www.googleapis.com/auth/assistant-sdk-prototype",
        )
        self.auth_url, _ = self.oauth2.authorization_url(
            self.user_data["auth_uri"], access_type="offline", prompt="consent"
        )

    @routes.get("/token")
    async def token(self, request):
        """Read access token and process it."""
        token = request.query.get("token")
        self.oauth2.fetch_token(
            self.user_data["token_uri"], client_secret=self.user_data["client_secret"], code=token
        )

        # create credentials
        credentials = Credentials(
            self.oauth2.token["access_token"],
            refresh_token=self.oauth2.token.get("refresh_token"),
            token_uri=self.user_data["token_uri"],
            client_id=self.user_data["client_id"],
            client_secret=self.user_data["client_secret"],
            scopes=self.oauth2.scope,
        )

        # write credentials json file
        with self.cred_file.open("w") as json_file:
            json_file.write(
                json.dumps(
                    {
                        "refresh_token": credentials.refresh_token,
                        "token_uri": credentials.token_uri,
                        "client_id": credentials.client_id,
                        "client_secret": credentials.client_secret,
                        "scopes": [credentials.scopes],
                    }
                )
            )
        return web.Response(text="Authentication successfull")
