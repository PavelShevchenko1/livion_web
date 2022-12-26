import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:video_player/video_player.dart';
import 'package:hovering/hovering.dart';
import 'screens/test.dart';
import 'screens/auth.dart';
import 'screens/testacccees.dart';
import 'jitsi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDu-vEFUKyBMElcFyFmOlkCVHOUhMo_khY",
          authDomain: "akyaylamessaging.firebaseapp.com",
          databaseURL:
              "https://akyaylamessaging-default-rtdb.europe-west1.firebasedatabase.app",
          projectId: "akyaylamessaging",
          storageBucket: "akyaylamessaging.appspot.com",
          messagingSenderId: "501969918249",
          appId: "1:501969918249:web:d20525e8d678b2e73abf38",
          measurementId: "G-66V29VDV3F"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        TestUrl.route: (context) => TestUrl(),
        Auth.route: (context) => Auth(),
        Access.route: (context) => Access(),
        Meeting.route: (context) => Meeting()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('data/data1');
  String tx = "?";
  late VideoPlayerController _controller;
  late VideoPlayerController _fcontroller;

  @override
  void initState() {
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateStarCount(data);
    });
    _controller = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/livi-on1.appspot.com/o/videos%2F%D0%92%D0%B8%D0%B4%D0%B5%D0%BE_%D1%81%D1%8A%D1%91%D0%BC%D0%BA%D0%B0_%D1%80%D0%B5%D0%BA%D0%BB%D0%B0%D0%BC%D0%B0_%D1%81%D0%BF%D0%BE%D1%80%D1%82_%D0%B7%D0%B0%D0%BB_%D0%9F%D1%80%D0%BE%D0%BC%D0%BE_Superior_fit_GYM.mp4?alt=media&token=7ab2d0b3-6179-4a2c-b4cc-550b33a4e3d4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _fcontroller = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/livi-on1.appspot.com/o/videos%2F%D0%92%D0%B8%D0%B4%D0%B5%D0%BE_%D1%81%D1%8A%D1%91%D0%BC%D0%BA%D0%B0_%D1%80%D0%B5%D0%BA%D0%BB%D0%B0%D0%BC%D0%B0_%D1%81%D0%BF%D0%BE%D1%80%D1%82_%D0%B7%D0%B0%D0%BB_%D0%9F%D1%80%D0%BE%D0%BC%D0%BE_Superior_fit_GYM.mp4?alt=media&token=7ab2d0b3-6179-4a2c-b4cc-550b33a4e3d4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  updateStarCount(x) {
    setState(() {
      tx = x.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> videoControlFull(bool isP) async {
      return await showDialog(
          context: context,
          builder: (context) {
            isP ? _fcontroller.play() : null;
            return Material(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                child: Stack(
                  children: [
                    _fcontroller.value.isInitialized
                        ? Center(
                            child: AspectRatio(
                              aspectRatio: _fcontroller.value.aspectRatio,
                              child: VideoPlayer(_fcontroller),
                            ),
                          )
                        : Container(),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: HoverCrossFadeWidget(
                            firstChild: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              color: Colors.transparent,
                            ),
                            secondChild: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              color: Colors.black,
                              child: ValueListenableBuilder(
                                  valueListenable: _fcontroller,
                                  builder: (_, VideoPlayerValue v, __) {
                                    String f = "";
                                    if (v.position.inSeconds < 10) {
                                      f = "0";
                                    }
                                    return Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                v.isPlaying
                                                    ? _fcontroller.pause()
                                                    : _fcontroller.play();
                                                setState(() {});
                                              },
                                              child: Icon(
                                                _fcontroller.value.isPlaying
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SliderTheme(
                                                data: SliderThemeData(
                                                    overlayShape:
                                                        SliderComponentShape
                                                            .noOverlay,
                                                    thumbShape:
                                                        SliderComponentShape
                                                            .noThumb),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  width: 250,
                                                  child: Slider(
                                                    activeColor: Colors.pink,
                                                    inactiveColor:
                                                        Colors.pink.shade100,
                                                    min: 0.0,
                                                    max: _fcontroller.value
                                                        .duration.inMilliseconds
                                                        .toDouble(),
                                                    value: v
                                                        .position.inMilliseconds
                                                        .toDouble(),
                                                    onChanged: (v) {
                                                      _fcontroller.seekTo(
                                                          Duration(
                                                              milliseconds:
                                                                  v.toInt()));
                                                    },
                                                  ),
                                                )),
                                            Text(
                                              "${v.position.inMinutes}:$f${v.position.inSeconds} / ${v.duration.inMinutes}:${v.duration.inSeconds - (60 * v.duration.inMinutes)}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              _fcontroller.value.volume != 0.0
                                                  ? Icons.volume_up_rounded
                                                  : Icons.volume_off_rounded,
                                              color: Colors.white,
                                            ),
                                            SliderTheme(
                                                data: SliderThemeData(
                                                    overlayShape:
                                                        SliderComponentShape
                                                            .noOverlay,
                                                    thumbShape:
                                                        SliderComponentShape
                                                            .noThumb),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  width: 80,
                                                  child: Slider(
                                                      min: 0.0,
                                                      max: 1.0,
                                                      value: v.volume,
                                                      onChanged: (v) {
                                                        _fcontroller
                                                            .setVolume(v);
                                                      }),
                                                )),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop(
                                                    _fcontroller
                                                        .value.isPlaying);
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.fullscreen_exit,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            duration: Duration(milliseconds: 200))),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _fcontroller.value.isPlaying
                              ? _fcontroller.pause()
                              : _fcontroller.play();
                        });
                      },
                      child: HoverCrossFadeWidget(
                        duration: Duration(milliseconds: 500),
                        firstChild: Container(
                          width: 400,
                          height: 400,
                          color: Colors.transparent,
                        ),
                        secondChild: Container(
                          width: 400,
                          height: 400,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.2),
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: _fcontroller,
                            builder: (_, VideoPlayerValue v, __) {
                              return Icon(
                                v.isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 50,
                                color: Colors.white,
                              );
                            },
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            );
          });
    }

    Widget videoControlSmall = Container(
      width: 600,
      height: 40,
      color: Colors.black.withOpacity(0.5),
      child: ValueListenableBuilder(
          valueListenable: _controller,
          builder: (_, VideoPlayerValue v, __) {
            String f = "";
            if (v.position.inSeconds < 10) {
              f = "0";
            }
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        v.isPlaying ? _controller.pause() : _controller.play();
                        setState(() {});
                      },
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                    SliderTheme(
                        data: SliderThemeData(
                            overlayShape: SliderComponentShape.noOverlay,
                            thumbShape: SliderComponentShape.noThumb),
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 250,
                          child: Slider(
                            activeColor: Colors.pink,
                            inactiveColor: Colors.pink.shade100,
                            min: 0.0,
                            max: _controller.value.duration.inMilliseconds
                                .toDouble(),
                            value: v.position.inMilliseconds.toDouble(),
                            onChanged: (v) {
                              _controller
                                  .seekTo(Duration(milliseconds: v.toInt()));
                            },
                          ),
                        )),
                    Text(
                      "${v.position.inMinutes}:$f${v.position.inSeconds} / ${v.duration.inMinutes}:${v.duration.inSeconds - (60 * v.duration.inMinutes)}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      _controller.value.volume != 0.0
                          ? Icons.volume_up_rounded
                          : Icons.volume_off_rounded,
                      color: Colors.white,
                    ),
                    SliderTheme(
                        data: SliderThemeData(
                            overlayShape: SliderComponentShape.noOverlay,
                            thumbShape: SliderComponentShape.noThumb),
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 80,
                          child: Slider(
                              min: 0.0,
                              max: 1.0,
                              value: v.volume,
                              onChanged: (v) {
                                _controller.setVolume(v);
                              }),
                        )),
                    GestureDetector(
                      onTap: () async {
                        _fcontroller.seekTo(_controller.value.position);
                        _fcontroller.setVolume(_controller.value.volume);
                        bool isP = _controller.value.isPlaying;
                        isP ? _controller.pause() : null;
                        bool isFP = await videoControlFull(isP);
                        setState(() {
                          _controller.seekTo(_fcontroller.value.position);
                          _controller.setVolume(_fcontroller.value.volume);
                          isFP ? _controller.play() : null;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.fullscreen_rounded,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Stack(
                children: [
                  Container(
                    width: 600,
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Container(),
                  ),
                  Positioned.fill(
                    bottom: 0,
                    child: HoverCrossFadeWidget(
                      duration: Duration(milliseconds: 500),
                      firstChild: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                      secondChild: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.red,
                        child: Stack(
                          children: [
                            Positioned(
                                child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                                child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent),
                                    child: Icon(
                                      _controller.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white.withOpacity(0.5),
                                      size: 200,
                                    )),
                              ),
                            )),
                            Positioned(
                                bottom: 0, right: 0, child: videoControlSmall)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              tx,
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, TestUrl.route);
                },
                icon: Icon(Icons.addchart),
                label: Text("data"))
          ],
        ),
      ),
    );
  }
}
