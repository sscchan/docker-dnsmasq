# docker-dnsmasq
A dnsmasq DNS only service for local homelab using the .home domain.

# Build
`docker build -t docker-dnsmasq .`

# Create DNS entries using standard hostfile format
`echo "10.0.0.1 example.home" > ./local_hosts`

# Run
`docker run -d -v $(pwd)/local_hosts:/etc/custom_hosts:ro -p 53:5353/udp -p 53:5353/tcp --name dnsmasq docker-dnsmasq`

# Verify
`dig @localhost -p 53 example.home`