import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';  // Add this line.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //なぜconst?
    return const MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
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

  final _saved = <WordPair>{};     // add
  final _biggerFont = TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(   // NEW from here ...
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        //actionsで右側にボタンを追加できる
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            //おすと_pushSavedを呼び出す
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body:  ListView.builder(
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
      ),
    );
  }
  void _pushSaved() {
    Navigator.of(context).push(
      // Add lines from here...
      //MaterialPageRouteを引数として指定することで遷移時にMaterialDesignに則ったアニメーションをしてくれる
      MaterialPageRoute<void>(
        builder: (context) {
          //_saved内の項目をmap型に変換→ListTitle型に変換してreturn
          final tiles = _saved.map(
                (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );

          //項目ごとを線で分割
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ...to here.
    );
  }
}