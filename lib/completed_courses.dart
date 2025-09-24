import 'package:flutter/material.dart';
import 'utils/translations.dart';

class CompletedCoursesPage extends StatelessWidget {
  const CompletedCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          context.t('completedCourses'),
          style: const TextStyle(
            color: null,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fall 2023 Section
            _buildSemesterSection(
              context,
              context.t('fall2023'),
              [
                CourseData('CS101', context.t('introductionToProgramming'), 'A'),
                CourseData('MA101', context.t('calculusI'), 'B+'),
                CourseData('PH101', context.t('physicsI'), 'A-'),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Spring 2024 Section
            _buildSemesterSection(
              context,
              context.t('spring2024'),
              [
                CourseData('CS201', context.t('dataStructures'), 'A'),
                CourseData('MA201', context.t('calculusII'), 'B'),
                CourseData('PH201', context.t('physicsII'), 'A-'),
              ],
            ),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSemesterSection(BuildContext context, String semester, List<CourseData> courses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Semester Header
        Text(
          semester,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Course Cards
        ...courses.map((course) => _buildCourseCard(context, course)),
      ],
    );
  }
  
  Widget _buildCourseCard(BuildContext context, CourseData course) {
    return Container(
      width: double.infinity,
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
          // Course Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.code,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  course.name,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          
          // Grade
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getGradeColor(course.grade),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              course.grade,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
      case 'A+':
        return Colors.green[600]!;
      case 'A-':
        return Colors.green[500]!;
      case 'B+':
        return Colors.blue[600]!;
      case 'B':
        return Colors.blue[500]!;
      case 'B-':
        return Colors.blue[400]!;
      case 'C+':
        return Colors.orange[600]!;
      case 'C':
        return Colors.orange[500]!;
      case 'C-':
        return Colors.orange[400]!;
      case 'D':
        return Colors.red[400]!;
      case 'F':
        return Colors.red[600]!;
      default:
        return Colors.grey[600]!;
    }
  }
}

class CourseData {
  final String code;
  final String name;
  final String grade;
  
  CourseData(this.code, this.name, this.grade);
}