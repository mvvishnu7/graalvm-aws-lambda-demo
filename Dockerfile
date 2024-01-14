# Use the official AWS Linux image as the base image
FROM amazonlinux:latest

# Install necessary dependencies
RUN yum install -y \
    tar \
    gzip \
    zip \
    which \
    gcc \
    glibc-devel \
    zlib-devel \
    libstdc++ \
    libstdc++-devel

# Install GraalVM
ENV GRAALVM_VERSION=graalvm-community-openjdk-21.0.1
ENV GRAALVM_HOME=/opt/graalvm
RUN curl -L https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-21.0.1/graalvm-community-jdk-21.0.1_linux-aarch64_bin.tar.gz -o /tmp/graalvm.tar.gz && \
    tar -xzf /tmp/graalvm.tar.gz -C /opt && \
    rm /tmp/graalvm.tar.gz && \
    ln -s /opt/graalvm-community-openjdk-21.0.1+12.1 /opt/graalvm && \
    echo 'export PATH=$PATH:/opt/graalvm/bin' >> /etc/profile.d/graalvm.sh

# Install Maven
ENV MAVEN_VERSION=3.9.6
RUN curl -L https://apache.osuosl.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz -o /tmp/maven.tar.gz && \
    tar -xzf /tmp/maven.tar.gz -C /opt && \
    rm /tmp/maven.tar.gz && \
    ln -s /opt/apache-maven-3.9.6 /opt/maven && \
    echo 'export PATH=$PATH:/opt/maven/bin' >> /etc/profile.d/maven.sh

# Set environment variables
ENV PATH="$PATH:/opt/graalvm/bin:/opt/maven/bin"

# Print GraalVM and Maven versions for verification
RUN java -version && \
    mvn -v

# Set working directory
WORKDIR /app

# Copy the entire project (assuming Dockerfile is in the same directory as pom.xml)
COPY . /app

RUN mvn clean package -P native-image

RUN mkdir build

RUN cp /app/target/function.zip /app/build

# Command to run when the container starts
CMD ["/bin/bash"]
