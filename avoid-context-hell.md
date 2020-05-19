# Avoid Context Hell
This is a very common problem with Flutter. Passing around your _logic_ class between widgets can be unmaintainable when the project grows. Tracking _how_, _who_ and _when_ did a state change happen can be hard to deal with. With momentum you don't need to pass around your logic classes _(Controllers)_.

### Example
Assuming you are currently on `PageA` screen widget.
Instead of doing:
```dart
Navigator.push(context, MaterialPageRoute(builder: (context) {
  return PageB(loginController: loginController);
}));
```
You can just do:
```dart
Navigator.push(context, MaterialPageRoute(builder: (context) {
  return PageB(); // parameter-less.
}));
```
Then inside `PageB`:
```dart
class PageB extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var loginController = Momentum.of<LoginController>(context);
    return YourWidgetsHere(...);
  }
}
```
