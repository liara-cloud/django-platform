# Liara Django Platform

The docker image for Django projects. (Created with django-admin)

When you deploy to Liara, the dependencies you specify in your `requirements.txt` file are automatically installed before app startup. The `collectstatic` command also runs automatically during the deployment process.

## Development

Apply your changes and then run `./build.sh` to build all variations and then you can use the images in your development machine.

## Production

Commit your changes and then run `./release.sh`. It will trigger a webhook and then DockerHub will build and publish the images.
