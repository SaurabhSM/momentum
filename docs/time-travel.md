# Time Travel Support
Have you ever wanted to set your state 1 step behind from the current state? Or wanted to integrade `undo/redo` feature on you app? Momentum has built-in support for this function. You can do this in 1 line of code only.

## backward()
This is a method inside `MomentumController`. This will _undo_ the state change or set the state 1 step behind from the current state.
```dart
// Assuming we are using this widget inside login page to undo username or password changes.
class UndoButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Undo'),
      onPressed: () {
        var loginController = Momentum.of<LoginController>(context);
        loginController.backward(); // undo state change.
      }
    );
  }
}
```

## forward()
This is a method inside `MomentumController`. This will _redo_ the previous _undo_ or set the state 1 step forward from the current state. If you are currently on the latest state this method will do nothing.
```dart
// Assuming we are using this widget inside login page to redo username or password changes.
class RedoButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Redo'),
      onPressed: () {
        var loginController = Momentum.of<LoginController>(context);
        loginController.forward(); // redo state change.
      }
    );
  }
}
```

!> **NOTE**: You have to configure your `Momentum` root widget to enable time travel function. It's only 1 line of code too!

This feature is disabled by default because not many apps actually needs this. Besides storing state history will be very expensive especially for big model classes. It's still a super cool feature though.