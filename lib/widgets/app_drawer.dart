import 'package:flutter/material.dart';
import 'package:open_job/screens/setting_screen.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: themeProvider.isDarkMode
                    ? [Color(0xFF242526), Color(0xFF18191A)]
                    : [Color(0xFF1877F2), Color(0xFF409CFF)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.work_outline_rounded,
                    size: 35,
                    color: Color(0xFF1877F2),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Open Job',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Your Career, Your Future',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          _buildDrawerItem(
            context,
            icon: Icons.home_outlined,
            title: 'Home',
            onTap: () {
              Navigator.pop(context);
            },
          ),

          _buildDrawerItem(
            context,
            icon: Icons.work_outline,
            title: 'Browse Jobs',
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to browse jobs
            },
          ),

          _buildDrawerItem(
            context,
            icon: Icons.business_outlined,
            title: 'Companies',
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to companies
            },
          ),

          _buildDrawerItem(
            context,
            icon: Icons.description_outlined,
            title: 'My Applications',
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to applications
            },
          ),

          _buildDrawerItem(
            context,
            icon: Icons.bookmark_outline,
            title: 'Saved Jobs',
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to saved jobs
            },
          ),

          Divider(),

          _buildDrawerItem(
            context,
            icon: Icons.school_outlined,
            title: 'Learning Center',
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to learning center
            },
          ),

          _buildDrawerItem(
            context,
            icon: Icons.card_membership_outlined,
            title: 'My Certificates',
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to certificates
            },
          ),

          Divider(),

          // Theme Toggle
          ListTile(
            leading: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Color(0xFF1877F2),
            ),
            title: Text('Dark Mode'),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
              activeColor: Color(0xFF1877F2),
            ),
          ),

          Divider(),

          _buildDrawerItem(
            context,
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
              // TODO: Navigate to settings
            },
          ),

          _buildDrawerItem(
            context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to help
            },
          ),

          _buildDrawerItem(
            context,
            icon: Icons.info_outline,
            title: 'About',
            onTap: () {
              Navigator.pop(context);
              _showAboutDialog(context);
            },
          ),

          Divider(),

          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () {
              Navigator.pop(context);
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? Color(0xFF1877F2),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      hoverColor: Color(0xFF1877F2).withOpacity(0.1),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.work_outline_rounded, color: Color(0xFF1877F2)),
            SizedBox(width: 12),
            Text('About Open Job'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version 1.0.0'),
            SizedBox(height: 8),
            Text(
              'Open Job is your professional platform for finding jobs and enhancing your skills.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            Text(
              '© 2025 Open Job. All rights reserved.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
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
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
