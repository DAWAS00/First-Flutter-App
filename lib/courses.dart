import 'package:flutter/material.dart';
import 'schedule.dart';
import 'profile.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  int _selectedIndex = 1; // Set to 1 since this is the Courses page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Courses',
          style: const TextStyle(
            color: null,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        automaticallyImplyLeading: false, // This removes the back arrow
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildCourseButton(
              context,
              'Reserve a Free Time',
              Icons.calendar_today_outlined,
              const Color(0xFF4CAF50),
              () {
                // TODO: Navigate to Reserve Free Time page
              },
            ),
            const SizedBox(height: 16),
            _buildCourseButton(
              context,
              'Register Courses',
              Icons.add_circle_outline,
              const Color(0xFF2196F3),
              () {
                // TODO: Navigate to Register Courses page
              },
            ),
            const SizedBox(height: 16),
            _buildCourseButton(
              context,
              'Withdrawal Without Balance',
              Icons.remove_circle_outline,
              const Color(0xFFFF5722),
              () {
                // TODO: Navigate to Withdrawal page
              },
            ),
            const SizedBox(height: 16),
            _buildCourseButton(
              context,
              'Print Schedule',
              Icons.print_outlined,
              const Color(0xFF9C27B0),
              () {
                // TODO: Navigate to Print Schedule page
              },
            ),
            const SizedBox(height: 16),
            _buildCourseButton(
              context,
              'Show Schedule',
              Icons.schedule_outlined,
              const Color(0xFFFF9800),
              () {
                // TODO: Navigate to Show Schedule page
              },
            ),
            const SizedBox(height: 16),
            _buildCourseButton(
              context,
              'Inquiry About Available Subjects',
              Icons.search_outlined,
              const Color(0xFF607D8B),
              () {
                // TODO: Navigate to Inquiry page
              },
            ),
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
          } else if (index == 2) { // Schedule tab
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SchedulePage(),
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
            // Current page is Courses (index 1), update state only if staying on this page
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).textTheme.bodyMedium?.color,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCourseButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).textTheme.bodySmall?.color,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}