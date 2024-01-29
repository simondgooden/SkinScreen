import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
// MyAppState is responsible for managing the state of the application.
// It extends ChangeNotifier to allow widgets to listen to changes in the state.
class MyAppState extends ChangeNotifier {
  var current = WordPair.random(); // Holds the current WordPair.
  var favorites = <WordPair>[]; // List to store favorited WordPairs.
  final String backendUrl = 'http://localhost:3000/favorites'; // URL of the backend server.

  MyAppState() {
    fetchFavorites(); // Fetch favorites from the server when the state is initialized.
  }

  void getNext() {
    current = WordPair.random(); // Generate a new random WordPair.
    notifyListeners(); // Notify listeners (widgets) that state has changed.
  }

  // Fetches favorites from the backend server.
  Future<void> fetchFavorites() async {
    try {
      final response = await http.get(Uri.parse(backendUrl));
      if (response.statusCode == 200) {
        List<dynamic> favs = json.decode(response.body)['favorites'];
        // Convert each word from the server into a WordPair.
        // Note: The server sends words as a single string, hence the empty string for the second part.
        favorites = favs.map((word) => WordPair(word, ' ')).toList();
        print("Fetched Favorites: $favorites"); // Log fetched favorites.
        notifyListeners(); // Update UI after fetching favorites.
      } else {
        print("Server Error: ${response.statusCode}"); // Log server error.
      }
    } catch (e) {
      print("Network Error: $e"); // Log network error.
    }
  }

  // Toggles the favorite status of the current WordPair.
  void toggleFavorite() {
    String currentWord = current.asLowerCase + ' '; // Convert the current WordPair to lowercase for comparison.
    bool isAlreadyFavorite = favorites.any((wordPair) => wordPair.asLowerCase == currentWord);
    print(currentWord); 

    if (isAlreadyFavorite) {
      // If the word is already a favorite, remove it.
      favorites.removeWhere((wordPair) => wordPair.asLowerCase == currentWord);
      removeFavorite(current); // Remove from the server.
      notifyListeners(); // Notify UI of the change.
    } else {
      // If it's not a favorite, add it.
      favorites.add(current);
      addFavorite(current); // Add to the server.
      notifyListeners(); // Notify UI of the change.
    }
  }

  // Adds a WordPair to the favorites on the server.
  Future<void> addFavorite(WordPair word) async {
    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'word': word.asPascalCase}),
      );
      if (response.statusCode == 201) {
        print("Added Favorite: $word"); // Log added favorite.
        fetchFavorites(); // Refresh the favorites list.
      } else {
        print("Server Error on Add: ${response.statusCode}"); // Log server error.
      }
    } catch (e) {
      print("Network Error on Add: $e"); // Log network error.
    }
  }

  // Removes a WordPair from the favorites on the server.
  Future<void> removeFavorite(WordPair word) async {
    try {
      final response = await http.delete(
        Uri.parse(backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'word': word.asPascalCase}),
      );
      if (response.statusCode == 200) {
        print("Removed Favorite: $word"); // Log removed favorite.
        fetchFavorites(); // Refresh the favorites list.
      } else {
        print("Server Error on Remove: ${response.statusCode}"); // Log server error.
      }
    } catch (e) {
      print("Network Error on Remove: $e"); // Log network error.
    }
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
      case 1:
        page = FavoritesPage();
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
    if (appState.favorites.any((wordPair) => wordPair.asLowerCase == pair.asLowerCase + ' ')) {
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
    RegExp regExp = RegExp(r'(?=[A-Z])');

    if (favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet'),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(20),
      children: favorites.map((pair) {
        // Store pair as a local variable and perform the split operation
        String pairFirst = pair.asString.split(regExp)[0];
        String pairSecond = pair.asString.split(regExp)[1];

        return ListTile(
          leading: Icon(Icons.favorite),
          title: Text(pair.asLowerCase),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              appState.removeFavorite(WordPair(pairFirst, pairSecond.trimRight()));
              print("Deleting Favorite: ${pair}"); // Log deletion
            },
          ),
        );
      }).toList(),
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



