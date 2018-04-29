# Introducing Gabber

Gabber is a lightweight generator of build numbers that uses Semantic Versioning 2.0.0 [http://semver.org](http://semver.org)

## Anyone can uses

Gabber generates sequential versions of builds number. For example, in Microsoft builds you know that 1109 is well before 14563. However, 14573 has few differences for 14563.

Just run into a git repo:

`$ curl -s https://raw.githubusercontent.com/MateusGabi/Gabber/master/src/semver.sh | bash -s -- --help`

## Features

### Generates Git Tags

Major Updates: `$ curl -s https://raw.githubusercontent.com/MateusGabi/Gabber/master/src/semver.sh | bash -s -- --generate=major`

Minor Updates: `$ curl -s https://raw.githubusercontent.com/MateusGabi/Gabber/master/src/semver.sh | bash -s -- --generate=minor`

Patch Updates: `$ curl -s https://raw.githubusercontent.com/MateusGabi/Gabber/master/src/semver.sh | bash -s -- --generate=patch`

### Next Version

Major Updates: `$ curl -s https://raw.githubusercontent.com/MateusGabi/Gabber/master/src/semver.sh | bash -s -- --next=major`

Minor Updates: `$ curl -s https://raw.githubusercontent.com/MateusGabi/Gabber/master/src/semver.sh | bash -s -- --next=minor`

Patch Updates: `$ curl -s https://raw.githubusercontent.com/MateusGabi/Gabber/master/src/semver.sh | bash -s -- --next=patch`

**For every code above, you can add some flags:**

`--verbose`: print messages at every step time

`--sha`: add commit sha on version

`--date`: add commit date on version

`--build-number`: add a magic number as build id on version

## Requirements 

- Git
