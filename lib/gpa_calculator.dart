import 'package:flutter/material.dart';
import 'utils/translations.dart';

class GPACalculatorPage extends StatefulWidget {
  const GPACalculatorPage({super.key});

  @override
  State<GPACalculatorPage> createState() => _GPACalculatorPageState();
}

class _GPACalculatorPageState extends State<GPACalculatorPage> {
  double currentGPA = 3.75;
  List<CourseInput> courses = [CourseInput()];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          context.t('gpaCalculator'),
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
            // Current GPA Section
            _buildCurrentGPASection(),
            
            const SizedBox(height: 30),
            
            // Course Details Section
            _buildCourseDetailsSection(),
            
            const SizedBox(height: 20),
            
            // Add New Subject Button
            _buildAddNewSubjectButton(),
            
            const SizedBox(height: 30),
            
            // Calculate GPA Button
            _buildCalculateGPAButton(),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCurrentGPASection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.t('currentGpa'),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t('gpaLabel'),
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                currentGPA.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildCourseDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.t('courseDetails'),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Headers
        Row(
          children: [
            Expanded(
              child: Text(
                context.t('grade'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                context.t('creditHours'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Course Input Fields
        ...courses.asMap().entries.map((entry) {
          int index = entry.key;
          CourseInput course = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildCourseInputRow(course, index),
          );
        }),
      ],
    );
  }
  
  Widget _buildCourseInputRow(CourseInput course, int index) {
    return Row(
      children: [
        // Grade Input
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              controller: course.gradeController,
              decoration: InputDecoration(
                hintText: context.t('gradeHint'),
                hintStyle: const TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Credit Hours Input
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              controller: course.creditHoursController,
              decoration: InputDecoration(
                hintText: context.t('creditHoursHint'),
                hintStyle: const TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        
        // Delete button (only show if more than one course)
        if (courses.length > 1) ...[
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              setState(() {
                courses.removeAt(index);
              });
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ],
    );
  }
  
  Widget _buildAddNewSubjectButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          setState(() {
            courses.add(CourseInput());
          });
        },
        child: Text(
          context.t('addNewSubject'),
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  
  Widget _buildCalculateGPAButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _calculateGPA,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          context.t('calculateGpa'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  
  void _calculateGPA() {
    double totalGradePoints = 0;
    double totalCreditHours = 0;
    
    for (CourseInput course in courses) {
      String grade = course.gradeController.text.trim().toUpperCase();
      String creditHoursText = course.creditHoursController.text.trim();
      
      if (grade.isNotEmpty && creditHoursText.isNotEmpty) {
        double gradePoint = _getGradePoint(grade);
        double creditHours = double.tryParse(creditHoursText) ?? 0;
        
        if (gradePoint >= 0 && creditHours > 0) {
          totalGradePoints += gradePoint * creditHours;
          totalCreditHours += creditHours;
        }
      }
    }
    
    if (totalCreditHours > 0) {
      double newGPA = totalGradePoints / totalCreditHours;
      setState(() {
        currentGPA = newGPA;
      });
      
      // Show result dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(context.t('gpaCalculationResult')),
            content: Text(
              '${context.t('newGpa')} ${newGPA.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(context.t('ok')),
              ),
            ],
          );
        },
      );
    } else {
      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(context.t('invalidInput')),
            content: Text(
              context.t('validGradesRequired'),
              style: const TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(context.t('ok')),
              ),
            ],
          );
        },
      );
    }
  }
  
  double _getGradePoint(String grade) {
    switch (grade) {
      case 'A+':
      case 'A':
        return 4.0;
      case 'A-':
        return 3.7;
      case 'B+':
        return 3.3;
      case 'B':
        return 3.0;
      case 'B-':
        return 2.7;
      case 'C+':
        return 2.3;
      case 'C':
        return 2.0;
      case 'C-':
        return 1.7;
      case 'D+':
        return 1.3;
      case 'D':
        return 1.0;
      case 'F':
        return 0.0;
      default:
        return -1; // Invalid grade
    }
  }
}

class CourseInput {
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController creditHoursController = TextEditingController();
  
  void dispose() {
    gradeController.dispose();
    creditHoursController.dispose();
  }
}