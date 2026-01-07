import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UploadResumeScreen  extends StatelessWidget {
  final String company;
  final String title;
  final String location;
  final List<String> tags;
  final String posted;
  final String? salary;

  const UploadResumeScreen ({
    super.key,
    required this.company,
    required this.title,
    required this.location,
    required this.tags,
    required this.posted,
    this.salary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (kDebugMode) {
      print('\x1B[33mUploadResumeScreen Opened\x1B[0m');
      print('\x1B[33mTitle: $title\x1B[0m');
      print('\x1B[33mCompany: $company\x1B[0m');
      print('\x1B[33mLocation: $location\x1B[0m');
      print('\x1B[33mTags: ${tags.join(', ')}\x1B[0m');
      print('\x1B[33mPosted: $posted\x1B[0m');
      if (salary != null) {
        print('\x1B[33mSalary: $salary\x1B[0m');
      }
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color:theme.textTheme.bodyLarge?.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Create Profile",
          style: TextStyle(fontWeight: FontWeight.w600,color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (kDebugMode) {
                print('\x1B[33mSkip Upload Pressed\x1B[0m');
              }
            },
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          /// Progress Bar
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
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: theme.brightness == Brightness.dark
                      ? [
                          Colors.blue.withOpacity(0.1),
                          Colors.transparent,
                        ]
                      : [
                          Colors.blue.withOpacity(0.12),
                          Colors.blue.withOpacity(0.05),
                        ],
                ),
                color: theme.brightness == Brightness.dark
                    ? const Color(0xFF242526)
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                    color: Colors.blue.withOpacity(0.1),
                  )
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
                                ? const [
                                    Color(0xFF2A2B2E),
                                    Color(0xFF1E1F20)
                                  ]
                                : const [
                                    Colors.white,
                                    Color(0xFFE7E9ED)
                                  ],
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

          /// Upload Button
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
                      elevation: 8,
                      shadowColor: Colors.blue.withOpacity(0.4),
                    ),
                    onPressed: () {
                      // TODO: Implement file picker
                      if (kDebugMode) {
                        print('\x1B[33mUpload Resume Button Pressed\x1B[0m');
                      }
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text(
                      "Upload Resume",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Max file size: 5MB",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Progress Widget
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

// File Type Chip
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
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
