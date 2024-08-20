FROM ubuntu:noble
WORKDIR /

# Install dnsmasq
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y dnsmasq
RUN cp /etc/dnsmasq.conf /etc/dnsmasq.conf.bak

# Configure dnsmasq
RUN echo "" >> /etc/dnsmasq
RUN echo "# Docker build-time configurations"
RUN echo "domain-needed" >> /etc/dnsmasq.conf
RUN echo "bogus-priv" >> /etc/dnsmasq.conf
RUN echo "local=/home/" >> /etc/dnsmasq.conf
RUN echo "addn-hosts=/etc/custom_hosts" >> /etc/dnsmasq.conf
RUN echo "port=5353" >> /etc/dnsmasq.conf

# (TEMP) Configure DNS entries
# TODO: This should be mounted at container start
RUN echo "10.0.0.123  mealplanner.home" > /etc/custom_hosts

ENTRYPOINT ["dnsmasq", "-k"]
EXPOSE 5353/udp
EXPOSE 5353/tcp