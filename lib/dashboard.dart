import 'package:flutter/material.dart';
import 'models/notice.dart';
import 'services/notice_service.dart';
import 'screens/add_notice.dart';
import 'screens/notice_detail.dart';

class Dashboard extends StatefulWidget {
  final VoidCallback? onThemeToggle;
  final bool isDarkMode;

  const Dashboard({super.key, this.onThemeToggle, this.isDarkMode = false});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final NoticeService _svc = NoticeService();
  List<Notice> _nts = [];
  Category? _flt;
  String _searchQuery = '';
  bool _isLoading = false;
  bool _showFavoritesOnly = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    try {
      final notices = await _svc.getNotices();
      if (notices.isEmpty) {
        await _addMock();
        final updatedNotices = await _svc.getNotices();
        setState(() {
          _nts = updatedNotices;
          _isLoading = false;
        });
      } else {
        setState(() {
          _nts = notices;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading notices: $e')));
      }
    }
  }

  Future<void> _addMock() async {
    final mockNotices = [
      Notice(
        id: '1',
        title: 'AI Workshop Series',
        description:
            'Join our comprehensive AI workshop series covering machine learning fundamentals, neural networks, and practical applications. Open to all students.',
        category: Category.event,
        priority: Priority.high,
        authorId: 'admin@charusat.edu.in',
        authorName: 'Dr. Admin',
        filePath: null,
      ),
      Notice(
        id: '2',
        title: 'AI Camp 2025',
        description:
            'Annual AI Camp featuring hands-on sessions with industry experts. Topics include computer vision, NLP, and AI ethics. Limited seats available.',
        category: Category.event,
        priority: Priority.high,
        authorId: 'admin@charusat.edu.in',
        authorName: 'Dr. Admin',
        filePath: null,
      ),
      Notice(
        id: '3',
        title: 'InnoTech Hackathon',
        description:
            '48-hour hackathon focusing on innovative tech solutions. Teams can work on AI, IoT, blockchain, and more. Prizes worth ₹1 lakh.',
        category: Category.event,
        priority: Priority.medium,
        authorId: 'admin@charusat.edu.in',
        authorName: 'Dr. Admin',
        filePath: null,
      ),
      Notice(
        id: '4',
        title: 'Tech Talk: Future of AI',
        description:
            'Guest lecture by Dr. Sarah Johnson on emerging trends in artificial intelligence and their impact on various industries.',
        category: Category.event,
        priority: Priority.medium,
        authorId: 'admin@charusat.edu.in',
        authorName: 'Dr. Admin',
        filePath: null,
      ),
      Notice(
        id: '5',
        title: 'Charusat Tech Fest 2025',
        description:
            'Annual technical festival featuring competitions, workshops, and exhibitions. Showcase your tech skills and network with professionals.',
        category: Category.event,
        priority: Priority.high,
        authorId: 'admin@charusat.edu.in',
        authorName: 'Dr. Admin',
        filePath: null,
      ),
      Notice(
        id: '6',
        title: 'Mid-term Exam Schedule',
        description:
            'Mid-term examinations will commence from November 15th. Check your department notice board for detailed timetable.',
        category: Category.exam,
        priority: Priority.high,
        authorId: 'admin@charusat.edu.in',
        authorName: 'Dr. Admin',
        filePath: null,
      ),
      Notice(
        id: '7',
        title: 'Academic Calendar Update',
        description:
            'Updated academic calendar for Semester 5. Includes important dates for assignments, projects, and examinations.',
        category: Category.academic,
        priority: Priority.medium,
        authorId: 'admin@charusat.edu.in',
        authorName: 'Dr. Admin',
        filePath: null,
      ),
      Notice(
        id: '8',
        title: 'Library Hours Extended',
        description:
            'Library will remain open until 10 PM during exam season. Additional study materials available for AI and ML subjects.',
        category: Category.general,
        priority: Priority.low,
        authorId: 'admin@charusat.edu.in',
        authorName: 'Dr. Admin',
        filePath: null,
      ),
    ];
    for (final notice in mockNotices) {
      await _svc.addNotice(notice);
    }
  }

  List<Notice> get _fltd {
    List<Notice> filtered = _nts;

    // Apply favorites filter first
    if (_showFavoritesOnly) {
      filtered = filtered.where((n) => n.isFavorite).toList();
    }

    // Apply category filter
    if (_flt != null) {
      filtered = filtered.where((n) => n.category == _flt).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (n) =>
                n.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                n.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                n.authorName.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    return filtered;
  }

  void _setFlt(Category? c) {
    setState(() {
      _flt = c;
    });
  }

  void _updateSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void lg(BuildContext c) {
    Navigator.pushReplacementNamed(c, '/login');
  }

  String _extractNameFromEmail(String email) {
    // Extract name from email (e.g., "23AIML010@charusat.edu.in" -> "23AIML010")
    return email.split('@').first;
  }

  Widget _icon(Category cat) {
    IconData icon;
    Color color;
    switch (cat) {
      case Category.exam:
        icon = Icons.school;
        color = Colors.red;
        break;
      case Category.event:
        icon = Icons.event;
        color = Colors.blue;
        break;
      case Category.academic:
        icon = Icons.book;
        color = Colors.green;
        break;
      case Category.general:
        icon = Icons.info;
        color = Colors.orange;
        break;
    }
    return Icon(icon, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    String id = args?['ID'] ?? 'Unknown';
    String userName = _extractNameFromEmail(id);

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard - $userName"),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
          ),
          IconButton(
            icon: Icon(
              _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
            ),
            color: _showFavoritesOnly ? Colors.red : null,
            onPressed: () =>
                setState(() => _showFavoritesOnly = !_showFavoritesOnly),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => lg(context),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      AddNoticeScreen(userId: id, userName: userName),
                ),
              );
              _load();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search notices...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: _updateSearch,
            ),
          ),

          // Category Filter Buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => _setFlt(null),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _flt == null ? Colors.blue : null,
                  ),
                  child: const Text('All'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _setFlt(Category.exam),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _flt == Category.exam ? Colors.red : null,
                  ),
                  child: const Text('Exam'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _setFlt(Category.event),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _flt == Category.event
                        ? Colors.blue
                        : null,
                  ),
                  child: const Text('Event'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _setFlt(Category.academic),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _flt == Category.academic
                        ? Colors.green
                        : null,
                  ),
                  child: const Text('Academic'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _setFlt(Category.general),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _flt == Category.general
                        ? Colors.orange
                        : null,
                  ),
                  child: const Text('General'),
                ),
              ],
            ),
          ),

          // Loading indicator or notice list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _load,
                    child: _fltd.isEmpty
                        ? const Center(child: Text('No notices found'))
                        : ListView.builder(
                            itemCount: _fltd.length,
                            itemBuilder: (c, i) {
                              final nt = _fltd[i];
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 8.0,
                                ),
                                child: ListTile(
                                  title: Text(nt.title),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${nt.category.name} • ${nt.priority.name.toUpperCase()}',
                                      ),
                                      Text(
                                        'By ${nt.authorName}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  trailing: _icon(nt.category),
                                  onTap: () async {
                                    await Navigator.push(
                                      c,
                                      MaterialPageRoute(
                                        builder: (_) => NoticeDetailScreen(
                                          notice: nt,
                                          userId: id,
                                          userName: userName,
                                        ),
                                      ),
                                    );
                                    _load(); // Refresh the list after returning from detail screen
                                  },
                                ),
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
