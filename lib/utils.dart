import 'dart:async';

class TimedF {
  Timer? _timer;
  //final pointers = <Pointer>[];

  Completer? c;
  Future hold(FutureOr Function() fn, [int ms = 400]) {
    _timer?.cancel();
    c ??= Completer();
    _timer = Timer(
      Duration(milliseconds: ms),
      () async {
        final cr = c!;
        c = null;
        final r = await fn();
        cr.complete(r);
      },
    );
    return c!.future;
  }
}
