# Reset State
With momentum you can reset your state from its initial value. You can even reset _all_ controllers in 1 line of code.

## reset()
This method is inside `MomentumController`. This will call your `init()` implementation to reset model values.
```dart
class HomeController ... {

  void logout () {
    var sessionController = dependOn<SessionController>();
    sessionController.reset(); // call other controllers' reset method.
    reset(); // call this controller's own reset method.
  }
}
```

## Momentum.resetAll(context)
This is a static method that uses `inheritFromWidgetOfExactType`. It loops through all controllers and call their `reset()` method.
```dart
class HomePage extends StatelessWidget {

  void logout() {
    Momentum.resetAll(context);
  }
}
```
Optionally, you can override its behaviour with `onResetAll` parameter on the `Momentum` root widget.
```dart
void main() {
  runApp(
    Momentum(
      controllers: [...],
      child: MyApp(),
      onResetAll: (context, resetAll) {
        // the provided "resetAll" parameter is the original "Momentum.resetAll(context)" method.
        // you do some conditions or checking first, then call this method or not call it at all.

        // because it also provides context, you can grab a controller
        // or display dialogs/snackbars or anything.
        var sessionController = Momentum.of<SessionController>(context);
        // do anything with "sessionController" here.

        // show confirmation dialog or something.
        showDialog(context, builder: (context) { ... });

        resetAll(); // call the provided original "resetAll" method after some dialogs or some other complex conditions.
      }
    ),
  );
}
```
You can optionally skip calling the provided `resetAll` method inside `onResetAll`. Example case where you want to do this is when you only want to reset some controllers instead of _all_.

!> Resetting your state doesn't clear state history. So you can still call _time travel_ methods and do a restore. Example usecase is if the user accidentally clicked "Logout" and "Yes" button, then `resetAll` method was called. You can offer the user a _relogin_ function.