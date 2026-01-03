import 'package:flutter/material.dart';
import 'package:open_job/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Open Job'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // TODO: Open search
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
        // Welcome Card
        Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Open Job!',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 8),
                Text(
                  'Find your dream job today',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 20),

        // Quick Stats
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.work_outline,
                title: '1,234',
                subtitle: 'Jobs Available',
                color: Color(0xFF1877F2),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.business_outlined,
                title: '456',
                subtitle: 'Companies',
                color: Color(0xFF409CFF),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),

        // Featured Jobs Section
        Text(
          'Featured Jobs',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 12),

        _buildJobCard(
          context,
          company: 'Google Inc.',
          position: 'Senior Flutter Developer',
          location: 'Remote',
          salary: '\$120k - \$150k',
          logo: Icons.g_mobiledata,
        ),

        _buildJobCard(
          context,
          company: 'Microsoft',
          position: 'Mobile App Developer',
          location: 'Hybrid',
          salary: '\$100k - \$130k',
          logo: Icons.computer,
        ),

        _buildJobCard(
          context,
          company: 'Amazon',
          position: 'Flutter Engineer',
          location: 'On-site',
          salary: '\$110k - \$140k',
          logo: Icons.shopping_cart_outlined,
        ),

        _buildJobCard(
          context,
          company: 'Meta',
          position: 'Senior Mobile Developer',
          location: 'Remote',
          salary: '\$130k - \$160k',
          logo: Icons.groups,
        ),
      ],
        ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: color,
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

  Widget _buildJobCard(
    BuildContext context, {
    required String company,
    required String position,
    required String location,
    required String salary,
    required IconData logo,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFF1877F2).withOpacity(0.1),
              child: Icon(logo, size: 30, color: Color(0xFF1877F2)),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    position,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 4),
                  Text(company),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on_outlined, size: 16),
                          SizedBox(width: 4),
                          Text(location),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.attach_money, size: 16),
                          SizedBox(width: 4),
                          Text(salary),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.bookmark_outline),
              onPressed: () {
                // TODO: Save job
              },
            ),
          ],
        ),
      ),
    );
  }
}
