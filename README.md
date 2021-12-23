This repository contains the identinet plantuml styles.

# Installation

- Install [plantuml](https://www.plantuml.com)
- Clone this repository into your current directory
  - `git clone git@github.com:identinet/plantuml-styles.git styles`
  - or as a submodule in a git repository
    `git submodule add git@github.com:identinet/plantuml-styles.git styles`
- Install submodules: `git submodule update --init --recursive`

# Usage

## Standard plantuml diagrams

- See [plantuml documentation](https://www.plantuml.com) for more information on
  the syntax
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

## Architecture diagrams

- See
  [C4-PlantUML documentation](https://github.com/plantuml-stdlib/C4-PlantUML/)
- See [C4 software architecture model](https://c4model.com/)
- Create a plantuml diagram and include the respective diagram styles

## Context diagram

```
@startuml
!include styles/c4/C4_Context.puml

...

SHOW_LEGEND()

@enduml
```

## Container diagram

```
@startuml
!include styles/c4/C4_Container.puml

...

SHOW_LEGEND()

@enduml
```

## Component diagram

```
@startuml
!include styles/c4/C4_Component.puml

...

SHOW_LEGEND()

@enduml
```

## Icons

For icons, see
[plantuml-icon-font-sprites](https://github.com/tupadr3/plantuml-icon-font-sprites).
