#!/usr/bin/env just --justfile
# Documentation: https://just.systems/man/en/

set shell := ['nu', '-c']

# Integration with nodejs package.json scripts, see https://just.systems/man/en/chapter_65.html

export PATH := env('PWD') / 'node_modules/.bin:' + env('PATH')

# To override the value of SOME_VERSION, run: just --set SOME_VERSION 1.2.4 TARGET_NAME

SOME_VERSION := '1.2.3'

# Print this help
default:
    @just -l

# Format Justfile
format:
    @just --fmt --unstable

# Install git commit hooks
githooks:
    #!/usr/bin/env nu
    $env.config = { use_ansi_coloring: false, error_style: "plain" }
    let hooks_folder = '.githooks'
    if (git config core.hooksPath) != $hooks_folder {
      print 'Installing git commit hooks'
      git config core.hooksPath $hooks_folder
      # npm install -g @commitlint/config-conventional
    }
    if not ($hooks_folder | path exists) {
      mkdir $hooks_folder
      "#!/usr/bin/env -S sh\nset -eu\njust test" | save $"($hooks_folder)/pre-commit"
      chmod 755 $"($hooks_folder)/pre-commit"
      "#!/usr/bin/env -S sh\nset -eu\n\nMSG_FILE=\"$1\"\nPATTERN='^(fix|feat|docs|style|chore|test|refactor|ci|build)(\\([a-z0-9/-]+\\))?!?: [a-z].+$'\n\nif ! head -n 1 \"${MSG_FILE}\" | grep -qE \"${PATTERN}\"; then\n\techo \"Your commit message:\" 1>&2\n\tcat \"${MSG_FILE}\" 1>&2\n\techo 1>&2\n\techo \"The commit message must conform to this pattern: ${PATTERN}\" 1>&2\n\techo \"Contents:\" 1>&2\n\techo \"- follow the conventional commits style (https://www.conventionalcommits.org/)\" 1>&2\n\techo 1>&2\n\techo \"Example:\" 1>&2\n\techo \"feat: add super awesome feature\" 1>&2\n\texit 1\nfi"| save $"($hooks_folder)/commit-msg"
      chmod 755 $"($hooks_folder)/commit-msg"
      # if not (".commitlintrc.yaml" | path exists) {
      # "extends:\n  - '@commitlint/config-conventional'" | save ".commitlintrc.yaml"
      # }
      # git add $hooks_folder ".commitlintrc.yaml"
      git add $hooks_folder
    }

# Build application
build: githooks
    docker run -u $"(id -u):(id -g)" -v $"($env.PWD):/app" -w /app plantuml/plantuml:1.2024.4 -charset UTF-8 -nbthread auto -failfast2 -tsvg $"-DDATE=(date now | format date "%Y-%m-%d")" README.md
    rm -rpf ?

# Init dependencies
initialize: githooks
    git submodule update --init --recursive

# Update dependencies
update: githooks
    cd c4; git checkout master
    cd sprites; git checkout main
    git submodule foreach git pull --rebase

# Run tests
test:
