FROM postgres:9.3
# Install the DataDog Agent

ENV AGENT_VERSION 1:5.4.3-1

RUN echo "deb http://apt.datadoghq.com/ stable main" > /etc/apt/sources.list.d/datadog.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7A7DA52 \
 && apt-get update \
 && apt-get install --no-install-recommends -y datadog-agent="${AGENT_VERSION}" \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#Install confd
ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

COPY confd/ /etc/confd/

COPY init.d/ /docker-entrypoint-initdb.d/
COPY postgresql.conf /postgresql.conf
COPY supervisor.conf /supervisor.conf
COPY run_confd /run_confd

EXPOSE 8125/udp

ENTRYPOINT [ "/run_confd" ]
CMD [ "supervisord", "-c", "supervisor.conf" ]
