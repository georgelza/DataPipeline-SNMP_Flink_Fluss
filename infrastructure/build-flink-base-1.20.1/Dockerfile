
FROM arm64v8/flink:1.20.1-scala_2.12-java17
SHELL ["/bin/bash", "-c"]

# The below java-17 is needed for PyFlink available via apache-flink
#RUN echo "--> Install some useful tools (openjdk-17-jdk-headless required on ARM platforms to enable installation of apache-flink)" \
RUN echo "--> Install some useful tools" \
    && build_deps="neovim tree lnav unzip gradle" \
    && apt-get update \
    && apt-get install -y $build_deps

#   && build_deps="neovim tree lnav unzip gradle python3-pip python3.10-venv openjdk-17-jdk-headless" \
#ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-arm64

ENV JAVA_HOME=/opt/java/openjdk

# # https://github.com/apache/flink/tree/master/flink-python/pyflink/examples
#RUN echo "--> Install apache-flink" \
#    && /usr/bin/pip3 install apache-flink==1.20.1

#RUN echo "--> Cleanup time after apache-flink install" \
#    && apt-get remove -y openjdk-17-jdk-headless 

RUN echo "--> Purge apt artifacts" \
    && apt-get purge -y --auto-remove $build_deps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Take note of the below... otherwise your job will report a error saying there is no Python intepreter available.
RUN echo "--> Purge apt artifacts" && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ldconfig /usr/lib