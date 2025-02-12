import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nawah/core/utils/crud.dart';
import 'package:nawah/features/dashboard/data/datasouce/home_remote_data_source.dart';
import 'package:nawah/features/dashboard/data/repository/home_repository.dart';
import 'package:nawah/features/dashboard/presentation/cubits/home/home_cubit.dart';
import 'package:nawah/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:nawah/features/home/presentation/screens/homeScreen.dart';
import 'package:nawah/features/quizzes/data/data_souce/quizzes_remote_data_souce.dart';
import 'package:nawah/features/quizzes/data/repository/quizzes_repository.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'features/quizzes/presentation/cubits/attend_quiz/attend_quiz_cubit.dart';
import 'features/quizzes/presentation/screens/attend_quiz_screen.dart';

void main() {
  final dio = Dio();
  runApp(ScreenUtilInit(
    designSize: const Size(440, 956),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: dio),
          ],
          child: BlocProvider(
            create: (context) => HomeCubit(
              HomeRepository(
                remoteDataSource: HomeRemoteDataSourceImpl(
                  Crud(dio: dio),
                ),
              ),
            )..getTeachers(),
            child: Home(),
          ),
        ),
      );
    },
  ));
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isBuffering = false;
  int aspectRatio = 2;
  final Dio _dio = Dio();

  // Add these variables for tracking buffering
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _bufferProgress = 0.0;

  // Replace this with your video URL
  final String videoUrl =
      'https://ghostwhite-penguin-556356.hostingersite.com/[TopCinema].My.Dad.the.Bounty.Hunter.S01E03.720p.NF.WEB-DL.mp4';

  // Add these new variables
  bool _showControls = true;
  bool _isFullScreen = false;
  bool _showForwardAnimation = false;
  bool _showRewindAnimation = false;
  Timer? _forwardAnimationTimer;
  Timer? _rewindAnimationTimer;

  // Add this variable to track if the widget is mounted
  bool _isMounted = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      // Configure Dio for streaming
      _dio.options.responseType = ResponseType.stream;
      _dio.options.headers = {
        'Range': 'bytes=0-', // Request content in chunks
      };

      _controller = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: false,
          allowBackgroundPlayback: false,
        ),
      );

      // Add listeners for buffering and position
      _controller.addListener(_videoListener);

      await _controller.initialize();

      setState(() {
        _isInitialized = true;
        _duration = _controller.value.duration;
      });
    } catch (e) {
      debugPrint('Error initializing video: $e');
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to load video: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _videoListener() {
    if (!_isMounted || !mounted) return;

    setState(() {
      final wasPlaying = _isPlaying;
      _isPlaying = _controller.value.isPlaying;
      _position = _controller.value.position;
      _isBuffering = _controller.value.isBuffering;

      if (!wasPlaying && _isPlaying) {
        _startAutoHideTimer();
      }

      if (_controller.value.buffered.isNotEmpty) {
        final buffered = _controller.value.buffered[0];
        _bufferProgress =
            buffered.end.inMilliseconds / _duration.inMilliseconds;
      }
    });
  }

  void _startAutoHideTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_isMounted && mounted && _isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  Widget _buildProgressBar() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            _formatDuration(_position),
            style: const TextStyle(color: Colors.white),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Buffer progress
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 4,
                  width: double.infinity,
                  color: Colors.grey[700],
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _bufferProgress,
                    child: Container(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                // Playback progress
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: SliderTheme(
                    data: const SliderThemeData(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                      trackHeight: 4,
                    ),
                    child: Slider(
                      value: _position.inMilliseconds.toDouble(),
                      min: 0,
                      max: _duration.inMilliseconds.toDouble(),
                      onChanged: (value) {
                        _controller
                            .seekTo(Duration(milliseconds: value.toInt()));
                      },
                      activeColor: Colors.white,
                      inactiveColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatDuration(_duration),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientBackground() {
    return AnimatedOpacity(
      opacity: _showControls ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoControls() {
    if (!_showControls) return const SizedBox.shrink();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  if (_isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                    _startAutoHideTimer();
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.replay_10,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                final position =
                    _controller.value.position - const Duration(seconds: 10);
                _controller.seekTo(position);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.forward_10,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                final position =
                    _controller.value.position + const Duration(seconds: 10);
                _controller.seekTo(position);
              },
            ),
            IconButton(
              icon: Icon(
                _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                color: Colors.white,
                size: 30,
              ),
              onPressed: _toggleFullScreen,
            ),
          ],
        ),
        _buildProgressBar(),
      ],
    );
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        aspectRatio = 1;
      } else {
        aspectRatio = 2;
      }
    });

    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });

    // Start auto-hide timer when showing controls and video is playing
    if (_showControls && _isPlaying) {
      _startAutoHideTimer();
    }
  }

  void _handleDoubleTapSeek(bool forward) {
    if (!_isMounted) return;

    const Duration seekDuration = Duration(seconds: 30);
    final Duration newPosition = forward
        ? _controller.value.position + seekDuration
        : _controller.value.position - seekDuration;

    setState(() {
      if (forward) {
        _showForwardAnimation = true;
        _forwardAnimationTimer?.cancel();
        _forwardAnimationTimer = Timer(const Duration(milliseconds: 800), () {
          if (_isMounted && mounted) {
            setState(() {
              _showForwardAnimation = false;
            });
          }
        });
      } else {
        _showRewindAnimation = true;
        _rewindAnimationTimer?.cancel();
        _rewindAnimationTimer = Timer(const Duration(milliseconds: 800), () {
          if (_isMounted && mounted) {
            setState(() {
              _showRewindAnimation = false;
            });
          }
        });
      }
    });

    _controller.seekTo(newPosition);
  }

  Widget _buildSeekAnimation(bool forward) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            forward ? Icons.fast_forward : Icons.fast_rewind,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(height: 4),
          const Text(
            '30',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final videoPlayer = AspectRatio(
      aspectRatio: _controller.value.aspectRatio / aspectRatio,
      child: VideoPlayer(_controller),
    );

    final playerStack = Stack(
      alignment: Alignment.center,
      children: [
        videoPlayer,
        if (_isBuffering)
          LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.white,
            size: 50,
          ),
        // Full screen gradient background
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: _showControls ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: !_isFullScreen
                      ? Alignment.bottomCenter
                      : Alignment.topLeft,
                  end: !_isFullScreen
                      ? Alignment.topCenter
                      : Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    if (_isFullScreen) Colors.transparent, // Middle transparent
                    if (_isFullScreen) Colors.black.withOpacity(0.7),
                    // Bottom gradient
                    if (!_isFullScreen) Colors.white.withOpacity(0.3),
                  ],
                  stops: _isFullScreen ? const [0.0, 0.5, 1.0] : [0, 0.3],
                  // Control gradient positions
                ),
              ),
            ),
          ),
        ),
        // Seek animations
        if (_showRewindAnimation)
          Positioned(
            left: 50,
            child: AnimatedOpacity(
              opacity: _showRewindAnimation ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: _buildSeekAnimation(false),
            ),
          ),
        if (_showForwardAnimation)
          Positioned(
            right: 50,
            child: AnimatedOpacity(
              opacity: _showForwardAnimation ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: _buildSeekAnimation(true),
            ),
          ),
        // Gesture handlers
        Positioned.fill(
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _toggleControls,
                  onDoubleTap: () => _handleDoubleTapSeek(false),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: _toggleControls,
                  onDoubleTap: () => _handleDoubleTapSeek(true),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Controls without gradient
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildVideoControls(),
        ),
      ],
    );

    if (_isFullScreen) {
      return WillPopScope(
        onWillPop: () async {
          if (_isFullScreen) {
            _toggleFullScreen();
            return false;
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Center(
              child: playerStack,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: _isInitialized
            ? playerStack
            : LoadingAnimationWidget.staggeredDotsWave(
                color: Theme.of(context).primaryColor,
                size: 50,
              ),
      ),
    );
  }

  @override
  void dispose() {
    _isMounted = false;
    _forwardAnimationTimer?.cancel();
    _rewindAnimationTimer?.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }
}
