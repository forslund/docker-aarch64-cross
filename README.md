## Arm64 cross-compiler docker image

Mainly created to cross-compile u-boot and the Linux kernel for arm64.

### Building the image
docker build -t aarch64-cross .


### Using the image to run commands

Copy the aarch-run.sh to somewhere in your PATH (or provide a full path)

then use it to run a build command inside the docker.

Example

```
cd u-boot
aarch-run.sh "CROSS_COMPILE=aarch64-linux-gnu- AARCH=aarch64 make"
```
