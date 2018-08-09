#!/bin/sh
# Copyright (c) 2012-2017 Red Hat, Inc
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html

RED='\033[0;31m'
NC='\033[0m' # No Color
YELLOW='\033[0;33m'
BLUE='\033[0;34m'

function install {
  mvn dependency:get -Dartifact=$1 > /tmp/maven-$1.log
  if [ $? -eq 0 ]; then
    echo -e "🍻  ${YELLOW}$1 installed successfully ${NC}"
  else
    echo -e "☠️  ${RED}Unable to install $1 ${NC}"
    cat /tmp/maven-$1.log
    exit 1
  fi
}

echo -e "${BLUE}Installing Apache Camel ${CAMEL_VERSION} dependencies..."
install $CAMEL_GROUP:camel-core:$CAMEL_VERSION
install $CAMEL_GROUP:camel-spring-boot-starter:$CAMEL_VERSION
install $CAMEL_GROUP:camel-test-spring:$CAMEL_VERSION
install $CAMEL_GROUP:camel-test-spring:$CAMEL_VERSION
install io.fabric8:fabric8-maven-plugin:3.5.34
install org.apache.maven.plugins:maven-surefire-plugin:2.19.1
install org.apache.maven.plugins:maven-compiler-plugin:3.6.0
echo -e "${BLUE}Apache Camel ${CAMEL_VERSION} dependencies installed ${NC}"
rm -Rf /tmp/maven-*