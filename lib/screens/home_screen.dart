// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.all(16),
//       children: [
//         // Welcome Card
//         Card(
//           child: Padding(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome to Open Job!',
//                   style: Theme.of(context).textTheme.displaySmall,
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Find your dream job today',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//               ],
//             ),
//           ),
//         ),

//         SizedBox(height: 20),

//         // Quick Stats
//         Row(
//           children: [
//             Expanded(
//               child: _buildStatCard(
//                 context,
//                 icon: Icons.work_outline,
//                 title: '1,234',
//                 subtitle: 'Jobs Available',
//                 color: Color(0xFF1877F2),
//               ),
//             ),
//             SizedBox(width: 12),
//             Expanded(
//               child: _buildStatCard(
//                 context,
//                 icon: Icons.business_outlined,
//                 title: '456',
//                 subtitle: 'Companies',
//                 color: Color(0xFF409CFF),
//               ),
//             ),
//           ],
//         ),

//         SizedBox(height: 20),

//         // Featured Jobs Section
//         Text(
//           'Featured Jobs',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         SizedBox(height: 12),

//         _buildJobCard(
//           context,
//           company: 'Google Inc.',
//           position: 'Senior Flutter Developer',
//           location: 'Remote',
//           salary: '\$120k - \$150k',
//           logo: Icons.g_mobiledata,
//         ),

//         _buildJobCard(
//           context,
//           company: 'Microsoft',
//           position: 'Mobile App Developer',
//           location: 'Hybrid',
//           salary: '\$100k - \$130k',
//           logo: Icons.computer,
//         ),

//         _buildJobCard(
//           context,
//           company: 'Amazon',
//           position: 'Flutter Engineer',
//           location: 'On-site',
//           salary: '\$110k - \$140k',
//           logo: Icons.shopping_cart_outlined,
//         ),

//         _buildJobCard(
//           context,
//           company: 'Meta',
//           position: 'Senior Mobile Developer',
//           location: 'Remote',
//           salary: '\$130k - \$160k',
//           logo: Icons.groups,
//         ),
//       ],
//     );
//   }

//   Widget _buildStatCard(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//   }) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Icon(icon, size: 40, color: color),
//             SizedBox(height: 8),
//             Text(
//               title,
//               style: Theme.of(context).textTheme.displaySmall?.copyWith(
//                     color: color,
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

//   Widget _buildJobCard(
//     BuildContext context, {
//     required String company,
//     required String position,
//     required String location,
//     required String salary,
//     required IconData logo,
//   }) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               radius: 30,
//               backgroundColor: Color(0xFF1877F2).withOpacity(0.1),
//               child: Icon(logo, size: 30, color: Color(0xFF1877F2)),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     position,
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   SizedBox(height: 4),
//                   Text(company),
//                   SizedBox(height: 8),
//                   Wrap(
//                     spacing: 16,
//                     runSpacing: 8,
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.location_on_outlined, size: 16),
//                           SizedBox(width: 4),
//                           Text(location),
//                         ],
//                       ),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.attach_money, size: 16),
//                           SizedBox(width: 4),
//                           Text(salary),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.bookmark_outline),
//               onPressed: () {
//                 // TODO: Save job
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const primary = Color(0xFF135BEC);
  static const bgLight = Color(0xFFF6F6F8);
  static const cardDark = Color(0xFF1A2230);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(),
            SliverToBoxAdapter(child: _buildSearch()),
            SliverToBoxAdapter(child: _buildDiscover()),
            SliverToBoxAdapter(child: _buildRecommended()),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  SliverAppBar _buildHeader() {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: bgLight.withOpacity(0.95),
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150?img=12",
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
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
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Good Morning,",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "Alex Morgan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                Positioned(
                  top: 10,
                  right: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // ---------------- SEARCH ----------------
  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search jobs, roles, companies...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.tune, color: Colors.white),
          )
        ],
      ),
    );
  }

  // ---------------- DISCOVER ----------------
  Widget _buildDiscover() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("Discover"),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              _DiscoverCard(
                title: "Tech Hiring",
                subtitle: "120+ new roles",
                tag: "Trending",
              ),
              _DiscoverCard(
                title: "Work from Home",
                subtitle: "Global opportunities",
                tag: "Remote",
              ),
              _DiscoverCard(
                title: "Design & Art",
                subtitle: "Agencies hiring",
                tag: "Creative",
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- RECOMMENDED ----------------
  Widget _buildRecommended() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("Recommended for you"),
        const SizedBox(height: 8),
        const _JobCard(
          role: "Senior Product Designer",
          company: "Stripe",
          location: "San Francisco",
          salary: "\$140k - \$180k",
          type: "Full-time",
        ),
        const _JobCard(
          role: "Frontend Engineer",
          company: "Vercel",
          location: "Remote",
          salary: "Contract",
          type: "Remote",
        ),
        const _JobCard(
          role: "Marketing Manager",
          company: "Spotify",
          location: "New York",
          salary: "On-site",
          type: "Marketing",
        ),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ================= COMPONENTS =================

class _DiscoverCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tag;

  const _DiscoverCard({
    required this.title,
    required this.subtitle,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Colors.black87, Colors.black54],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final String role;
  final String company;
  final String location;
  final String salary;
  final String type;

  const _JobCard({
    required this.role,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(child: Icon(Icons.business)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(role,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold)),
                    Text(
                      "$company • $location",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
              )
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              _chip(type),
              _chip(salary),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: HomeScreen.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("View Details"),
            ),
          )
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Chip(
      label: Text(text, style: const TextStyle(fontSize: 12)),
      backgroundColor: Colors.grey.shade100,
    );
  }
}
