import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UploadResumeScreen extends StatefulWidget {
  final String company;
  final String title;
  final String location;
  final List<String> tags;
  final String posted;
  final String? salary;

  const UploadResumeScreen({
    super.key,
    required this.company,
    required this.title,
    required this.location,
    required this.tags,
    required this.posted,
    this.salary,
  });

  @override
  State<UploadResumeScreen> createState() => _UploadResumeScreenState();
}

class _UploadResumeScreenState extends State<UploadResumeScreen> {
  File? _selectedFile;

  // ---------- Pick Resume ----------
  Future<void> _pickResume() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result == null) return;

      final file = File(result.files.single.path!);
      final fileSize = await file.length();

      if (fileSize > 5 * 1024 * 1024) {
        _showSnackBar("File size must be under 5MB");
        return;
      }

      setState(() {
        _selectedFile = file;
      });

      if (kDebugMode) {
        print("Selected file: ${file.path}");
      }
    } catch (e) {
      _showSnackBar("Failed to pick file");
    }
  }

  //submit resume
  void _submitResume() {
    _showSnackBar("Resume submitted successfully");
    
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: theme.textTheme.bodyLarge?.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Create Profile",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Text("Skip", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
      body: Column(
        children: [
          /// Progress
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                _Progress(active: true),
                _Progress(),
                _Progress(),
              ],
            ),
          ),

          const Spacer(),

          /// Upload Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: theme.cardColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                    color: Colors.blue.withOpacity(0.1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Icon
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: theme.brightness == Brightness.dark
                                ? const [Color(0xFF2A2B2E), Color(0xFF1E1F20)]
                                : const [Colors.white, Color(0xFFE7E9ED)],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 12,
                              color: Colors.black12,
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.description,
                          size: 56,
                          color: Color(0xFF1877F2),
                        ),
                      ),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF409CFF),
                          ),
                          child: const Icon(
                            Icons.cloud_upload,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Upload your Resume",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "We'll analyze your resume and auto-create your profile to match you with top jobs.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// File Types
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _FileType(label: "PDF", icon: Icons.picture_as_pdf),
                      SizedBox(width: 12),
                      _FileType(label: "DOC", icon: Icons.article),
                      SizedBox(width: 12),
                      _FileType(label: "DOCX", icon: Icons.description),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          /// Upload + Submit
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1877F2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _pickResume,
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Upload Resume"),
                  ),
                ),

                if (_selectedFile != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    "Selected: ${_selectedFile!.path.split('/').last}",
                    style:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _submitResume,
                      child: const Text("Submit"),
                    ),
                  ),
                ],

                const SizedBox(height: 8),
                const Text("Max file size: 5MB",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Progress Bar
class _Progress extends StatelessWidget {
  final bool active;
  const _Progress({this.active = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 4,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: active ? const Color(0xFF1877F2) : Colors.grey.shade300,
        ),
      ),
    );
  }
}

/// File Type Chip
class _FileType extends StatelessWidget {
  final String label;
  final IconData icon;

  const _FileType({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          const SizedBox(width: 6),
          Text(label,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
