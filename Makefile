.PHONY: zip build

VERSION=v1.0.0

# Build the Hugo site locally
build:
	hugo --minify

# Create archive for manual deployment
tar:
	tar -C public -czvf website-$(VERSION).tar.gz .

# Note: Deployment is handled by Drone CI
# Configure secrets in Drone: aws_access_key_id, aws_secret_access_key
