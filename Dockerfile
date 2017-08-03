FROM jboss/wildfly

ENV DB_NAME databaseName
ENV DB_PASS databasePassword
ENV DB_USER databaseUsername
ENV DB_HOST localhost
ENV DB_PORT 5432

ENV DS_NAME myNewDs
ENV JNDI_NAME java:jboss/jdbc/myNewDs


ADD https://jdbc.postgresql.org/download/postgresql-42.1.4.jar /tmp/postgresql.jar
ADD wildfly-static-config.cli /tmp/wildfly-static-config.cli
ADD start.sh /scripts/
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /scripts/wait-for-it.sh

USER root
RUN chown jboss:0 -R /tmp/postgresql.jar && \
    chown -R jboss:0 /scripts && \
    chmod +x /scripts/wait-for-it.sh && \
    chmod +x /scripts/start.sh

USER jboss

# run config
RUN ${JBOSS_HOME}/bin/jboss-cli.sh --file=/tmp/wildfly-static-config.cli && \
    rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/

# add default admin user
RUN ${JBOSS_HOME}/bin/add-user.sh admin Admin#70365 --silent


USER jboss
CMD [ "/scripts/start.sh" ]