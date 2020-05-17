# Avoid Context Hell
This is a very common problem with Flutter. Passing around your _logic_ class between widgets can be unmaintainable when the project grows. Tracking _how_, _who_ and _when_ did a state change happen can be hard to deal with. With momentum you don't need to pass around your logic classes _(Controllers)_.

### Example
Instead of doing:
```dart
return ButtonWidget(loginController: loginController);
```
You can just do:
```dart
return ButtonWidget();
```
Then inside `ButtonWidget`:
```dart
class ButtonWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: ...,
      onPressed: () {
        var loginController = Momentum.of<LoginController>(context);
        loginController.login();
      }
    );
  }
}
```
