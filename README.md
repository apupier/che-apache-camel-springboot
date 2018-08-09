# che-apache-camel-springboot

Experimental Docker File used for Che stack for Apache Camel

How to try it:
- retrieve Apache Camel community Che stack from https://github.com/che-samples/community-stacks/blob/master/apache-camel/apache-camel-stack.json[Community repository]
- modify docker file used to https://hub.docker.com/r/apupier/che-apache-camel-springboot/[apupier/che-apache-camel-springboot] (on https://github.com/che-samples/community-stacks/blob/30d6f669be88e0f55a77801dad109df2e0abebe5/apache-camel/apache-camel-stack.json#L18[this line]) 
- install the modified stack into Che using REST API via <yourCheInstanceURL>/swagger/#!/stack/createStack as explained in https://www.eclipse.org/che/docs/stacks.html#community-supported-stacks[this chapter]
