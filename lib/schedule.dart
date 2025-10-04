import 'package:flutter/material.dart';
import 'utils/translations.dart';
import 'courses.dart';
import 'profile.dart';
import 'services/notification_service.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int _selectedIndex = 2; // Schedule tab index
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();
  final Map<DateTime, String> _notes = {}; // Store notes for each date

  // Notification testing variables
  int _testNotificationSeconds = 5;
  bool _isTestingNotifications = false;

  @override
  void initState() {
    super.initState();
    _scheduleNotifications();
  }

  // Schedule notifications for assignments and exams
  void _scheduleNotifications() async {
    // Request notification permissions first
    await NotificationService.instance.requestPermissions();
    
    // Schedule assignment notifications
    for (var assignment in _assignments) {
      await NotificationHelper.showAssignmentReminder(
        assignment['title'].toString().split(' - ')[1],
        assignment['title'].toString().split(' - ')[0],
        _parseDueDate(assignment['dueDate']),
      );
    }
    
    // Schedule exam notifications
    for (var assignment in _assignments) {
      if (assignment['title'].toString().contains('Exam')) {
        await NotificationHelper.showExamReminder(
          assignment['title'].toString().split(' - ')[1],
          assignment['title'].toString().split(' - ')[0],
          _parseDueDate(assignment['dueDate']),
        );
      }
    }
  }

  // Parse due date string to DateTime
  DateTime _parseDueDate(String dueDateStr) {
    // Simple parsing for demo - in real app, use proper date parsing
    if (dueDateStr.contains('January 25')) {
      return DateTime(2025, 1, 25);
    } else if (dueDateStr.contains('February 1')) {
      return DateTime(2025, 2, 1);
    }
    return DateTime.now().add(const Duration(days: 7)); // Default fallback
  }

  // Sample assignment deadlines
  List<Map<String, dynamic>> get _assignments => [
    {
      'title': 'CS101 - ${context.t('projectProposal')}',
      'dueDate': 'January 25, 2025',
      'color': const Color(0xFF4CAF50),
      'icon': Icons.assignment,
    },
    {
      'title': 'MA101 - ${context.t('midtermExam')}',
      'dueDate': 'February 1, 2025',
      'color': const Color(0xFF4CAF50),
      'icon': Icons.quiz,
    },
  ];

  // Sample lecture reminders
  List<Map<String, dynamic>> get _reminders => [
    {
      'title': 'CS101 - ${context.t('lecture')}',
      'room': '${context.t('room')} 201',
      'color': const Color(0xFF4CAF50),
      'icon': Icons.access_time,
    },
    {
      'title': 'MA101 - ${context.t('discussionTitle')}',
      'room': '${context.t('room')} 105',
      'color': const Color(0xFF4CAF50),
      'icon': Icons.access_time,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          context.t('schedule'),
          style: const TextStyle(
            color: null,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        context.t('schedule'),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.t('scheduleManagement'),
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            
            // Calendar Section
            _buildCalendarSection(),
            const SizedBox(height: 24),
            
            // Assignment Deadlines Section
            _buildAssignmentDeadlinesSection(),
            const SizedBox(height: 24),
            
            // Reminders Section
            _buildRemindersSection(),
            const SizedBox(height: 24),
            
            // Notification Test Section
            _buildNotificationTestSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Navigate to different pages based on selected index
          if (index == 0) { // Home tab
            Navigator.pop(context, 0); // Go back to home and pass the index
          } else if (index == 1) { // Courses tab
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CoursesPage(),
              ),
            );
          } else if (index == 3) { // Profile tab
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          } else {
            // Current page is Schedule (index 2), update state only if staying on this page
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).textTheme.bodyMedium?.color,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.t('home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book),
            label: context.t('courses'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.schedule),
            label: context.t('schedule'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: context.t('profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Calendar Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
                  });
                },
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                _getMonthYearString(_currentMonth),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
                  });
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Calendar Grid
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInWeek = [
      context.t('sun'),
      context.t('mon'),
      context.t('tue'),
      context.t('wed'),
      context.t('thu'),
      context.t('fri'),
      context.t('sat'),
    ];
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final startDate = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));
    
    return Column(
      children: [
        // Week day headers
        Row(
          children: daysInWeek.map((day) => Expanded(
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 8),
        
        // Calendar days
        ...List.generate(6, (weekIndex) {
          return Row(
            children: List.generate(7, (dayIndex) {
              final date = startDate.add(Duration(days: weekIndex * 7 + dayIndex));
              final isCurrentMonth = date.month == _currentMonth.month;
              final isToday = _isSameDay(date, DateTime.now());
              final isSelected = _isSameDay(date, _selectedDate);
              final hasNote = _notes.containsKey(_getDateKey(date));
              
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isCurrentMonth) {
                      setState(() {
                        _selectedDate = date;
                      });
                      _showNoteDialog(date);
                    }
                  },
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? Theme.of(context).colorScheme.primary
                          : isToday 
                              ? Theme.of(context).dividerColor
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            '${date.day}',
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : isCurrentMonth
                                      ? Theme.of(context).textTheme.bodyLarge?.color
                                      : Theme.of(context).textTheme.bodySmall?.color,
                              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                        if (hasNote)
                          Positioned(
                            top: 2,
                            right: 2,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.white : const Color(0xFF4CAF50),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }

  Widget _buildAssignmentDeadlinesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.t('assignmentDeadlines'),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 12),
        ..._assignments.map((assignment) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: assignment['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  assignment['icon'],
                  color: assignment['color'],
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assignment['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Due: ${assignment['dueDate']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildRemindersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.t('reminders'),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 12),
        ..._reminders.map((reminder) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: reminder['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  reminder['icon'],
                  color: reminder['color'],
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reminder['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      reminder['room'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  void _showNoteDialog(DateTime date) {
    final dateKey = _getDateKey(date);
    final existingNote = _notes[dateKey] ?? '';
    final controller = TextEditingController(text: existingNote);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${context.t('note')} ${_getDateString(date)}'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: context.t('addNoteForDate'),
            border: const OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.t('cancel')),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                if (controller.text.trim().isEmpty) {
                  _notes.remove(dateKey);
                } else {
                  _notes[dateKey] = controller.text.trim();
                }
              });
              Navigator.pop(context);
            },
            child: Text(context.t('save')),
          ),
        ],
      ),
    );
  }

  String _getMonthYearString(DateTime date) {
    final months = [
      context.t('january'), context.t('february'), context.t('march'), context.t('april'), 
      context.t('may'), context.t('june'), context.t('july'), context.t('august'), 
      context.t('september'), context.t('october'), context.t('november'), context.t('december')
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  String _getDateString(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  DateTime _getDateKey(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  Widget _buildNotificationTestSection() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bug_report,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Test Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Time picker for notification delay
            Row(
              children: [
                Text(
                  'Schedule in:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _testNotificationSeconds,
                      items: [
                        const DropdownMenuItem(value: 5, child: Text('5 seconds')),
                        const DropdownMenuItem(value: 10, child: Text('10 seconds')),
                        const DropdownMenuItem(value: 30, child: Text('30 seconds')),
                        const DropdownMenuItem(value: 60, child: Text('1 minute')),
                        const DropdownMenuItem(value: 120, child: Text('2 minutes')),
                        const DropdownMenuItem(value: 300, child: Text('5 minutes')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _testNotificationSeconds = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Test notification buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTestButton(
                  'Test Now',
                  Icons.notifications_active,
                  () => _testImmediateNotification(),
                ),
                _buildTestButton(
                  'Assignment Due',
                  Icons.assignment,
                  () => _testAssignmentNotification(),
                ),
                _buildTestButton(
                  'Exam Reminder',
                  Icons.quiz,
                  () => _testExamNotification(),
                ),
                _buildTestButton(
                  'Grade Update',
                  Icons.grade,
                  () => _testGradeNotification(),
                ),
                _buildTestButton(
                  'Attendance',
                  Icons.access_time,
                  () => _testAttendanceNotification(),
                ),
              ],
            ),
            
            if (_isTestingNotifications)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Notification scheduled for $_testNotificationSeconds seconds...',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestButton(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: _isTestingNotifications ? null : onPressed,
      icon: Icon(icon, size: 16),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: const Size(0, 32),
      ),
    );
  }

  // Test notification methods
  void _testImmediateNotification() async {
    setState(() {
      _isTestingNotifications = true;
    });
    
    try {
      await NotificationService.instance.showNotification(
        id: 1001,
        title: 'Test Notification!',
        body: 'This is a test notification to verify the system is working',
        payload: 'test:immediate',
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Immediate notification sent!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error showing notification: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
    
    _resetTestingState();
  }

  void _testAssignmentNotification() async {
    setState(() {
      _isTestingNotifications = true;
    });
    
    try {
      await NotificationService.instance.scheduleNotification(
        id: 2001,
        title: 'Assignment Due Soon!',
        body: 'CS101 Project Proposal is due in 24 hours',
        scheduledDate: DateTime.now().add(Duration(seconds: _testNotificationSeconds)),
        payload: 'test:assignment',
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Assignment notification scheduled for $_testNotificationSeconds seconds'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error scheduling notification: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
    
    _resetTestingState();
  }

  void _testExamNotification() async {
    setState(() {
      _isTestingNotifications = true;
    });
    
    try {
      await NotificationService.instance.scheduleNotification(
        id: 2002,
        title: 'Exam Tomorrow!',
        body: 'MA101 Midterm Exam is scheduled for tomorrow at 10:00 AM',
        scheduledDate: DateTime.now().add(Duration(seconds: _testNotificationSeconds)),
        payload: 'test:exam',
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exam notification scheduled for $_testNotificationSeconds seconds'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error scheduling notification: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
    
    _resetTestingState();
  }

  void _testGradeNotification() async {
    setState(() {
      _isTestingNotifications = true;
    });
    
    try {
      await NotificationService.instance.scheduleNotification(
        id: 2003,
        title: 'New Grade Available',
        body: 'Your grade for CS101 Assignment has been updated: A-',
        scheduledDate: DateTime.now().add(Duration(seconds: _testNotificationSeconds)),
        payload: 'test:grade',
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Grade notification scheduled for $_testNotificationSeconds seconds'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error scheduling notification: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
    
    _resetTestingState();
  }

  void _testAttendanceNotification() async {
    setState(() {
      _isTestingNotifications = true;
    });
    
    try {
      await NotificationService.instance.scheduleNotification(
        id: 2004,
        title: 'Class Starting Soon',
        body: 'CS101 Lecture starts in 15 minutes - Room 201',
        scheduledDate: DateTime.now().add(Duration(seconds: _testNotificationSeconds)),
        payload: 'test:attendance',
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance notification scheduled for $_testNotificationSeconds seconds'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error scheduling notification: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
    
    _resetTestingState();
  }

  void _resetTestingState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTestingNotifications = false;
        });
      }
    });
  }
}