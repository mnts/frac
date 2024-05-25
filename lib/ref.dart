import 'index.dart';

class FRef<R extends Object, V> extends Frac<V?> {
  final R ref;
  FRef(this.ref, [super.value]);
}

class FReFuture<V> extends FRef<String, V?> {
  FReFuture(super.ref, [super.value]);
}
