# Inspired by https://github.com/gofiber/fiber/blob/7b3a36f22fc1166ceb9cb78cf69b3a2f95d077da/Makefile

.PHONY: help all audit format lint tidy up

help:
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## all: 🚀 Run pre-commit tasks
all: audit tidy format lint

## audit: 🚀 Conduct quality checks
audit:
	go mod verify
	go vet ./...
	go run golang.org/x/vuln/cmd/govulncheck@v1.1.3 -show verbose ./...

## format: 🎨 Fix code formatting
format:
	go run mvdan.cc/gofumpt@v0.7.0 -w -l .

## lint: 🚨 Run lint checks
lint:
	go run github.com/golangci/golangci-lint/cmd/golangci-lint@v1.61.0 run ./...

## tidy: 📌 Clean dependencies
tidy:
	go mod tidy -v

## up: 🔺 Update dependencies
up:
	go get -u ./...
