import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';  // Add this line.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
        ),
        body: const Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}
class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  /*
  *  Set型
  * (ドキュメント引用)Set is preferred to List because a properly implemented Set doesn't allow duplicate entries.
  * →重複した値を持たないListみたいな感じ
  */
  final _saved = <WordPair>{};     // add
  final _biggerFont = TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        //suggestions[index]があるか、ないか(bool)
        final alreadySaved = _saved.contains(_suggestions[index]); // add
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),

          //iconを表示（右端にくるのはなぜ？）
          trailing: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
            //
            semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
          ),
          onTap: () {          // NEW from here ...
            setState(() {
              //リストをタップした時の動作
              //_saved内に_suggestions[indes]がない場合(alreadysaved == true)にadd, addされていた場合(alreadysaved == true)はremove
              if (alreadySaved) {
                _saved.remove(_suggestions[index]);
              } else {
                _saved.add(_suggestions[index]);
              }
            });                // to here.
          },
        );
      },
    );
  }
}