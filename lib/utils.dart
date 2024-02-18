import 'dart:async';

class TimedF {
  Timer? _timer;
  //final pointers = <Pointer>[];

  Completer? c;
  Future hold(Function() fn, [int ms = 400]) {
    _timer?.cancel();
    c ??= Completer();
    _timer = Timer(
      Duration(milliseconds: ms),
      () {
        c!.complete(fn());
        c = null;
      },
    );
    return c!.future;
  }
}
