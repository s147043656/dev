#!/bin/bash

CLASSPATH=$CATALINA_HOME/lib/mysql-connector-java-5.1.24-bin.jar

#JAVA_OPTS="$JAVA_OPTS   -Djava.awt.headless=true \
#                        -Xms256M -Xmx1500M \
#                        -XX:MaxPermSize=256M \
#                        -verbose:gc \
#                        -XX:+PrintGCDetails \
#                        -XX:+CMSClassUnloadingEnabled \
#                        -Dcom.sun.management.jmxremote.port=9001 \
#                        -Dcom.sun.management.jmxremote.authenticate=true \
#                        -Dcom.sun.management.jmxremote.ssl=false \
#                        -Dcom.sun.management.jmxremote.ssl.need.client.auth=false \
#                        -Djavax.net.ssl.keyStore=/apps/dkcms_sdev_tomcat/conf/ssl/tomcat.key \
#                        -Djavax.net.ssl.keyStorePassword=daadkracht"

#JAVA_OPTS="$JAVA_OPTS   -Dcom.sun.management.jmxremote.port=9001 \
#                        -Dcom.sun.management.jmxremote.authenticate=false \
#                        -Dcom.sun.management.jmxremote.ssl=false \
#                        -Dcom.sun.management.jmxremote.ssl.need.client.auth=false"


#JPDA_ADDRESS="8001"
