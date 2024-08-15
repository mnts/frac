import 'package:fractal/c.dart';
import 'package:fractal/types/index.dart';
import 'string.dart';

class Word with FractalC {
  static const god = Word.id('god', 0);
  final String name;
  static Map<Type, Word> types = {};
  static Map<String, Word> map = {};
  static Map<int, Word> ids = {};
  //final List<Word> sub = [];

  //final Map<int, dynamic> stuff = {};

  IconF get icon => IconF(0xf04b6);

  String get label => name.replaceAll('_', ' ').allWordsCapitilize();

  static int lastId = 0;

  static Word attach(Word word) => ids[++lastId] ??= map[word.name] = word;

  factory Word(String name) => attach(
        Word.id(
          name,
          lastId,
        ),
      );
  const Word.id(this.name, this.id);
  //print('#' + id.toString() + ' Defined: ' + name);

  //final Type? type;
  final int id;

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) =>
      other is Word && other.runtimeType == runtimeType && other.id == id;
}
