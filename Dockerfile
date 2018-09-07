# Copyright (c) 2012-2018 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Contributors:
#   Red Hat, Inc. - initial API and implementation
FROM registry.centos.org/che-stacks/centos-jdk8

MAINTAINER Aurelien Pupier

EXPOSE 8080
LABEL che:server:8080:ref=springboot che:server:8080:protocol=http

#Prepopulate .m2 with SpringBoot dependencies
ARG SPRING_BOOT_VERSION=1.5.4.RELEASE
ARG JUNIT_VERSION=4.12
ENV SPRING_BOOT_GROUP=org.springframework.boot
COPY install_spring_boot_dependencies.sh /tmp/
RUN sudo chown user:user /tmp/install_spring_boot_dependencies.sh && \
    sudo chmod a+x /tmp/install_spring_boot_dependencies.sh && \
    scl enable rh-maven33 /tmp/install_spring_boot_dependencies.sh && \
    sudo rm -f /tmp/install_spring_boot_dependencies.sh && \
    sudo chgrp -R 0 /home/user && \
    sudo chmod -R g+rwX /home/user

#Prepopulate .m2 with Camel dependencies
ARG CAMEL_VERSION=2.19.1
ENV CAMEL_GROUP=org.apache.camel
COPY install_camel_dependencies.sh /tmp/
RUN sudo chown user:user /tmp/install_camel_dependencies.sh && \
    sudo chmod a+x /tmp/install_camel_dependencies.sh && \
    scl enable rh-maven33 /tmp/install_camel_dependencies.sh && \
    sudo rm -f /tmp/install_camel_dependencies.sh && \
    sudo chgrp -R 0 /home/user && \
    sudo chmod -R g+rwX /home/user

#Provide yeoman with Camel project generator, available in Che terminal with 'yo' command
RUN sudo yum update -y && \
    sudo yum -y install rh-nodejs6 && \
    sudo yum -y clean all  && \
    sudo ln -s /opt/rh/rh-nodejs6/root/usr/bin/node /usr/local/bin/nodejs && \
    sudo scl enable rh-nodejs6 'npm install --unsafe-perm -g yo generator-camel-project' && \
    cat /opt/rh/rh-nodejs6/enable >> /home/user/.bashrc
ENV PATH=/opt/rh/rh-nodejs6/root/usr/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/opt/rh/rh-nodejs6/root/usr/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

#provide Hawt.io, a runtime management console
RUN mkdir /home/user/hawtio && \ 
    sudo wget -P /home/user/hawtio "https://oss.sonatype.org/content/repositories/public/io/hawt/hawtio-app/2.0.3/hawtio-app-2.0.3.jar"
CMD ["java","-jar","/home/user/hawtio/hawtio-app-2.0.3.jar","--port","8090"]

#provide AtlasMap, a Data mapper
RUN mkdir /home/user/atlasmap && \ 
    sudo wget -P /home/user/atlasmap "https://maven.repository.redhat.com/ga/io/atlasmap/runtime/1.34.5.fuse-000001-redhat-3/runtime-1.34.5.fuse-000001-redhat-3.jar"
CMD ["java","-jar","/home/user/hawtio/runtime-1.34.5.fuse-000001-redhat-3.jar"]
RUN	sudo scl enable rh-nodejs6 'npm install --unsafe-perm -g yarn' && \
	cat /opt/rh/rh-nodejs6/enable >> /home/user/.bashrc
ENV PATH=/opt/rh/rh-nodejs6/root/usr/bin${PATH:+:${PATH}}
RUN yarn add @atlasmap/atlasmap.data.mapper && \
    yarn start @atlasmap/atlasmap.data.mapper
