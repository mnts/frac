/*
import 'dart:async';

import 'index.dart';

mixin class CompleterF<K extends Object> {
  final timer = TimedF();
  final tasks = <K, Completer>{};
  int ms = 10;

  late Future Function() cb;

  Future hold(K key) {
    if (tasks[key] case Completer comp) return comp.future;
    final comp = tasks[key] = Completer();
    timer.hold(cb, ms).then((d) async {
      await d;
      final rem = <K>[];
      for (var en in tasks.entries) {
        tasks[en.key]?.complete();
        rem.add(en.key);
      }
      for (var rk in rem) {
        tasks.remove(rk);
      }
    });
    return comp.future;
  }
}

*/
