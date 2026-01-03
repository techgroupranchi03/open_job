import 'package:flutter/material.dart';

class LearnerScreen extends StatelessWidget {
  const LearnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        SafeArea(
          bottom: false,
          child: Container(
            height: 60,
            child: Row(

              

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( 
                  'Learn',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

                IconButton(
                  icon: const Icon(Icons.person_outline, color: Colors.black),
                  onPressed: () {
                    debugPrint("Profile clicked");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.help_outline, color: Colors.black),
                  onPressed: () => debugPrint("Help clicked"),
                ),
              ],
            ),
          ),
        ),

        // Header
        Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Learning Hub',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 8),
                Text(
                  'Upgrade your skills and get hired',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 20),

        // Progress Section
        Text(
          'Your Progress',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 12),

        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Courses Completed',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '3/10',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Color(0xFF1877F2),
                              ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                LinearProgressIndicator(
                  value: 0.3,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation(Color(0xFF1877F2)),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 20),

        // Recommended Courses
        Text(
          'Recommended Courses',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 12),

        _buildCourseCard(
          context,
          title: 'Flutter Development Masterclass',
          instructor: 'John Doe',
          duration: '12 hours',
          rating: 4.8,
          students: 15000,
          icon: Icons.flutter_dash,
          color: Color(0xFF1877F2),
        ),

        _buildCourseCard(
          context,
          title: 'Advanced Dart Programming',
          instructor: 'Jane Smith',
          duration: '8 hours',
          rating: 4.7,
          students: 12000,
          icon: Icons.code,
          color: Color(0xFF409CFF),
        ),

        _buildCourseCard(
          context,
          title: 'UI/UX Design Fundamentals',
          instructor: 'Mike Johnson',
          duration: '10 hours',
          rating: 4.9,
          students: 20000,
          icon: Icons.design_services,
          color: Color(0xFF1877F2),
        ),

        _buildCourseCard(
          context,
          title: 'Firebase Integration Course',
          instructor: 'Sarah Williams',
          duration: '6 hours',
          rating: 4.6,
          students: 8000,
          icon: Icons.cloud_outlined,
          color: Color(0xFF409CFF),
        ),
      ],
    );
  }

  Widget _buildCourseCard(
    BuildContext context, {
    required String title,
    required String instructor,
    required String duration,
    required double rating,
    required int students,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 30, color: color),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'by $instructor',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16),
                    SizedBox(width: 4),
                    Text(duration),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    SizedBox(width: 4),
                    Text('$rating'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.people_outline, size: 16),
                    SizedBox(width: 4),
                    Text('${(students / 1000).toStringAsFixed(1)}k'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to course details
                },
                child: Text('Start Learning'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
