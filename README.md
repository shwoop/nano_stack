# NANO STACK

This repos is a catchall for any scripts or commands I've been using to spin up a nano node in fargate.

The scripts all use the "personal" aws profile: create one or sed the make file.
The cloudformation present only creates the application stack, not the ECR repository that it relies on, you'll need
to manually create ECR repos for "nanocurrency/nano" and "nanotools/nanonodemonitor".

The cloudformation has the ECR repo and VPC details hard coded so deal with that before deploying.

## TODO

* [ ] Check shit works on fargate
* [ ] Add an EFS to the stack and mount in the container
* [ ] Decide on monitoring and implement
* [ ] Tidy up networking

## Bootstrap

It's relatively simple to bootstrap the node via mynodeninja.
```
$ curl https://mynano.ninja/api/ledger/download -L -o ledger.7z
$ 7z x ledger.7z
$ mkdir -p mnt/Nano
$ mv data.ldb mnt/Nano/
$ rm ledger.7z
```

## Run locally

The scripts use my person ECR by default.  To fall back on docker hub provide a blank registry.
```
$ DOCKER_REGISTRY= make compose-local-up
```


## Push to ECS

```
$ make create-stack
```
or:
```
$ make update-stack
```


## Update images on ECR

The following will fetch the latest images, tag them for your repo, and push to your repo.
```
$ DOCKER_REGISTRY=my.ecr.path make docker-sync
```

