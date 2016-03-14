# Use latest frolvlad/alpine-oraclejdk8 image as the base
FROM frolvlad/alpine-oraclejdk8:latest
MAINTAINER Aleksey Nikitin <kvandake@gmail.com>

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 9.0.2.Final
ENV WILDFLY_SHA1 75738379f726c865d41e544e9b61f7b27d2853c7

# Add the WildFly distribution to /opt
RUN cd $HOME \
	&& wget http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xz -f wildfly-$WILDFLY_VERSION.tar.gz \
    && mkdir -p /opt \
    && mv $HOME/wildfly-$WILDFLY_VERSION /opt/wildfly \
    && rm wildfly-$WILDFLY_VERSION.tar.gz

ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Expose the ports we're interested in
EXPOSE 8080 9990

# Set the default command to run on boot
CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]