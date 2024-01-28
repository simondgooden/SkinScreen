import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

// THE APP IS ACTUALLY A WIDGET, everything you see on screen is a widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // build method is called when the widget is created
    return ChangeNotifierProvider(
      // ChangeNotifierProvider is a widget that provides a value to all its children
      create: (context) =>
          MyAppState(), // MyAppState is created here and provided by ChangeNotifierProvider
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 90, 105, 236)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// STATE MAWNAGEMENT using ChangeNotifier class which MyAppState is a class that extends it
class MyAppState extends ChangeNotifier {
  // ChangeNotifier is a class that notifies of change
  var current = WordPair.random();

  void getNext() {
    // getNext will be called when the button is pressed
    current = WordPair.random(); // generates a new random WordPair
    notifyListeners(); // notifies all listeners of the change, when they are notified they rebuild with the new values
  }

  var favorites = <WordPair>[]; // favorites is a list of WordPairs
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners(); // notifies all listeners of the change, when they are notified they rebuild with the new values
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: true,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                // callback function that is called when a destination is selected
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favorites = appState.favorites;
    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet'),
      );
    }
    return ListView(
      // column you can scroll is list view
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Text('You have ' '${appState.favorites.length} favorites')),
        for (var pair in favorites)
          ListTile(
            leading: Icon((Icons.favorite)),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  // BigCard is a widget that displays a WordPair
  const BigCard({
    // constructor for BigCard
    super.key, // super is used to call the constructor of the parent class
    required this.pair, // required means that the variable must be passed to the constructor
  });

  final WordPair
      pair; // final means that the variable can't be changed after it is initialized

  @override
  Widget build(BuildContext context) {
    // build method is called when the widget is created
    var theme = Theme.of(
        context); // final means that the variable can't be changed after it is initialized. context is a property of the widget that contains information about the widget
    var style = theme.textTheme.displayMedium!.copyWith(
      // ! means that the variable can't be null, copy with is a method that copies the style with your changes
      color: theme.colorScheme.onPrimary, //  color is a property of style
    ); // style is a variable that contains the style of the text
    return Card(
      // Card is a widget that displays a card
      elevation: 8,
      color: theme.colorScheme
          .primary, // color is a property of Card that sets the color of the card
      child: Padding(
        // Padding is a widget that adds padding to its child
        padding: const EdgeInsets.all(
            20), // EdgeInsets is a class that defines padding
        child: Text(
          pair.asLowerCase,
          style: style,
        ),
      ),
    );
  }
}



