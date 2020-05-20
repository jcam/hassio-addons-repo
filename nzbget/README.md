# Marcelveldt's Home Assistant Add-ons: Nzbget

## About

Nzbget is a usenet downloader, written in C++ and designed with performance in mind to achieve maximum download speed by using very little system resources.

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other add-on.

1. [Add my Add-ons repository][repository] to your Home Assistant instance.
1. Install this add-on.
1. Click the `Save` button to store your configuration.
1. Start the add-on.
1. Check the logs of the add-on to see if everything went well.
1. Carefully configure the add-on to your preferences, see the official documentation for for that.



## Configuration

The addon is configured with Ingress support, meaning that security and authentication is handled by Home Assistant. Use the Web UI button to start configuring.

By default the folders */backup* and */share* are available within the application.
You can use the share folder to store/access your media files.

[repository]: https://github.com/marcelveldt/hassio-addons-repo