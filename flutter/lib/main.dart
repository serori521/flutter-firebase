import 'dart:async';
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isPlaying = false;
  double _sliderValue = 0;
  List<String> _playlist = ['Song 1', 'Song 2', 'Song 3'];
  TextEditingController _songController = TextEditingController();
  Timer? _timer;

  // スライダーの値を時間に変換する関数
  String _sliderValueToTime(double value) {
    int totalSeconds = (300 * (value / 100)).toInt();
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  // 再生状態でスライダーを1秒ごとに進める関数
  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_sliderValue < 100) {
        setState(() {
          _sliderValue += 1/3;  // ここを修正しました
        });
      } else {
        _stopTimer();
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  // タイマーを停止する関数
  _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player UI'),
      ),
      body: Row(
        children: [
          // プレイリスト
          Container(
            width: 200,
            color: Colors.grey[300],
            child: Column(
              children: [
                ..._playlist.map((song) => ListTile(title: Text(song))).toList(),
                TextField(controller: _songController, decoration: InputDecoration(hintText: 'Add new song...')),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _playlist.add(_songController.text);
                      _songController.clear();
                    });
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
                  // 歌詞表示
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('Twinkle, twinkle, little star,', style: TextStyle(fontSize: 60, color: Colors.grey[400])),
                          Text('How I wonder what you are!', style: TextStyle(fontSize: 60, color: Colors.grey[400])),
                          Text('Up above the world so high,', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
                          Text('Like a diamond in the sky.', style: TextStyle(fontSize: 60, color: Colors.grey[400])),
                          Text('Twinkle, twinkle, little star,', style: TextStyle(fontSize: 60, color: Colors.grey[400])),
                          Text('How I wonder what you are!', style: TextStyle(fontSize: 60, color: Colors.grey[400])),
                        ],
                      ),
                    ),
                  ),
                  // 進行バー
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: _sliderValue,
                          onChanged: (value) {
                            setState(() {
                              _sliderValue = value;
                            });
                          },
                          min: 0,
                          max: 100,
                        ),
                      ),
                      Text(_sliderValueToTime(_sliderValue))
                    ],
                  ),
                  // ボタン群
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(icon: Icon(Icons.skip_previous, size: 32), onPressed: () {}),
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 32),
                        onPressed: () {
                          setState(() {
                            _isPlaying = !_isPlaying;
                            if (_isPlaying) {
                              _startTimer();
                            } else {
                              _stopTimer();
                            }
                          });
                        },
                      ),
                      IconButton(icon: Icon(Icons.skip_next, size: 32), onPressed: () {}),
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