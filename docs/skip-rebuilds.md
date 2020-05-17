# Skip Rebuilds
There are situations where you don't want to rebuild your widgets when some conditions are met. It is possible with momentum using `MomentumBuilder` with `dontRebuildIf` parameter.

### Example
This is an example from a time display widget (`HH:mm`) where the timer ticks every `500ms` for accuracy. And we don't want our widget to rebuild at the same speed. We only want it to rebuild when _minute_ value has changed.
```dart
MomentumBuilder(
  controllers: [TimerController],
  dontRebuildIf: (controller, isTimeTravel) {
    var timer = controller<TimerController>();
    var prevMinute = timer.prevModel.dateTime.minute; // you can access previous state.
    var currentMinute = timer.model.dateTime.minute; // access current state.
    var minuteUnchanged = currentMinute == prevMinute; // compare previous and current.
    return minuteUnchanged; // don't rebuild the widget if "minute" is unchanged.
  },
  builder: (context, snapshot) {...},
)
```

### Use case
Because you can access previous, current and next state you can make simple to complex conditions for skipping rebuilds. And because this is per `MomentumBuilder` and doesn't affect other implementations, if you did a mistake in your conditions, only that specific MomentumBuilder will fail to skip rebuilding.