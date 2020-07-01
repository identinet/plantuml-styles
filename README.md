This repository contains the identinet plantuml styles.

# Installation

- Install [plantuml](https://www.plantuml.com)
- Clone this repository into your current directory
    - `git clone git@github.com:identinet/plantuml-styles.git styles`
    - or as a submodule in a git repository `git submodule add
      git@github.com:identinet/plantuml-styles.git styles`
- Install submodules: `git submodule update --init --recursive`

# Usage

- Create a plantuml diagram and include the styles

```
@startuml
!include styles/style.plantuml

title <TITLE>

participant "A" as a
participant "B" as b

a -> b: Something
@enduml
```
