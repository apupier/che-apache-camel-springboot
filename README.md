# che-apache-camel-springboot

Experimental Docker File used for Che stack for Apache Camel

How to try it:
- retrieve Apache Camel community Che stack from [Community repository](https://github.com/che-samples/community-stacks/blob/master/apache-camel/apache-camel-stack.json)
- modify docker file used to [apupier/che-apache-camel-springboot](https://hub.docker.com/r/apupier/che-apache-camel-springboot/) (on [this line](https://github.com/che-samples/community-stacks/blob/30d6f669be88e0f55a77801dad109df2e0abebe5/apache-camel/apache-camel-stack.json#L18)) 
- install the modified stack into Che using REST API via <yourCheInstanceURL>/swagger/#!/stack/createStack as explained in [this chapter](https://www.eclipse.org/che/docs/stacks.html#community-supported-stacks)
  
  demo of what can be achieved is viewable here: https://youtu.be/HmQ0TCm9Jvw
