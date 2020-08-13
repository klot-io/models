ACCOUNT=klotio
IMAGE=models
VERSION?=0.1

.PHONY: cross build shell push tag untag

cross:
	docker run --rm --privileged multiarch/qemu-user-static:register --reset

build:
	docker build . -t $(ACCOUNT)/$(IMAGE):$(VERSION)

shell:
	-docker run -it --rm $(ACCOUNT)/$(IMAGE):$(VERSION) sh

push:
	docker push $(ACCOUNT)/$(IMAGE):$(VERSION)

tag:
	-git tag -a "v$(VERSION)" -m "Version $(VERSION)"
	git push origin --tags

untag:
	-git tag -d "v$(VERSION)"
	git push origin ":refs/tags/v$(VERSION)"
