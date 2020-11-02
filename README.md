# FFC Pa11y

Docker image for running [Pa11y-CI](https://github.com/pa11y/pa11y-ci)

## Usage

This image was built to support running Pa11y acceptance tests against a containerised web application orchestrated by Docker Compose.

To use this image run it overriding the entry point with your [Pa11y-CI](https://github.com/pa11y/pa11y-ci) command.

In the below example, the command is overridden to run a custom script to wait for web server to be running and then run Pa11y-CI tests where the configuration is in a local `pa11y.json` file.

```
version: '3.7'

services:
  ffc-demo-web:
    command: npm run start:watch
    build:
      target: development
    image: ffc-demo-web-development
    environment:
      NODE_ENV: test

  pa11y:
    image: defradigital/ffc-pa11y
    depends_on:
      - ffc-demo-web
    command: sh -c "scripts/wait ffc-demo-web:3000 -- pa11y-ci -c pa11y.json"
    volumes:
      - ./pa11y.json:/home/node/pa11y.json
      - ./scripts/:/home/node/scripts
```

## Licence

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT
LICENCE found at:

<http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3>

The following attribution statement MUST be cited in your products and
applications when using this information.

> Contains public sector information licensed under the Open Government license
> v3

### About the licence

The Open Government Licence (OGL) was developed by the Controller of Her
Majesty's Stationery Office (HMSO) to enable information providers in the
public sector to license the use and re-use of their information under a common
open licence.

It is designed to encourage use and re-use of information freely and flexibly,
with only a few conditions.
