import 'package:flutter/material.dart';
import 'skill_bits_list_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Profile Header
        Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFF1877F2).withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Color(0xFF1877F2),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Nitish Kumar',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 4),
                Text(
                  'nitishkumar@gmail.com',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Edit profile
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 20),

        // Statistics
        // Row(
        //   children: [
        //     Expanded(
        //       child: _buildStatCard(
        //         context,
        //         title: '15',
        //         subtitle: 'Applied Jobs',
        //         icon: Icons.work_outline,
        //       ),
        //     ),
        //     SizedBox(width: 12),
        //     Expanded(
        //       child: _buildStatCard(
        //         context,
        //         title: '3',
        //         subtitle: 'Saved Jobs',
        //         icon: Icons.bookmark_outline,
        //       ),
        //     ),
        //   ],
        // ),

        SizedBox(height: 20),

        // Profile Sections
        Text(
          'Account Settings',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 12),

        _buildSettingTile(
          context,
          icon: Icons.person_outline,
          title: 'Personal Information',
          subtitle: 'Update your personal details',
          onTap: () {
            // TODO: Navigate to personal info
          },
        ),

        _buildSettingTile(
          context,
          icon: Icons.description_outlined,
          title: 'My Resume',
          subtitle: 'Upload and manage your resume',
          onTap: () {
            // TODO: Navigate to resume
          },
        ),

        _buildSettingTile(
          context,
          icon: Icons.work_outline,
          title: 'Job Applications',
          subtitle: 'View all your applications',
          onTap: () {
            // TODO: Navigate to applications
          },
        ),

        _buildSettingTile(
          context,
          icon: Icons.bookmark_outline,
          title: 'Saved Jobs',
          subtitle: 'View your saved job listings',
          onTap: () {
            // TODO: Navigate to saved jobs
          },
        ),

        SizedBox(height: 20),

        Text(
          'Preferences',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 12),
        _buildSettingTile(
          context,
          icon: Icons.video_camera_front_outlined,
          title: 'Skill Bit',
          subtitle: 'Showcase your skills',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SkillBitsListScreen()),
            );
          },
        ),

        // single video handled in Video Introduction screen

        _buildSettingTile(
          context,
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          subtitle: 'Manage notification preferences',
          onTap: () {
            // TODO: Navigate to notifications settings
          },
        ),

        _buildSettingTile(
          context,
          icon: Icons.language_outlined,
          title: 'Language',
          subtitle: 'English',
          onTap: () {
            // TODO: Change language
          },
        ),

        _buildSettingTile(
          context,
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          subtitle: 'Read our privacy policy',
          onTap: () {
            // TODO: Show privacy policy
          },
        ),

        _buildSettingTile(
          context,
          icon: Icons.help_outline,
          title: 'Help & Support',
          subtitle: 'Get help and contact support',
          onTap: () {
            // TODO: Open support
          },
        ),

        SizedBox(height: 20),

        // Logout Button
        Card(
          child: ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // TODO: Logout
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Perform logout
                        Navigator.pop(context);
                      },
                      child:
                          Text('Logout', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Color(0xFF1877F2)),
            SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Color(0xFF1877F2),
                  ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF1877F2)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
