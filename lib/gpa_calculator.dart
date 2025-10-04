import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/gpa_service.dart';
import 'utils/translations.dart';

class GPACalculatorPage extends StatefulWidget {
  const GPACalculatorPage({super.key});

  @override
  State<GPACalculatorPage> createState() => _GPACalculatorPageState();
}

class _GPACalculatorPageState extends State<GPACalculatorPage> {
  List<CourseInput> courses = [CourseInput()];
  bool _showExplanation = false;
  
  @override
  Widget build(BuildContext context) {
    return Consumer<GPAService>(
      builder: (context, gpaService, child) {
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
            
            // GPA Explanation Section
            _buildGPAExplanationSection(),
            
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
      },
    );
  }
  
  Widget _buildCurrentGPASection() {
    return Consumer<GPAService>(
      builder: (context, gpaService, child) {
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
                    gpaService.currentGPA.toStringAsFixed(2),
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
      },
    );
  }
  
  Widget _buildGPAExplanationSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showExplanation = !_showExplanation;
              });
            },
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'How GPA is Calculated',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const Spacer(),
                Icon(
                  _showExplanation ? Icons.expand_less : Icons.expand_more,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
          
          if (_showExplanation) ...[
          
          const SizedBox(height: 16),
          
          Text(
            'GPA (Grade Point Average) is calculated using this formula:',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 12),
          
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Text(
              'GPA = Total Grade Points ÷ Total Credit Hours',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontFamily: 'monospace',
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'Grade Point Values:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Grade point table
          _buildGradePointTable(),
          
          const SizedBox(height: 16),
          
          Text(
            'Example: If you get an A (4.0) in a 3-credit course, you earn 12.0 grade points (4.0 × 3).',
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontStyle: FontStyle.italic,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Step-by-step example
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Step-by-Step Example:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '• Math: A (4.0) × 3 credits = 12.0 points\n'
                  '• English: B+ (3.3) × 3 credits = 9.9 points\n'
                  '• Science: A- (3.7) × 4 credits = 14.8 points\n'
                  '• Total: 36.7 points ÷ 10 credits = 3.67 GPA',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildGradePointTable() {
    final gradePoints = [
      {'grade': 'A+', 'points': '4.0', 'color': Colors.green[600]!},
      {'grade': 'A', 'points': '4.0', 'color': Colors.green[500]!},
      {'grade': 'A-', 'points': '3.7', 'color': Colors.green[400]!},
      {'grade': 'B+', 'points': '3.3', 'color': Colors.blue[500]!},
      {'grade': 'B', 'points': '3.0', 'color': Colors.blue[400]!},
      {'grade': 'B-', 'points': '2.7', 'color': Colors.blue[300]!},
      {'grade': 'C+', 'points': '2.3', 'color': Colors.orange[500]!},
      {'grade': 'C', 'points': '2.0', 'color': Colors.orange[400]!},
      {'grade': 'C-', 'points': '1.7', 'color': Colors.orange[300]!},
      {'grade': 'D+', 'points': '1.3', 'color': Colors.red[400]!},
      {'grade': 'D', 'points': '1.0', 'color': Colors.red[500]!},
      {'grade': 'F', 'points': '0.0', 'color': Colors.red[600]!},
    ];
    
    return Column(
      children: gradePoints.map((gradeInfo) {
        return Container(
          margin: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 30,
                decoration: BoxDecoration(
                  color: gradeInfo['color'] as Color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    gradeInfo['grade'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '= ${gradeInfo['points']} points',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        );
      }).toList(),
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
                hintText: 'A, B+, C-...',
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
                hintText: '3, 4, 2...',
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
    final gpaService = Provider.of<GPAService>(context, listen: false);
    
    // Clear existing courses
    gpaService.clearCourses();
    
    // Add new courses to the service
    for (CourseInput course in courses) {
      String grade = course.gradeController.text.trim().toUpperCase();
      String creditHoursText = course.creditHoursController.text.trim();
      
      if (grade.isNotEmpty && creditHoursText.isNotEmpty) {
        double gradePoint = gpaService.getGradePoint(grade);
        double creditHours = double.tryParse(creditHoursText) ?? 0;
        
        if (gradePoint >= 0 && creditHours > 0) {
          gpaService.addCourse(CourseGrade.fromInput(grade, creditHours, gradePoint));
        }
      }
    }
    
    // Calculate GPA using the service
    gpaService.calculateGPA();
    
    // Show result dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.t('gpaCalculationResult')),
          content: Text(
            '${context.t('newGpa')} ${gpaService.currentGPA.toStringAsFixed(2)}',
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