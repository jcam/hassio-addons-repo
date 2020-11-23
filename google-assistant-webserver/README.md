# Marcelveldt's Hassio Add-ons: Google Assistant Webserver

## About

Webservice for the Google Assistant SDK
Allow you to send (broadcast) commands to Google Assistant


## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Hass.io add-on.

1. [Add my Hass.io add-ons repository][repository] to your Hass.io instance.
1. Install the "Google Assistant Webserver" add-on.
1. Start the "Google Assistant Webserver" add-on.
1. Check the logs of the add-on to see if everything went well.
1. At the first start, you will need to authenticate with Google, use the "Open Web UI" button for that.
1. Ready to go!


## Usage in HomeAssistant

Once you've set-up the webserver, you can add the component to HomeAssistant as notify component (for the broadcasts) and as script for the custom actions.

### Broadcast component

```yaml
notify:
  - name: Google Assistant
    platform: rest
    resource: http://62c7908d_google_assistant_webserver:5000/broadcast
```

### Script component

```yaml

# define as rest_command in configuration
rest_command:
  - google_assistant_command:
      url: 'http://62c7908d_google_assistant_webserver:5000/command?message={{ command }}'


# example usage in script
script:
  - google_cmd_test:
      service: rest_command.google_assistant_command
      data:
        command: "some command you want to throw at the assistant"
```





[repository]: https://github.com/marcelveldt/hassio-addons-repo