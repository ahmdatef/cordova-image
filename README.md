# cordova-image
A repository that hosts Dockerfile used to build Cordova Docker Image for the [ahmdatef/cordova](https://hub.docker.com/r/ahmdatef/cordova)  Docker Hub Registry.

# How to build
The image installs Android, Java, Gradle, Node, Cordova, and optionally an extra android `build-tools` if needed.
## Base
Based on top of:
1. [androidsdk](https://hub.docker.com/u/androidsdk) Docker Hub Repositories to install different Android versions.
2. [sdkman](https://sdkman.io/) to install different Java and Gradle versions.
3. [nvm](https://github.com/nvm-sh/nvm) to install different Node and Npm versions.


## Build Arguments
| Name               | Default      | Available Values   |
| ------------------ | ------------ | --------- |
| ANDROID_VERSION    | 30           | All available `androidsdk` images provided by [androidsdk](https://hub.docker.com/u/androidsdk) Docker Hub Repositories |
| JAVA_VERSION       | 11.0.12-open | All available `java` versions provided by [sdkman](https://sdkman.io/) |
| GRADLE_VERSION     | 7.1.1        | All available `gradle` versions provided by [sdkman](https://sdkman.io/) |
| NODE_VERSION       | 12.22.1      | All available `node` versions provided by [nvm](https://github.com/nvm-sh/nvm) |
| CORDOVA_VERSION    | 11.0.0       | All available `cordova` versions |
| EXTRA_BUILD_TOOLS_VERSION | None | All available `build-tools` versions for the selected `ANDROID_VERSION` |

## Command

To build any your own custom Cordova Image using your customized versions
```
docker build -t ahmdatef/cordova github.com/ahmdatef/cordova-image#main \
    --build-arg ANDROID_VERSION=${YOUR_ANDROID_VERSION} \
    --build-arg JAVA_VERSION=${YOUR_JAVA_VERSION} \
    --build-arg GRADLE_VERSION=${YOUR_GRADLE_VERSION} \
    --build-arg NODE_VERSION=${YOUR_NODE_VERSION} \
    --build-arg CORDOVA_VERSION=${YOUR_CORDOVA_VERSION}
    --build-arg EXTRA_BUILD_TOOLS_VERSION=${YOUR_EXTRA_BUILD_TOOLS_VERSION}
```
