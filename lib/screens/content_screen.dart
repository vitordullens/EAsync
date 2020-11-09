import 'package:easync_ihc/screens/exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ContentScreen extends StatefulWidget {
  ContentScreen({this.content, this.json});
  final Map<String, dynamic> content, json;
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    this.initializePlayer();
  }

  Future<void> initializePlayer() async {
    _controller = VideoPlayerController.asset('assets/videos/cap1.mp4');
    await _controller.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      looping: true,
      aspectRatio: _controller.value.aspectRatio,
      autoInitialize: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Capítulo 1"),
          backgroundColor: Color(0xFF6CA8F1),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 20.0,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/cap1.png')),
                SizedBox(height: 30),
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Center(
                    child: _chewieController != null &&
                            _chewieController
                                .videoPlayerController.value.initialized
                        ? Chewie(
                            controller: _chewieController,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 20),
                              Text('Loading'),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: 30),
                Text("${widget.content['conteudo']}"),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFF6CA8F1),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExerciseScreen(
                        questions: widget.content['perguntas'],
                        json: widget.json
                      )),
            );
          },
          icon: Icon(
            Icons.notes_rounded,
          ),
          label: Text("Exercícios"),
        ));
  }
}
