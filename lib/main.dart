import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:hello_world/item.dart';

// One line function
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = "Startup Name Generator";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // random();
    // Your Console Log Spammer
    print(context.owner);

    // final wordPair = WordPair.random();
    return MaterialApp(title: this.title, home: RandomWords());
  }
}

// #docregion RandomWordsState, RWS-class-only (STATEFUL)
class RandomWordsState extends State<RandomWords> {
  // #enddocregion RWS-class-only

  // To Display a List of Words, using a container
  final List<WordPair> _suggestions = <WordPair>[];
  // Storaged of the set of saved words
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // A Function that returns a Widget ( From what we got so far Widget containing Widgets isn't far off)
  Widget _buildSuggestions() {
    // Interesting ... properties include padding styling
    return ListView.builder(
        // Why would you give a const? Turns out you are allow to give constant values
        padding: const EdgeInsets.all(16.0),
        // On Demand Widget Creator, returns a widget
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider(color: Colors.grey);

          final index = i ~/ 2; /* ~/, forces integer return */
          if (index >= _suggestions.length) {
            // Nice stuff with the iterable
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      // Has Title, trailing .. predefined positions for Widgets
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
          // Check that saved pair was ci
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      // Event Function (Good practice would be to use 'onEvent' to distingish an Event)
      onTap: () {
        setState(() {
          // print("Tap Triggered");
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
  // #docregion RWS-class-only
}
// #enddocregion RandomWordsState, RWS-class-only

// #docregion RandomWords (STATELESS)
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() =>
      new RandomWordsState(); // just does what is in build
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    // setState will make a 'change' to the state, rerunnign the build methods
    // A neat thing is that without calling setState, build() action won't be recalled i.e. no change would occur
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
