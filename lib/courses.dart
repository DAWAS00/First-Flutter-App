import 'package:flutter/material.dart';
import 'utils/translations.dart';
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
          context.t('courses'),
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
                        Icons.school,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        context.t('courses'),
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
                    context.t('courseManagement'),
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            
            // Quick Actions Section
            Text(
              context.t('quickActions'),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            const SizedBox(height: 15),
            _buildCourseButton(
              context,
              context.t('reserveFreeTime'),
              Icons.calendar_today_outlined,
              const Color(0xFF4CAF50),
              () {
                // TODO: Navigate to Reserve Free Time page
              },
            ),
            const SizedBox(height: 16),
            _buildCourseButton(
              context,
              context.t('registerCourses'),
              Icons.add_circle_outline,
              const Color(0xFF2196F3),
              () {
                // TODO: Navigate to Register Courses page
              },
            ),
            const SizedBox(height: 16),
            _buildCourseButton(
              context,
              context.t('withdrawalWithoutBalance'),
              Icons.remove_circle_outline,
              const Color(0xFFFF5722),
              () {
                // TODO: Navigate to Withdrawal page
              },
            ),
            const SizedBox(height: 16),
            _buildCourseButton(
              context,
              context.t('printSchedule'),
              Icons.print_outlined,
              const Color(0xFF9C27B0),
              () {
                // TODO: Navigate to Print Schedule page
              },
            ),
            const SizedBox(height: 16),
            _buildCourseButton(
              context,
              context.t('showSchedule'),
              Icons.schedule_outlined,
              const Color(0xFFFF9800),
              () {
                // TODO: Navigate to Show Schedule page
              },
            ),
            const SizedBox(height: 16),
            _buildCourseButton(
              context,
              context.t('inquirySubjects'),
              Icons.search_outlined,
              const Color(0xFF607D8B),
              () {
                // TODO: Navigate to Inquiry page
              },
            ),
            const SizedBox(height: 30),
            
            // Course Catalog Section
            Text(
              context.t('courseCatalog'),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            const SizedBox(height: 15),
            
            _buildCourseActionButton(
              context,
              icon: Icons.book_outlined,
              title: context.t('courseCatalog'),
              description: context.t('browseAvailableCourses'),
              onTap: () {
                // Navigate to Course Catalog
              },
            ),
            const SizedBox(height: 15),
            _buildCourseActionButton(
              context,
              icon: Icons.my_library_books_outlined,
              title: context.t('myCourses'),
              description: context.t('viewYourEnrolledCourses'),
              onTap: () {
                // Navigate to My Courses
              },
            ),
            const SizedBox(height: 15),
            _buildCourseActionButton(
              context,
              icon: Icons.app_registration_outlined,
              title: context.t('courseRegistration'),
              description: context.t('registerForNewCourses'),
              onTap: () {
                // Navigate to Course Registration
              },
            ),
            const SizedBox(height: 15),
            _buildCourseActionButton(
              context,
              icon: Icons.calendar_today_outlined,
              title: context.t('academicCalendar'),
              description: context.t('viewImportantDates'),
              onTap: () {
                // Navigate to Academic Calendar
              },
            ),
            const SizedBox(height: 15),
            _buildCourseActionButton(
              context,
              icon: Icons.folder_open_outlined,
              title: context.t('courseMaterials'),
              description: context.t('accessLectureNotes'),
              onTap: () {
                // Navigate to Course Materials
              },
            ),
            const SizedBox(height: 15),
            _buildCourseActionButton(
              context,
              icon: Icons.rate_review_outlined,
              title: context.t('courseEvaluations'),
              description: context.t('provideFeedback'),
              onTap: () {
                // Navigate to Course Evaluations
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

  Widget _buildCourseActionButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
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