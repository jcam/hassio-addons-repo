"""Main entrypoint: webserver handling commands to google assistant."""
import json
import logging
import os
from pathlib import Path

from aiohttp import web

from assistant import GoogleTextAssistant
from auth import AuthHandler

LOGGER = logging.getLogger()

CLIENT_JSON = Path(os.path.join(os.path.dirname(os.path.abspath(__file__)), "client_secrets.json"))
CRED_JSON = Path("/data/cred.json")

routes = web.RouteTableDef()


@routes.get("/broadcast")
async def broadcast_message(request):
    message = request.query.get("message", default="This is a test!")
    text_query = "broadcast " + message
    with GoogleTextAssistant("en-US", "HA_GA", "HA_GA_TEXT_SERVER", CRED_JSON) as assistant:
        response_text, response_html = assistant.assist(text_query=text_query)
    return web.Response(text=response_text)


@routes.get("/command")
async def command(request):
    message = request.query.get("message", default="This is a test!")
    with GoogleTextAssistant("en-US", "HA_GA", "HA_GA_TEXT_SERVER", CRED_JSON) as assistant:
        response_text, response_html = assistant.assist(text_query=text_query)
    return web.Response(text=response_text)


@routes.get("/")
async def index(request):
    """Landingpage."""
    body = f"""<html>
        <head></head>
        <body>
        <p>
            Get token from google: <a href="{request.app["auth"].auth_url}" target="_blank">Authentication</a>
        </p>
        <p>Once you have the token, paste it below and click Connect.</p>
        <form method="get" action="token">
            <input type="text" value="" name="token" />
            <button type="submit">Connect</button>
        </form>
        </body>
    </html>"""
    return web.Response(text=body, content_type="text/html")


app = web.Application()
app.add_routes(routes)

with CLIENT_JSON.open("r") as data:
    user_data = json.load(data)["installed"]
auth = AuthHandler(user_data, CRED_JSON)
app.router.add_get("/token", auth.token)
app["auth"] = auth

web.run_app(app, port=5000)
