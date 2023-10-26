import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player UI'),
      ),
      body: Row(
        children: [
          // ③ Playlist
          Container(
            width: 200,
            color: Colors.grey[300],
            child: Column(
              children: [
                ListTile(title: Text('Song 1')),
                ListTile(title: Text('Song 2')),
                ListTile(title: Text('Song 3')),
                ElevatedButton(
                  onPressed: () {
                    // Add song to playlist
                  },
                  child: Text('Add Song'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // ① Lyrics display
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        'Here are the lyrics of the song...',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  // ④ Progress bar
                  Slider(
                    value: 50, // Example value
                    onChanged: (value) {
                      // Handle slider value change
                    },
                    min: 0,
                    max: 100,
                  ),
                  // ② Play & Stop buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle play
                        },
                        child: Icon(Icons.play_arrow),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle stop
                        },
                        child: Icon(Icons.stop),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/*import 'dart:async';
import 'package:flutter/material.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Uncomment below to use Firebase

      // await Firebase.initializeApp(
      //   options: DefaultFirebaseOptions.currentPlatform,
      // );

      runApp(const MyApp());
    },
    (error, stackTrace) {
      print('runZonedGuarded: Caught error in my root zone.');
      print('error\n$error');
      print('stacktrace\n$stackTrace');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
*/