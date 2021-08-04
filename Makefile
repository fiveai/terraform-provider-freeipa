GOVARS  := CGO_ENABLED=1
VERSION := $(shell git describe --tags --always --dirty="-dev")

# Currently arm and mac builds broken based on the cross compile dependencies.

.PHONY: all
all: dist/terraform-provider-freeipa_$(VERSION)-darwin-amd64 dist/terraform-provider-freeipa_$(VERSION)-linux-amd64

release: clean github-release dist
	github-release release \
		--user fiveai \
		--repo terraform-provider-freeipa \
		--tag $(VERSION) \
		--name $(VERSION)
		--security-token $$GITHUB_TOKEN

	# GNU/Linux - X86
	github-release upload \
		--user fiveai \
		--repo terraform-provider-freeipa \
		--tag $(VERSION) \
		--name terraform-provider-freeipa_$(VERSION)-linux-amd64 \
		--file terraform-provider-freeipa_$(VERSION)-linux-amd64 \
		--security-token $$GITHUB_TOKEN

	# arm
	# github-release upload \
	#         --user fiveai \
	#         --repo terraform-provider-k8s \
	#         --tag $(VERSION) \
	#         --name terraform-provider-k8s_$(VERSION)-linux-arm \
	#         --file terraform-provider-k8s_$(VERSION)-linux-arm \
	#         --security-token $$GITHUB_TOKEN
        #
	# github-release upload \
	#         --user fiveai \
	#         --repo terraform-provider-k8s \
	#         --tag $(VERSION) \
	#         --name terraform-provider-k8s_$(VERSION)-linux-arm64 \
	#         --file terraform-provider-k8s_$(VERSION)-linux-arm64 \
	#         --security-token $$GITHUB_TOKEN

	# macOS
	github-release upload \
	        --user fiveai \
	        --repo terraform-provider-k8s \
	        --tag $(VERSION) \
	        --name terraform-provider-k8s_$(VERSION)-darwin-amd64 \
	        --file terraform-provider-k8s_$(VERSION)-darwin-amd64 \
	        --security-token $$GITHUB_TOKEN

dist:
	mkdir -p dist
	# arm
	# $(GOVARS) GOOS=linux CC=arm-linux-gnueabi-gcc GOARCH=arm go build -o terraform-provider-k8s_$(VERSION)-linux-arm
	# $(GOVARS) GOOS=linux GOARCH=arm64 go build -o terraform-provider-k8s_$(VERSION)-linux-arm64

dist/terraform-provider-freeipa_$(VERSION)-darwin-amd64: | dist
	GOOS=darwin GOARCH=amd64 GO111MODULE=on go build $(LDFLAGS) -o $@

dist/terraform-provider-freeipa_$(VERSION)-linux-amd64: | dist
	GOOS=linux GOARCH=amd64 GO111MODULE=on go build $(LDFLAGS) -o $@

clean:
	rm -rf terraform-provider-freeipa*

github-release:
	go get -u github.com/aktau/github-release

.PHONY: clean github-release
