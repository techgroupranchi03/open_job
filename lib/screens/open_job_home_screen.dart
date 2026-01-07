import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_job/screens/resume_upload.dart';


import 'package:open_job/widgets/app_drawer.dart';

class OpenJobHomeScreen extends StatelessWidget {
  OpenJobHomeScreen({super.key});

  // Global key to control drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          /// HEADER
          SliverAppBar(
            pinned: true,
            backgroundColor: theme.colorScheme.surface.withOpacity(0.95),
            elevation: 1,
            automaticallyImplyLeading: false,
            toolbarHeight: 75,
            flexibleSpace: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _topBar(),
                  ],
                ),
              ),
            ),
          ),

          /// CONTENT
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 12),
              _searchBar(),
              const SizedBox(height: 20),
              // Discover Section
              _sectionHeader("Discover", action: "See all"),
              SizedBox(
                height: 160,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, __) => const DiscoverCard(),
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemCount: 3,
                ),
              ),

              const SizedBox(height: 24),

              // Recommended Section
              _sectionHeader("Recommended for you"),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    JobCard(
                      title: "Senior Product Designer",
                      company: "Stripe",
                      location: "San Francisco, CA",
                      salary: "\$140k - \$180k",
                      tags: ["Full-time", "Mid-Level"],
                      posted: "2 days ago",
                    ),
                    SizedBox(height: 16),
                    JobCard(
                      title: "Frontend Engineer",
                      company: "Vercel",
                      location: "Remote",
                      tags: ["Remote", "Contract"],
                      posted: "5 hours ago",
                    ),
                    SizedBox(height: 16),
                    JobCard(
                      title: "Marketing Manager",
                      company: "Spotify",
                      location: "New York, NY",
                      tags: ["On-site", "Marketing"],
                      posted: "1 week ago",
                    ),
                    SizedBox(height: 12),
                    Text(
                      "View all 240+ jobs",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ]),
          ),
        ],
      ),
    );
  }

  /// --------------------
  /// Top Bar with Avatar and Notifications
  /// --------------------
  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // LEFT: Avatar + Greeting
        Row(
          children: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer(); // Open drawer
              },
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuAOIB9h9nEIsjF41t9M-2F2AEzMogZ1vXrar9bTtbyqdThsD8-bddAZuxPQv46OTvT6b6jvwQorOs1oXQdbahFnUO0_F6BV9nqoFgst_aAaZ26xoOq03Ene_qUWUZ8wtNBfPnxJkf0yIOwRD4m_fLsbAYxdI5JmRth-xgyxAPVjNif_VvdVXqAIgnNtOLCewakSrWXkuSZvbfsNof-yIVE021ru3lqFK2fWfNOLo6mWt6lYehNNth1o9uPVl6JSyI9a0pO8Ewmp2Q',
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Good Morning,",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text("Alex Morgan",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),

        // RIGHT: Notifications Icon
        GestureDetector(
          onTap: () {
            print("hello");
          },
          child: Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  print("hello");
                },
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// --------------------
  /// Search Bar
  /// --------------------
  Widget _searchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Search jobs, roles, companies...",
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.tune, color: Colors.white),
        )
      ],
    );
  }

  Widget _sectionHeader(String title, {String? action}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (action != null)
            Text(action,
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

/// --------------------
/// Discover Card
/// --------------------
class DiscoverCard extends StatelessWidget {
  const DiscoverCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBFOeTIVnfoEjmD0uAmPhIRgGEtl2wxvJ0GqWRjxW9Xe3CMDlFZxTn3zoImKFbqKVNC90RRtYhwK-_pjIOJoOJOmFlx3HXIEj4A0-xHaBL6tvIw7vQdQrRx34nED95-kUBqc13ZNIkcJXRlwCtmiDN5KOF6XBcfAWd4JPJglqlrB80AGRXDtCT3Z3C2mOJ3-HoNx0J6EuxwiOIc1zfduw_QU_teBS-bxP-PHmPzibfa2o_hEDl4c6bANVm6SSRNWdtqBL12hLpGeA',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.black87, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Trending",
                style: TextStyle(fontSize: 10, color: Colors.white70)),
            Text("Tech Hiring",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            Text("120+ new roles",
                style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// Job Card
class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final List<String> tags;
  final String posted;
  final String? salary;

  const JobCard({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.tags,
    required this.posted,
    this.salary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("$company • $location",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.bookmark_border, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (final tag in tags)
                Chip(
                  label: Text(tag, style: const TextStyle(fontSize: 12)),
                  backgroundColor: Colors.grey.shade100,
                ),
              if (salary != null)
                Chip(
                  label: Text(salary!, style: const TextStyle(fontSize: 12)),
                  backgroundColor: Colors.green.shade50,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Posted $posted",
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ElevatedButton(
                onPressed: () {
                  if (kDebugMode) {
                    print('\x1B[33mApplyBtn\x1B[0m');
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadResumeScreen(
                        title: title,
                        company: company,
                        location: location,
                        tags: tags,
                        posted: posted,
                        salary: salary,
                      ),
                    ),
                  );

/*

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Apply button pressed')),
                  );
*/
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Apply Now"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
