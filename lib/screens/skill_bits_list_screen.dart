import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'skill_bit_record_screen.dart';

class SkillBitsListScreen extends StatefulWidget {
  const SkillBitsListScreen({super.key});

  @override
  State<SkillBitsListScreen> createState() => _SkillBitsListScreenState();
}

class _SkillBitsListScreenState extends State<SkillBitsListScreen> {
  List<File> _skillVideos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSkillVideos();
  }

  Future<void> _loadSkillVideos() async {
    setState(() => _isLoading = true);
    try {
      final docs = await getApplicationDocumentsDirectory();
      final dir = Directory('${docs.path}/skill_bits');
      if (await dir.exists()) {
        final files = dir
            .listSync()
            .whereType<File>()
            .where((f) => f.path.toLowerCase().endsWith('.mp4'))
            .toList();
        files.sort(
            (a, b) => b.statSync().modified.compareTo(a.statSync().modified));
        setState(() {
          _skillVideos = files;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print('Error loading skill videos: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteVideo(File file) async {
    try {
      await file.delete();
      _loadSkillVideos();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Skill bit deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting video: $e')),
        );
      }
    }
  }

  void _showDeleteConfirmation(File file) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Skill Bit'),
        content: const Text('Are you sure you want to delete this skill bit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteVideo(file);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Skill Bits'),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _skillVideos.isEmpty
              ? _buildEmptyState()
              : _buildVideoList(),
      floatingActionButton: _skillVideos.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SkillBitRecordScreen(),
                  ),
                );
                if (result == true) {
                  _loadSkillVideos();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Skill Bit'),
              backgroundColor: const Color(0xFF1877F2),
            )
          : null,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_camera_front_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No Skill Bits Yet',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Showcase your skills by recording your first skill bit',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SkillBitRecordScreen(),
                  ),
                );
                if (result == true) {
                  _loadSkillVideos();
                }
              },
              icon: const Icon(Icons.video_call),
              label: const Text('Record Skill Bit'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoList() {
    return RefreshIndicator(
      onRefresh: _loadSkillVideos,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _skillVideos.length,
        itemBuilder: (context, index) {
          final video = _skillVideos[index];
          final fileName =
              video.path.split(Platform.pathSeparator).last.split('.').first;
          final dateStr = video.statSync().modified;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VideoPlayerScreen(videoFile: video),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Thumbnail placeholder
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1877F2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.play_circle_outline,
                        size: 40,
                        color: Color(0xFF1877F2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Video info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fileName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Recorded on ${dateStr.day}/${dateStr.month}/${dateStr.year}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${dateStr.hour.toString().padLeft(2, '0')}:${dateStr.minute.toString().padLeft(2, '0')}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[500],
                                    ),
                          ),
                        ],
                      ),
                    ),
                    // Delete button
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _showDeleteConfirmation(video),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Video Player Screen
class VideoPlayerScreen extends StatefulWidget {
  final File videoFile;

  const VideoPlayerScreen({super.key, required this.videoFile});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    _controller = VideoPlayerController.file(widget.videoFile);
    try {
      await _controller.initialize();
      setState(() => _isInitialized = true);
      _controller.play();
    } catch (e) {
      print('Error initializing video player: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Skill Bit',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isInitialized
          ? Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                // Video controls at bottom
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
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
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: Color(0xFF1877F2),
                            bufferedColor: Colors.grey,
                            backgroundColor: Colors.white24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ValueListenableBuilder(
                              valueListenable: _controller,
                              builder: (context, value, child) {
                                return Text(
                                  _formatDuration(value.position),
                                  style: const TextStyle(color: Colors.white),
                                );
                              },
                            ),
                            Text(
                              _formatDuration(_controller.value.duration),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.replay_10,
                                  color: Colors.white, size: 32),
                              onPressed: () {
                                final newPosition = _controller.value.position -
                                    const Duration(seconds: 10);
                                _controller.seekTo(newPosition);
                              },
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_filled,
                                color: Colors.white,
                                size: 64,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                });
                              },
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              icon: const Icon(Icons.forward_10,
                                  color: Colors.white, size: 32),
                              onPressed: () {
                                final newPosition = _controller.value.position +
                                    const Duration(seconds: 10);
                                _controller.seekTo(newPosition);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
    );
  }
}
