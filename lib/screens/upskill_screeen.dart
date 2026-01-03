import 'package:flutter/material.dart';

class UpskillScreeen extends StatelessWidget {
  const UpskillScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: const Text(
          'Upskill ',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          /*
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCKtID0hchK3KkLVPndXcc4Zta4Vpmk6p1wG33oxHOuYFc95xdhSZWYVCSm9P3e91-BMOIlJMCKJZSo6_iTg2WY7m5MwctT1xCIhQPTbvjn9CctvVENGsljBz-S9lHvh1w6BV5hhbTpL_bF7ybvce0eKNR8nQ9ENmldx9daQorqlxV1_tSTIHFichU7GQTlSASGJR5d9aU4WoejgKrXWQoz9v6tAd34jYu2GcnLdcxJlyIpxxCYrrdxiRun9s_a8_XTD01unMDsfA',
              ),
            ),
          )
          */
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          _sectionHeader(
            title: "Trending Courses",
            action: "See All",
          ),

          /// Trending Courses (Horizontal)
          SizedBox(
            height: 270,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return const CourseCard();
              },
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemCount: 3,
            ),
          ),

          const SizedBox(height: 16),

          _sectionHeader(title: "Continue Learning"),

          /// Continue Learning Card
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ContinueLearningCard(),
          ),

          const SizedBox(height: 24),

          _sectionHeader(title: "Explore"),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ExploreCard(
                  icon: Icons.school,
                  iconColor: Colors.blue,
                  title: "Skill Courses",
                  subtitle:
                      "Master specific tools like Figma, Excel, or Python.",
                ),
                SizedBox(height: 16),
                ExploreCard(
                  icon: Icons.workspace_premium,
                  iconColor: Colors.orange,
                  title: "Certifications",
                  subtitle:
                      "Earn industry-recognized credentials to boost your career.",
                ),
                SizedBox(height: 16),
                ExploreCard(
                  icon: Icons.map,
                  iconColor: Colors.purple,
                  title: "Learning Paths",
                  subtitle:
                      "Curated roadmaps for role transitions. Zero to hero.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader({required String title, String? action}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (action != null)
            Text(
              action,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            )
        ],
      ),
    );
  }
}

/// --------------------
/// COURSE CARD
/// --------------------
class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBn7NQGoRkozXoSUg-dZM0UU3DPIAziuLuH2Sn1iP1zVYTlgQWck-aztugC-8wpY3LWeyzAx0TuTsmSoK8MJoaUNmvXX2f1SCdpyfDZABe-_P5G2RwjTwOYTc_-2mwknPwiRUR3LzmAtE8aQKwHWnZYK-rMA_0EwXApUXyd2g8NdXVrMhYB2s5HY9UpNpQmr1lvuYRraeCKb-byQOwPLYEEBhCimahfZgCTZbGKlJqIz_RGgOGAGjzivhUuqv7lBaZlAncidRVS_Q',
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "UX Design Fundamentals",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "By Sarah Jenkins",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Chip(
                      label: Text("Beginner"),
                      backgroundColor: Color(0xFFE3F2FD),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.schedule, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text("6h 30m", style: TextStyle(fontSize: 12)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// --------------------
/// CONTINUE LEARNING
/// --------------------
class ContinueLearningCard extends StatelessWidget {
  const ContinueLearningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCPr-ku50JnwROfFY3UZbn3Vo3_iY0mCPEDpKV7if3kisVxd-VUKUlHE6KDSSmte7vuTVan121QxHfFZfSexg1VpIs-pADbhIX4ji86gmGzvAXN7C0bX_MpDEGP0Zz6JBKe7kFu52niyW_cAU8mR02atKjh-cgWVhkNumTl4tuyw35sl9o2b5NA0HmTFzTTNKaXJ92aoDR9oTogATj5IRv_LgfQupNINM1xVUEC-4S3U3-Z6NXTNTqw_hnGsvsBmoRCZMUSQE9fvg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Advanced React Patterns",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Module 4: Hooks Deep Dive",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 10),
                LinearProgressIndicator(value: 0.65),
              ],
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            backgroundColor: Colors.blue.withOpacity(0.15),
            child: Icon(Icons.play_arrow, color: Colors.blue),
          )
        ],
      ),
    );
  }
}

/// --------------------
/// EXPLORE CARD
/// --------------------
class ExploreCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const ExploreCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.15),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Explore →",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
