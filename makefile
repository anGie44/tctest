GIT_COMMIT=$(shell git describe --always --long --dirty)

default: fmt build

all: fmt imports build

fmt:
	@echo "==> Fixing source code with gofmt..."
	find . -name '*.go' | grep -v vendor | xargs gofmt -s -w

imports:
	@echo "==> Fixing imports code with goimports..."
	goimports -w .

build:
	@echo "==> building..."
	cd cmd/tctest && go build -ldflags "-X github.com/katbyte/tctest/version.GitCommit=${GIT_COMMIT}" . && mv tctest ../../

install:
	@echo "==> installing..."
	cd cmd/tctest && go install -ldflags "-X github.com/katbyte/tctest/version.GitCommit=${GIT_COMMIT}" .

.PHONY: fmt imports build