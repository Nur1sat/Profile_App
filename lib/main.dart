import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MainApp(), debugShowCheckedModeBanner: false));
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 3;

  final List<Widget> _pages = [
    const HomePage(),
    const MessagesPage(),
    const DiscoverPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: "Discover",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _userName = "John Doe";
  int _notificationCount = 3;

  late List<QuickAction> _quickActions;

  late List<FeaturedItem> _featuredItems;

  @override
  void initState() {
    super.initState();

    _quickActions = [
      QuickAction(
        icon: Icons.person_outline,
        title: 'Profile',
        onTap: () {
          _showCustomDialog(
            title: 'Profile',
            message: 'Profile management coming soon!',
          );
        },
      ),
      QuickAction(
        icon: Icons.settings_outlined,
        title: 'Settings',
        onTap: () {
          _showCustomDialog(
            title: 'Settings',
            message: 'App settings will be available in the next update.',
          );
        },
      ),
      QuickAction(
        icon: Icons.history,
        title: 'History',
        onTap: () {
          _showCustomDialog(
            title: 'History',
            message: 'Your activity history is being tracked.',
          );
        },
      ),
      QuickAction(
        icon: Icons.help_outline,
        title: 'Help',
        onTap: () {
          _showCustomDialog(
            title: 'Help',
            message: 'Customer support will assist you shortly.',
          );
        },
      ),
    ];

    _featuredItems = [
      FeaturedItem(
        title: 'New Releases',
        subtitle: 'Check out the latest updates',
        icon: Icons.new_releases_outlined,
        color: Colors.orange,
        onTap: () {
          _showCustomDialog(
            title: 'New Releases',
            message: 'Latest updates are being prepared.',
          );
        },
      ),
      FeaturedItem(
        title: 'Trending',
        subtitle: 'Most popular right now',
        icon: Icons.trending_up,
        color: Colors.purple,
        onTap: () {
          _showCustomDialog(
            title: 'Trending',
            message: 'Top trending items are loading.',
          );
        },
      ),
      FeaturedItem(
        title: 'Recommended',
        subtitle: 'Picked just for you',
        icon: Icons.recommend_outlined,
        color: Colors.green,
        onTap: () {
          _showCustomDialog(
            title: 'Recommended',
            message: 'Personalized recommendations coming soon!',
          );
        },
      ),
    ];
  }

  void _showCustomDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "HOME",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  _showNotifications();
                },
                icon: const Icon(Icons.notifications_outlined),
              ),
              if (_notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_notificationCount',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingSection(),

              const SizedBox(height: 20),

              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      _quickActions
                          .map(
                            (action) => QuickActionButton(
                              icon: action.icon,
                              title: action.title,
                              onTap: action.onTap,
                            ),
                          )
                          .toList(),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Featured',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      _featuredItems
                          .map(
                            (item) => FeaturedItemCard(
                              title: item.title,
                              subtitle: item.subtitle,
                              icon: item.icon,
                              color: item.color,
                              onTap: item.onTap,
                            ),
                          )
                          .toList(),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _showCustomDialog(
                      title: 'Explore',
                      message: 'Exploration features are coming soon!',
                    );
                  },
                  child: const Text('Explore More'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, $_userName!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Today is ${_formatCurrentDate()}',
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  String _formatCurrentDate() {
    DateTime now = DateTime.now();
    return '${_getWeekday(now.weekday)}, ${_getMonth(now.month)} ${now.day}';
  }

  String _getWeekday(int weekday) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[weekday - 1];
  }

  String _getMonth(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notifications'),
          content: Text('You have $_notificationCount new notifications'),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class QuickAction {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  QuickAction({required this.icon, required this.title, required this.onTap});
}

class FeaturedItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  FeaturedItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const QuickActionButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Column(
        children: [
          IconButton(
            icon: Icon(icon, size: 30),
            onPressed: onTap,
            style: IconButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class FeaturedItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const FeaturedItemCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 250,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final List<MessageItem> _messages = [
    MessageItem(
      name: 'Someone from Taraz',
      preview: 'Hey, how are you?',
      time: '5m ago',
      unread: true,
      avatarColor: Colors.blue[200]!,
    ),
    MessageItem(
      name: 'Someone from college',
      preview: 'Today will be project fire',
      time: '15m ago',
      unread: false,
      avatarColor: Colors.green[200]!,
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  List<MessageItem> _filteredMessages = [];

  @override
  void initState() {
    super.initState();
    _filteredMessages = _messages;
  }

  void _filterMessages(String query) {
    setState(() {
      _filteredMessages =
          _messages
              .where(
                (message) =>
                    message.name.toLowerCase().contains(query.toLowerCase()) ||
                    message.preview.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "MESSAGES",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder:
                    (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 20,
                        right: 20,
                        top: 20,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _searchController,
                            onChanged: _filterMessages,
                            decoration: InputDecoration(
                              hintText: "Search messages...",
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Close"),
                          ),
                        ],
                      ),
                    ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: _filteredMessages.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final message = _filteredMessages[index];
          return ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: message.avatarColor,
                  child: Text(
                    message.name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                if (message.unread)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(
              message.name,
              style: TextStyle(
                fontWeight:
                    message.unread ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Text(
              message.preview,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(message.time),
            onTap: () {
              _showChatDialog(context, message);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewMessageDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showChatDialog(BuildContext context, MessageItem message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Chat with ${message.name}'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Text('Tap to open full chat'),
                  const SizedBox(height: 10),
                  Text('Last message: ${message.preview}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening chat with ${message.name}'),
                    ),
                  );
                },
                child: const Text("Open Chat"),
              ),
            ],
          ),
    );
  }

  void _showNewMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("New Message"),
            content: TextField(
              decoration: InputDecoration(
                hintText: "Enter recipient's name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('New message screen opened')),
                  );
                },
                child: const Text("Start"),
              ),
            ],
          ),
    );
  }
}

class MessageItem {
  final String name;
  final String preview;
  final String time;
  final bool unread;
  final Color avatarColor;

  MessageItem({
    required this.name,
    required this.preview,
    required this.time,
    this.unread = false,
    required this.avatarColor,
  });
}

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<DiscoverItem> discoverItems = [];

  @override
  void initState() {
    super.initState();
    discoverItems = List.generate(
      8,
      (index) => DiscoverItem(
        id: index,
        title: 'Item ${index + 1}',
        icon: index % 2 == 0 ? CupertinoIcons.book : CupertinoIcons.doc_text,
        isScheduled: false,
      ),
    );
  }

  void _addNewItem() {
    setState(() {
      int newIndex = discoverItems.length + 1;
      discoverItems.add(
        DiscoverItem(
          id: newIndex - 1,
          title: 'New Item $newIndex',
          icon:
              newIndex % 2 == 0 ? CupertinoIcons.book : CupertinoIcons.doc_text,
          isScheduled: false,
        ),
      );
    });
  }

  void _deleteItem(int index) {
    setState(() {
      discoverItems.removeAt(index);
    });
  }

  void _scheduleItem(int index) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    ).then((selectedDate) {
      if (selectedDate != null) {
        showTimePicker(context: context, initialTime: TimeOfDay.now()).then((
          selectedTime,
        ) {
          if (selectedTime != null) {
            setState(() {
              discoverItems[index] = discoverItems[index].copyWith(
                isScheduled: true,
                scheduledDate: selectedDate,
                scheduledTime: selectedTime,
              );
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${discoverItems[index].title} scheduled for '
                  '${selectedDate.toLocal().toString().split(' ')[0]} '
                  'at ${selectedTime.format(context)}',
                ),
              ),
            );
          }
        });
      }
    });
  }

  void _showItemDetails(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(discoverItems[index].title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Item ID: ${discoverItems[index].id}'),
                if (discoverItems[index].isScheduled)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Scheduled:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Date: ${discoverItems[index].scheduledDate?.toLocal().toString().split(' ')[0] ?? 'N/A'}',
                      ),
                      Text(
                        'Time: ${discoverItems[index].scheduledTime?.format(context) ?? 'N/A'}',
                      ),
                    ],
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("DISCOVER"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder:
                    (context) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Filter Options",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: const Icon(Icons.sort),
                            title: const Text("Sort by"),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              _sortItems();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.schedule),
                            title: const Text("Show Scheduled Items"),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              _filterScheduledItems();
                            },
                          ),
                        ],
                      ),
                    ),
              );
            },
            icon: const Icon(Icons.filter_list),
          ),
          IconButton(onPressed: _addNewItem, icon: const Icon(Icons.add)),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: discoverItems.length,
        itemBuilder: (context, index) {
          final item = discoverItems[index];
          return Card(
            elevation: item.isScheduled ? 6 : 3,
            color: item.isScheduled ? Colors.blue.shade50 : null,
            child: InkWell(
              onTap: () => _showItemDetails(index),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.icon, size: 40, color: Colors.blue),
                      const SizedBox(height: 10),
                      Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => _scheduleItem(index),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text("Schedule"),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => _deleteItem(index),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _sortItems() {
    setState(() {
      discoverItems.sort((a, b) {
        if (a.isScheduled && !b.isScheduled) return -1;
        if (!a.isScheduled && b.isScheduled) return 1;

        return a.title.compareTo(b.title);
      });
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Items sorted')));
  }

  void _filterScheduledItems() {
    setState(() {
      final originalItems = List<DiscoverItem>.from(discoverItems);

      discoverItems = discoverItems.where((item) => item.isScheduled).toList();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Showing ${discoverItems.length} scheduled items'),
          action: SnackBarAction(
            label: 'Reset',
            onPressed: () {
              setState(() {
                discoverItems = originalItems;
              });
            },
          ),
        ),
      );
    });
  }
}

class DiscoverItem {
  final int id;
  final String title;
  final IconData icon;
  final bool isScheduled;
  final DateTime? scheduledDate;
  final TimeOfDay? scheduledTime;

  DiscoverItem({
    required this.id,
    required this.title,
    required this.icon,
    this.isScheduled = false,
    this.scheduledDate,
    this.scheduledTime,
  });

  DiscoverItem copyWith({
    int? id,
    String? title,
    IconData? icon,
    bool? isScheduled,
    DateTime? scheduledDate,
    TimeOfDay? scheduledTime,
  }) {
    return DiscoverItem(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      isScheduled: isScheduled ?? this.isScheduled,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      scheduledTime: scheduledTime ?? this.scheduledTime,
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double _profileCompletionProgress = 0.2;

  final List<Achievement> _achievements = [
    Achievement(
      title: "Beginner Developer",
      description: "Completed profile basics",
      icon: Icons.star,
      isUnlocked: true,
    ),
    Achievement(
      title: "Resume Pro",
      description: "Upload professional resume",
      icon: Icons.workspace_premium,
      isUnlocked: false,
    ),
    Achievement(
      title: "Skill Master",
      description: "Add 5+ skills",
      icon: Icons.emoji_events,
      isUnlocked: false,
    ),
  ];

  void _updateProfileCompletion(String action) {
    setState(() {
      switch (action) {
        case 'details':
          _profileCompletionProgress = 0.4;
          _achievements[1].isUnlocked = true;
          break;
        case 'resume':
          _profileCompletionProgress = 0.6;
          _achievements[1].isUnlocked = true;
          break;
        case 'skills':
          _profileCompletionProgress = 1.0;
          _achievements[2].isUnlocked = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("PROFILE"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _showEnhancedSettingsDialog(context);
            },
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          GestureDetector(
            onTap: () {
              _showProfileEditDialog(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Hero(
                    tag: 'profile-image',
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        "https://imgs.search.brave.com/xySyPOvQ0sVns6fyH5h5seVKgnUI6cU7fQI4HA-s7ZM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/ZGlnZy5jb20vaW1h/Z2VzL2VkNWJmZjVk/ZGY1MjQ1MzVhYjVm/NDMzZGE1YTlmOTNl/X2U5ZDMzNDQ4MDQy/YzQwYTFhMjk5NThk/ZTA2NTg0MTc1X2hl/YWRlci5qcGVn",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Noname",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Senior Python Developer",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Profile Completion",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "${(_profileCompletionProgress * 100).toInt()}%",
                style: const TextStyle(color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: _profileCompletionProgress,
            backgroundColor: Colors.black12,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final card = profileCompletionCards[index];
                return SizedBox(
                  width: 180,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(card.icon, size: 40, color: Colors.blue),
                          const SizedBox(height: 15),
                          Text(
                            card.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              _updateProfileCompletion(
                                card.title.toLowerCase().contains('details')
                                    ? 'details'
                                    : card.title.toLowerCase().contains(
                                      'resume',
                                    )
                                    ? 'resume'
                                    : 'skills',
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${card.buttonText} ${card.title}',
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[50],
                              foregroundColor: Colors.blue,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(card.buttonText),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: profileCompletionCards.length,
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            "Achievements",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _achievements.length,
              itemBuilder: (context, index) {
                final achievement = _achievements[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: 150,
                    child: Card(
                      color:
                          achievement.isUnlocked
                              ? Colors.blue[50]
                              : Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              achievement.icon,
                              color:
                                  achievement.isUnlocked
                                      ? Colors.blue
                                      : Colors.grey,
                              size: 30,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              achievement.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    achievement.isUnlocked
                                        ? Colors.blue
                                        : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),
          ...List.generate(customListTiles.length, (index) {
            final tile = customListTiles[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Card(
                elevation: 4,
                shadowColor: Colors.black12,
                child: ListTile(
                  leading: Icon(tile.icon),
                  title: Text(tile.title),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    if (tile.title == "Logout") {
                      _showLogoutConfirmationDialog(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${tile.title} selected')),
                      );
                    }
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showEnhancedSettingsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Settings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildSettingsOption(
                  context,
                  icon: Icons.person,
                  title: "Account",
                  onTap: () => _showAccountSettingsSnackbar(context),
                ),
                _buildSettingsOption(
                  context,
                  icon: Icons.security,
                  title: "Privacy",
                  onTap: () => _showPrivacySettingsSnackbar(context),
                ),
                _buildSettingsOption(
                  context,
                  icon: Icons.palette,
                  title: "Theme",
                  onTap: () => _showThemeSettingsSnackbar(context),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildSettingsOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  void _showProfileEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Edit Profile"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    "https://imgs.search.brave.com/xySyPOvQ0sVns6fyH5h5seVKgnUI6cU7fQI4HA-s7ZM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/ZGlnZy5jb20vaW1h/Z2VzL2VkNWJmZjVk/ZGY1MjQ1MzVhYjVm/NDMzZGE1YTlmOTNl/X2U5ZDMzNDQ4MDQy/YzQwYTFhMjk5NThk/ZTA2NTg0MTc1X2hl/YWRlci5qcGVn",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: "Noname",
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: "Senior Python Developer",
                  decoration: const InputDecoration(
                    labelText: "Job Title",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully'),
                    ),
                  );
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Logout"),
            content: const Text(
              "Are you sure you want to logout? All unsaved progress will be lost.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logged out successfully'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                child: const Text("Logout"),
              ),
            ],
          ),
    );
  }

  void _showAccountSettingsSnackbar(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Account settings selected')));
  }

  void _showPrivacySettingsSnackbar(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Privacy settings selected')));
  }

  void _showThemeSettingsSnackbar(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Theme settings selected')));
  }
}

class Achievement {
  final String title;
  final String description;
  final IconData icon;
  bool isUnlocked;

  Achievement({
    required this.title,
    required this.description,
    required this.icon,
    this.isUnlocked = false,
  });
}

class ProfileCompletionCard {
  final String title;
  final String buttonText;
  final IconData icon;
  ProfileCompletionCard({
    required this.title,
    required this.buttonText,
    required this.icon,
  });
}

List<ProfileCompletionCard> profileCompletionCards = [
  ProfileCompletionCard(
    title: "Set Your Profile Details",
    icon: CupertinoIcons.person_circle,
    buttonText: "Continue",
  ),
  ProfileCompletionCard(
    title: "Upload your resume",
    icon: CupertinoIcons.doc,
    buttonText: "Upload",
  ),
  ProfileCompletionCard(
    title: "Add your skills",
    icon: CupertinoIcons.square_list,
    buttonText: "Add",
  ),
];

class CustomListTile {
  final IconData icon;
  final String title;
  CustomListTile({required this.icon, required this.title});
}

List<CustomListTile> customListTiles = [
  CustomListTile(icon: Icons.insights, title: "Activity"),
  CustomListTile(icon: Icons.location_on_outlined, title: "Location"),
  CustomListTile(title: "Notifications", icon: CupertinoIcons.bell),
  CustomListTile(title: "Logout", icon: CupertinoIcons.arrow_right_arrow_left),
];
