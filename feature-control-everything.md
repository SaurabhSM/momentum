# Access and Control Everything
You can access your _controllers_ and _models_ in your widgets and inside your controllers themselves. All of these are done inside the widget tree, no singeton or static containers.

## Controller and Model in a widget
This is how you access a controller in a widget to display its model values.
```dart
MomentumBuilder(
  controllers: [LoginController], // access login controller.
  builder: (context, snapshot) {
    var loginModel = snapshot<LoginModel>(); // access login model.
    if (loginModel.isLoggingIn) {
      return LoadingWidget();
    }
    return ButtonWidget();
  }
);
```

## Calling controller functions.
There are _4 ways_ to access a controller.

  1. Inside `StatelessWidget`. This is how you access a controller inside `build` method.
  ```dart
    class LoginButton extends StatelessWidget {

      @override
      Widget build(BuildContext context) {
        return ButtonWidget(
          onPressed: () {
            // access a controller using "Momentum.of<T>()" method.
            var loginController = Momentum.of<LoginController>(context);
            loginController.login();
          }
        );
      }
    }
  ```
  2. Inside `StatelfulWidget`. This is how you access a controller inside `initState` or `didChangeDependencies` method.
  ```dart
    class LoginButton extends StatefulWidget { ... }

    class _LoginButtonState extends State<LoginButton> {
      LoginController loginController; // class wide access

      @override
      void didChangeDependencies() {
        // You can also do this in "initState"
        loginController = Momentum.of<LoginController>(context);
        super.didChangeDependencies();
      }

      @override
      Widget build(BuildContext context) {
        return ButtonWidget(
          onPressed: () {
            loginController.login();
          }
        );
      }
    }
  ```
  3. Inside `MomentumBuilder`. This is how you access a controller inside momentum builder's widget class using circular reference.
  ```dart
    MomentumBuilder(
      controllers: [LoginController], // access login controller.
      builder: (context, snapshot) {
        var loginModel = snapshot<LoginModel>(); // access login model.
        var loginController = loginModel.controller // access controller with circular reference.
        return ButtonWidget(
          onPressed: () {
            loginController.login(); // call a function.
          }
        );
      }
    );
  ```
  4. Inside another _Controller_. This is the cool part. You can access another controller inside a controller without using context.
  ```dart
    class LoginController ... {
      ...
      void login() async {
        var response = await apiService.login(model.username, model.password);
        if (response.success) {
          // access another controller and call a method from it.
          var sessionController = dependOn<SessionController>();
          sessionController.startSession(response);
        }
      }
      ...
    }
  ```

## Grab model from other controller
Because the relationship between `MomentumModel` and `MomentumController` is a circular reference, if you can access the controller then you can also access the model and vice-versa.
For example:
```dart
void login() async {
  var response = await apiService.login(model.username, model.password);
  if (response.success) {
    // access another controller and call a method from it.
    var sessionController = dependOn<SessionController>();
    sessionController.startSession(response);

    // access session model.
    var sessionModel = sessionController.model;
    var id = sessionModel.sessionId;
    print(id);
  }
}
```