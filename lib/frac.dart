import 'fnotifier.dart';
import 'listenable.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
export 'index.dart';

//import 'change_notifier.dart';
/*
extension WordFrac on Word {
  Fra Function() get frac {
    final f = stuff[4] ?? () => Frac<String>('');
    //f.word = this;
    return f;
  }

  set frac(Fra Function() f) {
    stuff[4] = f;
  }
}
*/

mixin class Fr<T> {
  dynamic get value => null;
  set value(dynamic val) {}
}

class Fra<T> extends FChangeNotifier with Fr<T> {
  //late final Word word;

  listen(Function(dynamic val) listener) {
    super.addListener(() {
      listener(value);
    });
  }

  Uint8List get bytes => Uint8List.fromList([
        if (value is String)
          ...(ByteData(2)..setUint16(0, value.length)).buffer.asUint8List(),
        if (value is String) ...utf8.encode(value),
        if (value is int)
          ...(ByteData(4)..setInt32(0, value)).buffer.asUint8List(),
        if (value is double)
          ...(ByteData(4)..setFloat32(0, value)).buffer.asUint8List(),
      ]);

  Uint8List read(Uint8List b) {
    if (value is String) {
      final length = ByteData.view(b.buffer, 2, 2).getUint16(0);

      value = utf8.decode(b.sublist(4, 4 + length));
      return b.sublist(4 + length);
    } else if (value is int) {
      final v = ByteData.view(b.buffer, 4, 4);
      value = v.getInt32(0);
      return b.sublist(4);
    } else if (value is double) {
      final v = ByteData.view(b.buffer, 4, 4);
      value = v.getFloat32(0);
      return b.sublist(4);
    }
    return Uint8List(0);
  }

  set buf(List<int> bytes) {
    if (value is String) {
      value = utf8.decode(bytes);
    } else if (value is int) {
      int numb = 0;
      for (var i = 0, length = bytes.length; i < length; i++) {
        numb += bytes[i] * pow(256, i) as int;
      }
      value = numb;
    }
  }
}

extension FracNullExt on Frac<Object?> {
  bool get isNull => value == null;
}

extension FracNumExt on Frac<num?> {
  bool get isZero => value == null || value == 0;
}

class Frac<V> extends Fra implements FValueListenable<V> {
  V _value;
  Frac(this._value);

  @override
  listen(Function(V val) listener) {
    super.addListener(() {
      listener(value);
    });
  }

  @override
  set value(covariant V val) {
    if (val != _value) {
      _value = val;
      notifyListeners();
    }
  }

  @override
  V get value => _value;
}

class Fracs<V> extends Fra {
  List<V> values = [];

  add(V val) {
    values.add(val);
    notifyListeners();
  }
}

class SelfFrac extends Fra {
  Function(dynamic val) set;
  dynamic Function() get;
  SelfFrac({required this.set, required this.get});

  @override
  set value(dynamic val) {
    if (val != null) {
      set(val);
      notifyListeners();
    }
  }

  @override
  dynamic get value => get();

  @override
  listen(Function(dynamic val) listener) {
    super.addListener(() {
      listener(get());
    });
  }
}

extension FracBool on Frac<bool> {
  bool get isTrue => value == true;
}
