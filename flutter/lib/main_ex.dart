import 'dart:async';

import 'package:flutter/material.dart';
/*import 'package:flutter_lyric/lyrics_reader.dart';*/

void main() => runApp(MyApp());

const maxTimeInSeconds = 700;

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
  List<String> _playlist = ['The star', 'キセキ'];
  TextEditingController _songController = TextEditingController();
  Timer? _timer;
  List<String> _currentLyrics = []; // 現在の歌詞を保持するリスト

  String _secondsToTime(double seconds) {
    int totalSeconds = seconds.toInt();
    int minutes = totalSeconds ~/ 60;
    int remainingSeconds = totalSeconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_sliderValue + 1 <= maxTimeInSeconds) {
        setState(() {
          _sliderValue += 1;
        });
      } else {
        _stopTimer();
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  _stopTimer() {
    _timer?.cancel();
  }

  _updateLyrics(String songTitle) {
    if (songTitle == 'The star') {
      setState(() {
        _currentLyrics = [
          'Twinkle, twinkle, little star,',
          'How I wonder what you are!',
          'Up above the world so high,',
          'Like a diamond in the sky.',
          'Twinkle, twinkle, little star,',
          'How I wonder what you are!',
        ];
      });
    } else if (songTitle == 'キセキ') {
      setState(() {
        _currentLyrics = [
          '明日、今日よりも好きになれる',
          '溢れる想いが止まらない',
          '今もこんなに好きでいるのに\n言葉に出来ない',
          '君のくれた日々が積み重なり\n過ぎ去った日々2人歩いた『軌跡』',
          '僕らの出逢いがもし偶然ならば?\n運命ならば?',
          '君に巡り合えた\nそれって『奇跡』',
        ];
      });
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double textSize = (width ~/ 100) * 4.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player UI'),
      ),
      body: Row(
        children: [
          // プレイリスト
          Container(
            width: 170,
            color: Colors.grey[300],
            child: Column(
              children: [
                ..._playlist
                    .map((song) => GestureDetector(
                          onTap: () {
                            setState(() {
                              if (song == 'The star') {
                                _currentLyrics = [
                                  'Twinkle, twinkle, little star,',
                                  'How I wonder what you are!',
                                  'Up above the world so high,',
                                  'Like a diamond in the sky.',
                                  'Twinkle, twinkle, little star,',
                                  'How I wonder what you are!',
                                ];
                              } else if (song == 'キセキ') {
                                _currentLyrics = [
                                  '明日、今日よりも好きになれる',
                                  '溢れる想いが止まらない',
                                  '今もこんなに好きでいるのに',
                                  '言葉に出来ない',
                                  '君のくれた日々が積み重なり',
                                  '過ぎ去った日々2人歩いた『軌跡』',
                                  '僕らの出逢いがもし偶然ならば?',
                                  '運命ならば?',
                                  '君に巡り合えた それって『奇跡』'
                                ];
                              }
                              _sliderValue = 0; // 進行バーを0にリセット
                              _isPlaying = false; // 再生を停止
                              _stopTimer(); // タイマーを停止
                            });
                          },
                          child: ListTile(title: Text(song)),
                        ))
                    .toList(),
                TextField(
                    controller: _songController,
                    decoration: InputDecoration(hintText: '  Add new song...')),
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
                        children: _currentLyrics.asMap().entries.map((entry) {
                          int idx = entry.key;
                          String line = entry.value;

                          // 3行目の場合、強調スタイルを適用
                          bool isHighlighted = idx == 2;
                          return Text(
                            line,
                            style: TextStyle(
                              fontSize: textSize,
                              color: isHighlighted
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: isHighlighted
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center, // この行を追加
                          );
                        }).toList(),
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
                          max: maxTimeInSeconds.toDouble(),
                        ),
                      ),
                      Text(_secondsToTime(_sliderValue))
                    ],
                  ),
                  // ボタン群
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(Icons.skip_previous, size: 32),
                          onPressed: () {}),
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 32),
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
                      IconButton(
                          icon: Icon(Icons.skip_next, size: 32),
                          onPressed: () {}),
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
