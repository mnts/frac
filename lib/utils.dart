import 'dart:async';

class TimedF {
  Timer? _timer;
  //final pointers = <Pointer>[];

  hold(void Function() fn) {
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 400),
      fn,
    );
  }
}
