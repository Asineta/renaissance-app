import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class ChewieWidget extends StatefulWidget {
  const ChewieWidget({
    Key? key,
    required this.srcs,
  }) : super(key: key);

  final String srcs;

  @override
  State<StatefulWidget> createState() {
    return _ChewieWidgetState();
  }
}

class _ChewieWidgetState extends State<ChewieWidget> {
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    if(widget.srcs != null || widget.srcs.isNotEmpty){
      initializePlayer();
    }else{
      Fluttertoast.showToast(
        msg: "Something went wrong",
        toastLength: Toast.LENGTH_LONG,
        fontSize: 18.0,
      );
    }
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }


  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.networkUrl(Uri.parse(widget.srcs.toString()));
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);

    _createChewieController();


    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: false,
      progressIndicatorDelay: const Duration(milliseconds: 0),
      hideControlsTimer: const Duration(seconds: 1),
      showOptions: false
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.adaptive.arrow_back_outlined, color: Colors.black,),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                    ? Chewie(
                        controller: _chewieController!,
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Loading'),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
