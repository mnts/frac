import 'types.dart';

abstract class FListenable {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const FListenable();

  /// Return a [Listenable] that triggers when any of the given [Listenable]s
  /// themselves trigger.
  ///
  /// The list must not be changed after this method has been called. Doing so
  /// will lead to memory leaks or exceptions.
  ///
  /// The list may contain nulls; they are ignored.
  //factory Listenable.merge(List<Listenable?> listenables) = _MergingListenable;

  /// Register a closure to be called when the object notifies its listeners.
  void addListener(VoidCallback listener);

  /// Remove a previously registered closure from the list of closures that the
  /// object notifies.
  void removeListener(VoidCallback listener);
}

/// An interface for subclasses of [Listenable] that expose a [value].
///
/// This interface is implemented by [ValueNotifier<T>] and [Animation<T>], and
/// allows other APIs to accept either of those implementations interchangeably.
///
/// See also:
///
///  * [ValueListenableBuilder], a widget that uses a builder callback to
///    rebuild whenever a [ValueListenable] object triggers its notifications,
///    providing the builder with the value of the object.
abstract class FValueListenable<T> extends FListenable {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const FValueListenable();

  /// The current value of the object. When the value changes, the callbacks
  /// registered with [addListener] will be invoked.
  T get value;
}

const String _flutterFoundationLibrary = 'package:flutter/foundation.dart';
