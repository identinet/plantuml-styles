#!/usr/bin/env just --justfile
# Documentation: https://just.systems/man/en/

set shell := ['nu', '-c']

# Print this help
default:
    @just -l

# Format Justfile
format:
    @just --fmt

# Build application
build:
    docker run -u $"(id -u):(id -g)" -v $"($env.PWD):/app" -w /app plantuml/plantuml:1.2024.4 -charset UTF-8 -nbthread auto -failfast2 -tsvg $"-DDATE=(date now | format date "%Y-%m-%d")" README.md
    rm -rpf ?

# Init dependencies
initialize:
    git submodule update --init --recursive

# Update dependencies
update:
    git submodule foreach git pull --rebase
