.EXPORT_ALL_VARIABLES:
DOCKER_REGISTRY?=674244809039.dkr.ecr.us-east-1.amazonaws.com/

docker-login:
	@$$(aws ecr get-login --region us-east-1 --no-include-email --profile personal)

docker-update-images:
	docker pull nanocurrency/nano:latest
	docker pull nanotools/nanonodemonitor

docker-tag-images:
	docker tag nanocurrency/nano:latest ${DOCKER_REGISTRY}nanocurrency/nano:latest
	docker tag nanotools/nanonodemonitor ${DOCKER_REGISTRY}nanotools/nanonodemonitor

docker-push-images:
	docker push ${DOCKER_REGISTRY}nanocurrency/nano:latest
	docker push ${DOCKER_REGISTRY}nanotools/nanonodemonitor

docker-sync: docker-login docker-update-images docker-tag-images docker-push-images

compose-local-up:
	cd local; docker-compose up

create-stack:
	aws cloudformation --profile personal \
		create-stack \
		--stack-name poop \
		--capabilities CAPABILITY_NAMED_IAM \
		--template-body file://cloudformation.yml

update-stack:
	aws cloudformation --profile personal \
		update-stack \
		--stack-name poop \
		--capabilities CAPABILITY_NAMED_IAM \
		--template-body file://cloudformation.yml
