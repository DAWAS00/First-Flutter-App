import 'package:flutter/material.dart';
import 'utils/translations.dart';
import 'services/notification_service.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  @override
  void initState() {
    super.initState();
    _checkForNewGrades();
  }

  // Simulate checking for new grades and showing notifications
  void _checkForNewGrades() async {
    // Simulate checking for new grades
    await Future.delayed(const Duration(seconds: 2));
    
    // Show notification for new grade (example)
    await NotificationHelper.showGradeUpdate(
      'Computer Science 101',
      'A+'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          context.t('grades'),
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).appBarTheme.foregroundColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Midterm and Final Result Section
            _buildSectionHeader(context, context.t('midtermFinalResult')),
            const SizedBox(height: 16),
            
            _buildMidtermFinalCard(context, context.t('cs101Code'), context.t('programmingCourse'), '85/92'),
            const SizedBox(height: 12),
            _buildMidtermFinalCard(context, context.t('ma101Code'), context.t('calculusCourse'), '78/88'),
            const SizedBox(height: 12),
            _buildMidtermFinalCard(context, context.t('ph101Code'), context.t('physicsCourse'), '90/95'),
            
            const SizedBox(height: 30),
            
            // Final Result Section
            _buildSectionHeader(context, context.t('finalResult')),
            const SizedBox(height: 16),
            
            _buildFinalResultCard(context, context.t('cs101Code'), context.t('programmingCourse'), 'A'),
            const SizedBox(height: 12),
            _buildFinalResultCard(context, context.t('ma101Code'), context.t('calculusCourse'), 'B+'),
            const SizedBox(height: 12),
            _buildFinalResultCard(context, context.t('ph101Code'), context.t('physicsCourse'), 'A-'),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
    );
  }
  
  Widget _buildMidtermFinalCard(BuildContext context, String courseCode, String courseName, String score) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
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
                  courseCode,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleMedium?.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  courseName,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          
          // Score
          Text(
            score,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFinalResultCard(BuildContext context, String courseCode, String courseName, String grade) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
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
                  courseCode,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleMedium?.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  courseName,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          
          // Grade
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getGradeColor(grade),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              grade,
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