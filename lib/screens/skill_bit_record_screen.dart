import 'dart:io';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

class SkillBitRecordScreen extends StatefulWidget {
  const SkillBitRecordScreen({super.key});

  @override
  State<SkillBitRecordScreen> createState() => _SkillBitRecordScreenState();
}

class _SkillBitRecordScreenState extends State<SkillBitRecordScreen> {
  CameraController? _cameraController;
  CameraDescription? _frontCamera;
  bool _isInitialized = false;
  bool _isRecording = false;
  bool _isPaused = false;
  XFile? _recordedFile;
  VideoPlayerController? _playerController;
  VideoPlayerController? _questionVideoController;
  bool _questionVideoInitialized = false;
  Stopwatch _stopwatch = Stopwatch();
  Timer? _ticker;
  String _recordingDuration = '00:00';
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initCamera();
    _initQuestionVideo();
  }

  Future<void> _initQuestionVideo() async {
    try {
      _questionVideoController =
          VideoPlayerController.asset('assets/Video/Question.mp4');
      await _questionVideoController!.initialize();
      await _questionVideoController!.setLooping(false);
      setState(() => _questionVideoInitialized = true);
    } catch (e) {
      print('Error initializing question video: $e');
    }
  }

  Future<void> _initCamera() async {
    final camPerm = await Permission.camera.request();
    final micPerm = await Permission.microphone.request();

    if (!camPerm.isGranted || !micPerm.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Camera and microphone permissions are required'),
          ),
        );
      }
      return;
    }

    final cameras = await availableCameras();
    _frontCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(
      _frontCamera!,
      ResolutionPreset.high,
      enableAudio: true,
    );

    await _cameraController!.initialize();
    if (!mounted) return;
    setState(() => _isInitialized = true);
  }

  void _startTicker() {
    _ticker = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (!mounted) return;
      final elapsed = _stopwatch.elapsed;
      setState(() {
        _recordingDuration =
            '${elapsed.inMinutes.toString().padLeft(2, '0')}:${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
      });
    });
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  Future<void> _startRecording() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    try {
      await _cameraController!.startVideoRecording();
      _stopwatch.reset();
      _stopwatch.start();
      _startTicker();

      // Start playing question video
      if (_questionVideoController != null && _questionVideoInitialized) {
        await _questionVideoController!.seekTo(Duration.zero);
        await _questionVideoController!.play();
      }

      setState(() => _isRecording = true);
    } catch (e) {
      print('Error starting recording: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error starting recording: $e')),
        );
      }
    }
  }

  Future<void> _stopRecording() async {
    if (_cameraController == null || !_isRecording) return;
    try {
      final file = await _cameraController!.stopVideoRecording();
      _stopTicker();
      _stopwatch.stop();

      // Stop question video
      if (_questionVideoController != null) {
        await _questionVideoController!.pause();
        await _questionVideoController!.seekTo(Duration.zero);
      }

      setState(() {
        _isRecording = false;
        _isPaused = false;
        _recordedFile = file;
      });
      await _initPlayer(file);
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _pauseRecording() async {
    if (_cameraController == null || !_isRecording || _isPaused) return;
    try {
      await _cameraController!.pauseVideoRecording();
      _stopwatch.stop();
      _stopTicker();

      // Pause question video
      if (_questionVideoController != null) {
        await _questionVideoController!.pause();
      }

      setState(() => _isPaused = true);
    } catch (e) {
      print('Error pausing recording: $e');
    }
  }

  Future<void> _resumeRecording() async {
    if (_cameraController == null || !_isRecording || !_isPaused) return;
    try {
      await _cameraController!.resumeVideoRecording();
      _stopwatch.start();
      _startTicker();

      // Resume question video
      if (_questionVideoController != null && _questionVideoInitialized) {
        await _questionVideoController!.play();
      }

      setState(() => _isPaused = false);
    } catch (e) {
      print('Error resuming recording: $e');
    }
  }

  Future<void> _initPlayer(XFile file) async {
    _playerController = VideoPlayerController.file(File(file.path));
    try {
      await _playerController!.initialize();
      setState(() {});
    } catch (e) {
      print('Error initializing player: $e');
    }
  }

  Future<void> _saveVideo() async {
    if (_recordedFile == null) return;

    // Show dialog to get video title
    final title = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Skill Bit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Give your skill bit a name:'),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Skill Title',
                hintText: 'e.g., Flutter Development, Public Speaking',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = _titleController.text.trim();
              if (text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a title')),
                );
                return;
              }
              Navigator.pop(context, text);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (title == null || title.isEmpty) return;

    try {
      final docs = await getApplicationDocumentsDirectory();
      final dir = Directory('${docs.path}/skill_bits');
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      // Create filename with timestamp to ensure uniqueness
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = '${title.replaceAll(' ', '_')}_$timestamp.mp4';
      final newPath = '${dir.path}/$fileName';

      await File(_recordedFile!.path).copy(newPath);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Skill bit saved successfully!')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      print('Error saving video: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving video: $e')),
        );
      }
    }
  }

  void _retakeVideo() {
    setState(() {
      _recordedFile = null;
      _playerController?.dispose();
      _playerController = null;
      _stopwatch.reset();
      _isPaused = false;
      _recordingDuration = '00:00';
    });
  }

  void _switchCamera() async {
    if (_cameraController == null) return;

    final cameras = await availableCameras();
    final currentLens = _cameraController!.description.lensDirection;

    CameraDescription? newCamera;
    if (currentLens == CameraLensDirection.front) {
      newCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
    } else {
      newCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
    }

    if (newCamera.lensDirection == currentLens) return;

    await _cameraController!.dispose();

    _cameraController = CameraController(
      newCamera,
      ResolutionPreset.high,
      enableAudio: true,
    );

    await _cameraController!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _playerController?.dispose();
    _questionVideoController?.dispose();
    _stopTicker();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Record Skill Bit',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          if (_recordedFile == null && _isInitialized && !_isRecording)
            IconButton(
              icon: const Icon(Icons.flip_camera_ios),
              onPressed: _switchCamera,
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (!_isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_recordedFile != null && _playerController != null) {
      return _buildPreviewMode();
    }

    return _buildRecordMode();
  }

  Widget _buildRecordMode() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Full-screen camera preview
        if (_cameraController != null && _cameraController!.value.isInitialized)
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _cameraController!.value.previewSize!.height,
                height: _cameraController!.value.previewSize!.width,
                child: CameraPreview(_cameraController!),
              ),
            ),
          ),

        // Question video overlay (bottom right corner - small size)
        if (_isRecording &&
            _questionVideoController != null &&
            _questionVideoInitialized)
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _questionVideoController!.value.size.width,
                    height: _questionVideoController!.value.size.height,
                    child: VideoPlayer(_questionVideoController!),
                  ),
                ),
              ),
            ),
          ),

        // Recording indicator
        if (_isRecording)
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: _isPaused ? Colors.orange : Colors.red,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: (_isPaused ? Colors.orange : Colors.red)
                          .withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _isPaused
                          ? 'PAUSED $_recordingDuration'
                          : 'REC $_recordingDuration',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Instructions
        if (!_isRecording)
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.videocam,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Showcase your skill!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap the button below to start recording',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Record button with better design
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pause/Resume button (only show when recording)
              if (_isRecording)
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: GestureDetector(
                    onTap: _isPaused ? _resumeRecording : _pauseRecording,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isPaused ? Icons.play_arrow : Icons.pause,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ),
                ),

              // Main record/stop button
              GestureDetector(
                onTap: _isRecording ? _stopRecording : _startRecording,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _isRecording
                            ? Colors.red.withOpacity(0.5)
                            : Colors.white.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _isRecording ? 35 : 70,
                      height: _isRecording ? 35 : 70,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape:
                            _isRecording ? BoxShape.rectangle : BoxShape.circle,
                        borderRadius:
                            _isRecording ? BorderRadius.circular(6) : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewMode() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Full-screen video preview
        Center(
          child: AspectRatio(
            aspectRatio: _playerController!.value.aspectRatio,
            child: VideoPlayer(_playerController!),
          ),
        ),

        // Video controls overlay
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Play/Pause button
                IconButton(
                  icon: Icon(
                    _playerController!.value.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    color: Colors.white,
                    size: 64,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_playerController!.value.isPlaying) {
                        _playerController!.pause();
                      } else {
                        _playerController!.play();
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _retakeVideo,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retake'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _saveVideo,
                      icon: const Icon(Icons.check_circle),
                      label: const Text('Save'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1877F2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Preview label
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Text(
                'Preview',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
