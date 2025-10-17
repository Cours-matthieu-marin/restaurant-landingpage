.PHONY: zip build deploy

VERSION=v1.0.0
BUCKET_NAME=resto-files-ccm2
AWS_REGION=us-east-1

build:
	hugo --minify

tar:
	tar -C public -czvf website-$(VERSION).tar.gz .

deploy: build
	aws s3 sync public/ s3://$(BUCKET_NAME) --delete
	aws s3 cp s3://$(BUCKET_NAME)/index.html s3://$(BUCKET_NAME)/index.html --cache-control "no-cache"
	@echo "Site deployed to s3://$(BUCKET_NAME)"

deploy-cf: deploy
	aws cloudfront create-invalidation --distribution-id $(CLOUDFRONT_DISTRIBUTION_ID) --paths "/*"
	@echo "CloudFront cache invalidated"
