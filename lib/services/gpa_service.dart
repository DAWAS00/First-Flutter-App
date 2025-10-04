import 'package:flutter/foundation.dart';

class GPAService extends ChangeNotifier {
  double _currentGPA = 3.75;
  List<CourseGrade> _courses = [];

  // Getters
  double get currentGPA => _currentGPA;
  List<CourseGrade> get courses => List.unmodifiable(_courses);

  // Update GPA
  void updateGPA(double newGPA) {
    _currentGPA = newGPA;
    notifyListeners(); // This tells all listening widgets to rebuild
  }

  // Add a course
  void addCourse(CourseGrade course) {
    _courses.add(course);
    notifyListeners();
  }

  // Remove a course
  void removeCourse(int index) {
    if (index >= 0 && index < _courses.length) {
      _courses.removeAt(index);
      notifyListeners();
    }
  }

  // Clear all courses
  void clearCourses() {
    _courses.clear();
    notifyListeners();
  }

  // Calculate GPA from current courses
  void calculateGPA() {
    if (_courses.isEmpty) return;

    double totalGradePoints = 0;
    double totalCreditHours = 0;

    for (CourseGrade course in _courses) {
      if (course.gradePoint >= 0 && course.creditHours > 0) {
        totalGradePoints += course.gradePoint * course.creditHours;
        totalCreditHours += course.creditHours;
      }
    }

    if (totalCreditHours > 0) {
      double newGPA = totalGradePoints / totalCreditHours;
      updateGPA(newGPA);
    }
  }

  // Get grade point from letter grade
  double getGradePoint(String grade) {
    switch (grade.toUpperCase()) {
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

// Course grade model
class CourseGrade {
  final String grade;
  final double creditHours;
  final double gradePoint;

  CourseGrade({
    required this.grade,
    required this.creditHours,
    required this.gradePoint,
  });

  factory CourseGrade.fromInput(String grade, double creditHours, double gradePoint) {
    return CourseGrade(
      grade: grade,
      creditHours: creditHours,
      gradePoint: gradePoint,
    );
  }
}
