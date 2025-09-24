import 'package:flutter/material.dart';
import 'courses.dart';
import 'schedule.dart';
import 'student_information.dart';
import 'main.dart';
import 'utils/translations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3; // Profile tab is index 3

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          context.t('profile'),
          style: const TextStyle(
            color: null,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          // Dark Mode Toggle Button
          IconButton(
            icon: Icon(Icons.brightness_6_outlined, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              // Toggle light/dark theme for the whole app
              final appState = MyApp.of(context);
              appState?.toggleTheme();
            },
            tooltip: context.t('darkMode'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile Picture Section
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.orange[300]!, Colors.orange[400]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/profile_image.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // University and Major
            Text(
              context.t('universityOfIdk'),
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              context.t('computerScience'),
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodySmall?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),

            // Personal Information Section
            SizedBox(
              width: double.infinity,
              child: Text(
                context.t('personalInformation'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Student ID Card
            _buildInfoCard(
              icon: Icons.badge_outlined,
              title: context.t('studentId'),
              value: context.t('studentIdValue'),
              color: Colors.green,
            ),
            const SizedBox(height: 15),

            // Full Name Card
            _buildInfoCard(
              icon: Icons.person_outline,
              title: context.t('fullName'),
              value: context.t('fullNameValue'),
              color: Colors.blue,
            ),
            const SizedBox(height: 15),

            // Email Card
            _buildInfoCard(
              icon: Icons.email_outlined,
              title: context.t('email'),
              value: context.t('emailValue'),
              color: Colors.orange,
            ),
            const SizedBox(height: 15),

            // Phone Number Card
            _buildInfoCard(
              icon: Icons.phone_outlined,
              title: context.t('phoneNumber'),
              value: context.t('phoneValue'),
              color: Colors.purple,
            ),
            const SizedBox(height: 15),

            // Advisor Name Card
            _buildInfoCard(
              icon: Icons.school_outlined,
              title: context.t('advisor'),
              value: context.t('advisorValue'),
              color: Colors.teal,
            ),
            const SizedBox(height: 15),

            // Year/Level Card
            _buildInfoCard(
              icon: Icons.calendar_today_outlined,
              title: context.t('academicYear'),
              value: context.t('academicYearValue'),
              color: Colors.indigo,
            ),
            const SizedBox(height: 15),

            // Location/Date of Birth Card
            _buildInfoCard(
              icon: Icons.location_on_outlined,
              title: '${context.t('address')}/${context.t('dateOfBirth')}',
              value: context.t('locationValue'),
              color: Colors.red,
            ),
            const SizedBox(height: 30),

            // Additional Actions Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to detailed student information page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentInformationPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  context.t('studentsPersonalInfo'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
            Navigator.pop(context, 0);
          } else if (index == 1) { // Courses tab
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CoursesPage(),
              ),
            );
          } else if (index == 2) { // Schedule tab
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SchedulePage(),
              ),
            );
          } else {
            // Current page is Profile (index 3), update state only if staying on this page
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

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}