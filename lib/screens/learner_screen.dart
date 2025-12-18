// import 'package:flutter/material.dart';

// class LearnerScreen extends StatelessWidget {
//   const LearnerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.all(16),
//       children: [
//         // Header
//         Card(
//           child: Padding(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Learning Hub',
//                   style: Theme.of(context).textTheme.displaySmall,
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Upgrade your skills and get hired',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//               ],
//             ),
//           ),
//         ),

//         SizedBox(height: 20),

//         // Progress Section
//         Text(
//           'Your Progress',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         SizedBox(height: 12),

//         Card(
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Courses Completed',
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     ),
//                     Text(
//                       '3/10',
//                       style:
//                           Theme.of(context).textTheme.headlineMedium?.copyWith(
//                                 color: Color(0xFF1877F2),
//                               ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 LinearProgressIndicator(
//                   value: 0.3,
//                   backgroundColor: Colors.grey.withOpacity(0.2),
//                   valueColor: AlwaysStoppedAnimation(Color(0xFF1877F2)),
//                   minHeight: 8,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         SizedBox(height: 20),

//         // Recommended Courses
//         Text(
//           'Recommended Courses',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         SizedBox(height: 12),

//         _buildCourseCard(
//           context,
//           title: 'Flutter Development Masterclass',
//           instructor: 'John Doe',
//           duration: '12 hours',
//           rating: 4.8,
//           students: 15000,
//           icon: Icons.flutter_dash,
//           color: Color(0xFF1877F2),
//         ),

//         _buildCourseCard(
//           context,
//           title: 'Advanced Dart Programming',
//           instructor: 'Jane Smith',
//           duration: '8 hours',
//           rating: 4.7,
//           students: 12000,
//           icon: Icons.code,
//           color: Color(0xFF409CFF),
//         ),

//         _buildCourseCard(
//           context,
//           title: 'UI/UX Design Fundamentals',
//           instructor: 'Mike Johnson',
//           duration: '10 hours',
//           rating: 4.9,
//           students: 20000,
//           icon: Icons.design_services,
//           color: Color(0xFF1877F2),
//         ),

//         _buildCourseCard(
//           context,
//           title: 'Firebase Integration Course',
//           instructor: 'Sarah Williams',
//           duration: '6 hours',
//           rating: 4.6,
//           students: 8000,
//           icon: Icons.cloud_outlined,
//           color: Color(0xFF409CFF),
//         ),
//       ],
//     );
//   }

//   Widget _buildCourseCard(
//     BuildContext context, {
//     required String title,
//     required String instructor,
//     required String duration,
//     required double rating,
//     required int students,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(icon, size: 30, color: color),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: Theme.of(context).textTheme.headlineMedium,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'by $instructor',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.access_time, size: 16),
//                     SizedBox(width: 4),
//                     Text(duration),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.star, size: 16, color: Colors.amber),
//                     SizedBox(width: 4),
//                     Text('$rating'),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.people_outline, size: 16),
//                     SizedBox(width: 4),
//                     Text('${(students / 1000).toStringAsFixed(1)}k'),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 12),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // TODO: Navigate to course details
//                 },
//                 child: Text('Start Learning'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class LearnerScreen extends StatelessWidget {
  const LearnerScreen({super.key});

  static const primary = Color(0xFF135BEC);
  static const bgLight = Color(0xFFF6F6F8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(),
            SliverToBoxAdapter(child: _buildTrending()),
            SliverToBoxAdapter(child: _buildContinueLearning()),
            SliverToBoxAdapter(child: _buildExplore()),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  SliverAppBar _buildHeader() {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: bgLight.withOpacity(0.95),
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Upskill & Grow",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                const CircleAvatar(
                  radius: 18,
                  backgroundImage:
                      NetworkImage("https://i.pravatar.cc/150?img=32"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ================= TRENDING =================
  Widget _buildTrending() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("Trending Courses", action: "See all"),
        SizedBox(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              _TrendingCourseCard(
                title: "UX Design Fundamentals",
                instructor: "Sarah Jenkins",
                level: "Beginner",
                duration: "6h 30m",
              ),
              _TrendingCourseCard(
                title: "Python for Data Science",
                instructor: "Alex Chen",
                level: "Advanced",
                duration: "12h",
              ),
              _TrendingCourseCard(
                title: "Financial Analysis Core",
                instructor: "Marcus Ray",
                level: "Intermediate",
                duration: "8h 15m",
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= CONTINUE LEARNING =================
  Widget _buildContinueLearning() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Continue Learning",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue.shade50,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Advanced React Patterns",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Text(
                        "Module 4: Hooks Deep Dive",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: 0.65,
                              backgroundColor: Colors.grey.shade200,
                              valueColor:
                                  const AlwaysStoppedAnimation(primary),
                              minHeight: 6,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text("65%",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: primary.withOpacity(0.1),
                  child: const Icon(Icons.play_arrow, color: primary),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= EXPLORE =================
  Widget _buildExplore() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Explore",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          _ExploreCard(
            icon: Icons.school,
            title: "Skill Courses",
            description:
                "Master specific tools like Figma, Excel, or Python with hands-on projects.",
          ),
          _ExploreCard(
            icon: Icons.workspace_premium,
            title: "Certifications",
            description:
                "Earn industry-recognized credentials to boost your resume.",
          ),
          _ExploreCard(
            icon: Icons.map,
            title: "Learning Paths",
            description:
                "Curated roadmaps for role transitions. Go from zero to hero.",
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, {String? action}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (action != null)
            Text(action,
                style: const TextStyle(
                    color: primary, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// ================= COMPONENTS =================

class _TrendingCourseCard extends StatelessWidget {
  final String title;
  final String instructor;
  final String level;
  final String duration;

  const _TrendingCourseCard({
    required this.title,
    required this.instructor,
    required this.level,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 10),
          Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("By $instructor",
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 6),
          Row(
            children: [
              Chip(label: Text(level, style: const TextStyle(fontSize: 11))),
              const SizedBox(width: 6),
              Row(
                children: [
                  const Icon(Icons.schedule, size: 14),
                  const SizedBox(width: 4),
                  Text(duration,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ExploreCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ExploreCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: LearnerScreen.primary.withOpacity(0.1),
            child: Icon(icon, color: LearnerScreen.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(description,
                    style:
                        const TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
