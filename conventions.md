# Project Structure Convention
Project layout is very important. Where and how you organize your code files will affect code readability.

## Components
A pair of _Controller_ and _Model_ is called _Components_. You should separate your controller and model code file for readability.

## File names
It is highly recommended to name your code files all lower case.<br>
Examples: `login.controller.dart` and `login.model.dart`<br>
The syntax is `[component-name].[type].dart`<br>
Advance example: _UserProfile_ component.
  - `user-profile.controller.dart`
  - `user-profile.model.dart`
  - This example uses a component name with two words. You separate the words with _hyphen/dash_.
  - You can also put and optional `index.dart` file for easier imports.

## Class names
Dart follows _PascalCase_ naming convention for classes. You can just basically follow that convention.<br>
Example: `LoginModel`, `LoginController`

## Widgets
Never put a widget file inside `src/components/` folder. Components are not tied to any widget. You can put them in `src/widgets/` instead.<br>
✘ Wrong layout:
  - inside `lib/src/components/login/` folder
    - `login.controller.dart`
    - `login.model.dart`
    - `login.widget.dart`
<br>

✔ Correct layout:
  - inside `lib/src/components/login/` folder
    - `login.controller.dart`
    - `login.model.dart`
  - inside `lib/src/widgets/login` folder
    - `login.dart`

<br>
Widget file naming is up to you. The important thing is where you put them.

## Folder structure
You place your _components_ inside `lib/src/components/` folder.<br>
One folder represents one momentum component.<br>
Example folder structure:

    .
    ├── lib                     
        ├── src
            ├── components
                ├── login
                    ├── login.controller.dart
                    ├── login.model.dart
                    ├── index.dart                  # optional
                ├── session
                    ├── session.controller.dart
                    ├── session.model.dart
                ├── home
                    ├── home.controller.dart
                    ├── home.model.dart
            ├── resources
            ├── widgets
        ├── main.dart