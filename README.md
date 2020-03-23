# BackstopJS Docker Image #

A self-contained Docker image to run BackstopJS with no external dependencies.
Visual Regression Testing with BackstopJS in a Docker container

## What is this repository for? ##

BackstopJS automates visual regression testing of your responsive web UI by comparing DOM screenshots over time.

### Versioning

* BackstopJS v3 with Chrome Headless support


### Pre-requisites ###

Docker should be already installed and running.


### 1) Create docker image and shared volume:

```
./build
```

This creates an image based on the Dockerfile then create a container sharing a volume between Docker and your local machine (backstop-docker/*)

### 2) Run Backstop tests:

```
./backstop init
```
Set up a new BackstopJS instance -- specify URLs, cookies, screen sizes, DOM selectors, interactions etc.
Or use backstop.json example provided.

```
./backstop test
```
BackstopJS creates a set of test screenshots and compares them with your reference screenshots. Any changes show up in a visual report. (Run this after making CSS changes as many times as needed.)

```
./backstop approve
```
If the test you ran looks good, then go ahead and approve it. Approving changes will update your reference files with the results from your last test. Future tests are compared against your most recent approved test screenshots.

### Optional) Remove container

```
./remove
```

Remove any container that belongs to BackstopJS image.

## Visit BackstopJS website for details
https://github.com/garris/BackstopJS

## Known issues
In case Chrome browser is not launched due to the following error:

```
COMMAND | Command `test` ended with an error after [0.049s]
COMMAND | Error: Failed to launch chrome!
         [0709/173002.604379:ERROR:zygote_host_impl_linux.cc(89)] Running as root without --no-sandbox is not supported. See https://crbug.com/638180.
```

Just add the following lines to the backstop.json file:

```
"engineOptions": {
  "ignoreHTTPSErrors": false,
  "args": ["--no-sandbox", "--disable-setuid-sandbox"]
}
```