FROM ubuntu:22.04
RUN apt update && apt install -y default-jdk-headless cmake git ninja-build strace unzip wget 
ENV ANDROID_SDK_ROOT /opt/android
RUN mkdir -p /src/proxydroid
RUN mkdir -p /opt/android
RUN cd /tmp && wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip && unzip -d /opt commandlinetools-linux-8512546_latest.zip
RUN yes | /opt/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_SDK_ROOT --licenses
COPY . /src/proxydroid/
WORKDIR /src/proxydroid

RUN sh gradlew --no-daemon dependencies

RUN sh gradlew build -x lint -x test --no-daemon
