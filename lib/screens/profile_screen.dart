// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.all(16),
//       children: [
//         // Profile Header
//         Card(
//           child: Padding(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundColor: Color(0xFF1877F2).withOpacity(0.1),
//                   child: Icon(
//                     Icons.person,
//                     size: 60,
//                     color: Color(0xFF1877F2),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'John Doe',
//                   style: Theme.of(context).textTheme.displaySmall,
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   'john.doe@email.com',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // TODO: Edit profile
//                   },
//                   icon: Icon(Icons.edit),
//                   label: Text('Edit Profile'),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         SizedBox(height: 20),

//         // Statistics
//         Row(
//           children: [
//             Expanded(
//               child: _buildStatCard(
//                 context,
//                 title: '15',
//                 subtitle: 'Applied Jobs',
//                 icon: Icons.work_outline,
//               ),
//             ),
//             SizedBox(width: 12),
//             Expanded(
//               child: _buildStatCard(
//                 context,
//                 title: '3',
//                 subtitle: 'Saved Jobs',
//                 icon: Icons.bookmark_outline,
//               ),
//             ),
//           ],
//         ),

//         SizedBox(height: 20),

//         // Profile Sections
//         Text(
//           'Account Settings',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         SizedBox(height: 12),

//         _buildSettingTile(
//           context,
//           icon: Icons.person_outline,
//           title: 'Personal Information',
//           subtitle: 'Update your personal details',
//           onTap: () {
//             // TODO: Navigate to personal info
//           },
//         ),

//         _buildSettingTile(
//           context,
//           icon: Icons.description_outlined,
//           title: 'My Resume',
//           subtitle: 'Upload and manage your resume',
//           onTap: () {
//             // TODO: Navigate to resume
//           },
//         ),

//         _buildSettingTile(
//           context,
//           icon: Icons.work_outline,
//           title: 'Job Applications',
//           subtitle: 'View all your applications',
//           onTap: () {
//             // TODO: Navigate to applications
//           },
//         ),

//         _buildSettingTile(
//           context,
//           icon: Icons.bookmark_outline,
//           title: 'Saved Jobs',
//           subtitle: 'View your saved job listings',
//           onTap: () {
//             // TODO: Navigate to saved jobs
//           },
//         ),

//         SizedBox(height: 20),

//         Text(
//           'Preferences',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         SizedBox(height: 12),

//         _buildSettingTile(
//           context,
//           icon: Icons.notifications_outlined,
//           title: 'Notifications',
//           subtitle: 'Manage notification preferences',
//           onTap: () {
//             // TODO: Navigate to notifications settings
//           },
//         ),

//         _buildSettingTile(
//           context,
//           icon: Icons.language_outlined,
//           title: 'Language',
//           subtitle: 'English',
//           onTap: () {
//             // TODO: Change language
//           },
//         ),

//         _buildSettingTile(
//           context,
//           icon: Icons.privacy_tip_outlined,
//           title: 'Privacy Policy',
//           subtitle: 'Read our privacy policy',
//           onTap: () {
//             // TODO: Show privacy policy
//           },
//         ),

//         _buildSettingTile(
//           context,
//           icon: Icons.help_outline,
//           title: 'Help & Support',
//           subtitle: 'Get help and contact support',
//           onTap: () {
//             // TODO: Open support
//           },
//         ),

//         SizedBox(height: 20),

//         // Logout Button
//         Card(
//           child: ListTile(
//             leading: Icon(Icons.logout, color: Colors.red),
//             title: Text(
//               'Logout',
//               style: TextStyle(color: Colors.red),
//             ),
//             onTap: () {
//               // TODO: Logout
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('Logout'),
//                   content: Text('Are you sure you want to logout?'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // TODO: Perform logout
//                         Navigator.pop(context);
//                       },
//                       child:
//                           Text('Logout', style: TextStyle(color: Colors.red)),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatCard(
//     BuildContext context, {
//     required String title,
//     required String subtitle,
//     required IconData icon,
//   }) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Icon(icon, size: 32, color: Color(0xFF1877F2)),
//             SizedBox(height: 8),
//             Text(
//               title,
//               style: Theme.of(context).textTheme.displaySmall?.copyWith(
//                     color: Color(0xFF1877F2),
//                   ),
//             ),
//             SizedBox(height: 4),
//             Text(
//               subtitle,
//               style: Theme.of(context).textTheme.bodyMedium,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSettingTile(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//   }) {
//     return Card(
//       child: ListTile(
//         leading: Icon(icon, color: Color(0xFF1877F2)),
//         title: Text(title),
//         subtitle: Text(subtitle),
//         trailing: Icon(Icons.chevron_right),
//         onTap: onTap,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            SliverToBoxAdapter(child: _buildProfileCard()),
            SliverToBoxAdapter(child: _buildSkillBit()),
            SliverToBoxAdapter(child: _buildOptions()),
            SliverToBoxAdapter(child: _buildLogout(context)),
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
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: const Text(
        "Profile",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }

  // ================= PROFILE CARD =================
  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 56,
                  backgroundImage:
                      NetworkImage("https://i.pravatar.cc/300?img=5"),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              "Alex Johnson",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Senior UX Designer",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _MiniStat(title: "1,204", label: "Views"),
                SizedBox(width: 24),
                SizedBox(height: 30, child: VerticalDivider()),
                SizedBox(width: 24),
                _MiniStat(title: "4.9", label: "Rating"),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ================= SKILLBIT =================
  Widget _buildSkillBit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create SkillBit",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Record a 30-second video showcasing your skill to stand out.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.videocam, color: primary, size: 32),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.videocam),
                label: const Text("Record Skill Video"),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ================= OPTIONS =================
  Widget _buildOptions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: const [
            _OptionTile(icon: Icons.edit, title: "Edit Profile"),
            _Divider(),
            _OptionTile(icon: Icons.play_circle, title: "My SkillBits"),
            _Divider(),
            _OptionTile(icon: Icons.bookmark, title: "Saved Jobs"),
            _Divider(),
            _OptionTile(icon: Icons.school, title: "My Courses"),
            _Divider(),
            _OptionTile(icon: Icons.settings, title: "Settings"),
          ],
        ),
      ),
    );
  }

  // ================= LOGOUT =================
  Widget _buildLogout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text(
            "Logout",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Logout"),
                content: const Text("Are you sure you want to logout?"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Logout",
                          style: TextStyle(color: Colors.red))),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ================= COMPONENTS =================

class _MiniStat extends StatelessWidget {
  final String title;
  final String label;

  const _MiniStat({required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
                letterSpacing: 0.8)),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _OptionTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 0.5);
  }
}
