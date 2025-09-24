import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sidebar.dart';
import 'courses.dart';
import 'schedule.dart';
import 'profile.dart';
import 'services/language_service.dart';
import 'utils/translations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const CustomSidebar(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          context.t('home'),
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge?.color,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          // Language Toggle Button
          Consumer<LanguageService>(
            builder: (context, languageService, child) {
              return IconButton(
                icon: Icon(
                  Icons.language,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  languageService.toggleLanguage();
                },
                tooltip: context.t('language'),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
                  Text(
                    '${context.t('welcome')}, Ethan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.t('welcomeMessage'),
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.school,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        context.t('academicDashboard'),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Quick Stats Section
            Text(
              context.t('quickStats'),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            const SizedBox(height: 15),
            
            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('80%', context.t('completionRate')),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildStatCard('120', context.t('completedCredits')),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildStatCard('3.8', context.t('currentGpa')),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Current Semester Section
            Text(
              context.t('currentSemester'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.t('currentSemesterDesc'),
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 15),
            
            // Course Cards
            _buildCourseCard(
              context.t('calculusI'),
              'MATH 101',
              Colors.orange[300]!,
              Icons.calculate,
            ),
            const SizedBox(height: 15),
            _buildCourseCard(
              context.t('introductionToProgramming'),
              'CS 101',
              Colors.teal[400]!,
              Icons.code,
            ),
            const SizedBox(height: 15),
            _buildCourseCard(
              context.t('physicsTitle'),
              'PHYS 101',
              Colors.blue[300]!,
              Icons.science,
            ),
            const SizedBox(height: 15),
            _buildCourseCard(
              context.t('englishTitle'),
              'ENGL 101',
              Colors.amber[300]!,
              Icons.edit,
            ),
            
            const SizedBox(height: 30),
            
            // Recent Activity Section
            Text(
              context.t('recentActivity'),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            const SizedBox(height: 15),
            
            _buildActivityCard(
              context,
              Icons.assignment_turned_in,
              context.t('assignmentSubmitted'),
              'CS101 - ${context.t('projectProposal')}',
              '2 ${context.t('hoursAgo')}',
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildActivityCard(
              context,
              Icons.quiz,
              context.t('examCompleted'),
              'MA101 - ${context.t('midtermExam')}',
              '1 ${context.t('dayAgo')}',
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildActivityCard(
              context,
              Icons.schedule,
              context.t('classAttended'),
              'PHYS 101 - ${context.t('lecture')}',
              '2 ${context.t('daysAgo')}',
              Colors.orange,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          
          // Navigate to different pages based on selected index
          if (index == 1) { // Courses tab
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CoursesPage(),
              ),
            ).then((result) {
              // When returning from Courses page, reset to Home tab
              setState(() {
                _selectedIndex = result ?? 0; // Default to Home tab (0) if no result
              });
            });
          } else if (index == 2) { // Schedule tab
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SchedulePage(),
              ),
            ).then((result) {
              // When returning from Schedule page, reset to Home tab
              if (result != null) {
                setState(() {
                  _selectedIndex = result;
                });
              }
            });
          } else if (index == 3) { // Profile tab
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            ).then((result) {
              // When returning from Profile page, reset to Home tab
              setState(() {
                _selectedIndex = result ?? 0;
              });
            });
          }
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).textTheme.bodyMedium?.color,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 8,
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

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.headlineLarge?.color ?? Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(String title, String code, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.white,
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
                  code,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, IconData icon, String title, String subtitle, String time, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
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
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }
}