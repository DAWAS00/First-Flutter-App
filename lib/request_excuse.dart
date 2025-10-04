import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'services/language_service.dart';
import 'services/notification_service.dart';
import 'utils/translations.dart';

class RequestExcusePage extends StatefulWidget {
  const RequestExcusePage({super.key});

  @override
  State<RequestExcusePage> createState() => _RequestExcusePageState();
}

class _RequestExcusePageState extends State<RequestExcusePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _courseController = TextEditingController();
  final _reasonController = TextEditingController();
  final _symptomsController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  DateTime? _selectedDate;
  String? _selectedExcuseType;
  final List<File> _uploadedImages = [];
  
  List<String> get _excuseTypes => [
    context.t('medicalEmergency'),
    context.t('illness'),
    context.t('surgery'),
    context.t('familyEmergency'),
    context.t('mentalHealth'),
    context.t('chronicCondition'),
    context.t('other')
  ];

  final List<String> _courses = [
    'CS 101',
    'MATH 101', 
    'PHYS 101',
    'ENGL 101'
  ];

  @override
  void initState() {
    super.initState();
    _scheduleAttendanceReminder();
  }

  // Schedule attendance reminder notification
  void _scheduleAttendanceReminder() async {
    // Schedule a reminder for tomorrow's classes
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    await NotificationHelper.showAttendanceReminder(
      'Don\'t forget to attend your classes tomorrow!',
      'You have ${_courses.length} classes scheduled.',
      tomorrow,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _courseController.dispose();
    _reasonController.dispose();
    _symptomsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          context.t('medicalExcuseForm'),
          style: const TextStyle(
            color: null,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.medical_services_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 28,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      context.t('medicalExcuseForm'),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.t('formInstructions'),
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 25),
              
              // Student Information Section
              _buildFormSection(
                title: context.t('personalInfo'),
                icon: Icons.person_outline,
                iconColor: Colors.green,
                children: [
                  _buildTextFormField(
                    controller: _nameController,
                    label: context.t('studentName'),
                    hint: context.t('studentName'),
                    icon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextFormField(
                    controller: _studentIdController,
                    label: context.t('studentId'),
                    hint: context.t('studentId'),
                    icon: Icons.badge,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.t('pleaseEnterStudentId');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextFormField(
                    controller: _courseController,
                    label: context.t('courseName'),
                    hint: context.t('courseName'),
                    icon: Icons.school,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.t('pleaseEnterCourseName');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDatePicker(),
                ],
              ),
              
              const SizedBox(height: 25),
              
              // Excuse Details Section
              _buildFormSection(
                title: context.t('excuseDetails'),
                icon: Icons.description_outlined,
                iconColor: Colors.orange,
                children: [
                  _buildDropdownField(),
                  const SizedBox(height: 16),
                  _buildTextFormField(
                    controller: _reasonController,
                    label: context.t('reasonForAbsence'),
                    hint: context.t('reasonForAbsence'),
                    icon: Icons.info_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.t('pleaseEnterReason');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextFormField(
                    controller: _symptomsController,
                    label: context.t('symptomsCondition'),
                    hint: context.t('symptomsCondition'),
                    icon: Icons.healing,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.t('pleaseDescribeSymptoms');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextFormField(
                    controller: _descriptionController,
                    label: context.t('additionalDetails'),
                    hint: context.t('additionalDetails'),
                    icon: Icons.notes,
                    maxLines: 4,
                  ),
                ],
              ),
              
              const SizedBox(height: 25),
              
              // Document Upload Section
              _buildFormSection(
                title: context.t('medicalDocuments'),
                icon: Icons.upload_file_outlined,
                iconColor: Colors.purple,
                children: [
                  _buildPhotoUploadSection(),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    context.t('submitExcuseRequest'),
                    style: const TextStyle(
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
      ),
    );
  }
  
  Widget _buildFormSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
  
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(color: theme.textTheme.bodySmall?.color?.withOpacity(0.9)),
        labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
        prefixIcon: Icon(icon, color: theme.iconTheme.color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        filled: true,
        fillColor: isDark ? theme.cardColor.withOpacity(0.6) : theme.cardColor,
      ),
    );
  }
  
  Widget _buildDatePicker() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 30)),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(8),
          color: isDark ? theme.cardColor.withOpacity(0.6) : theme.cardColor,
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: theme.iconTheme.color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _selectedDate != null
                    ? '${context.t('absenceDate')}: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                    : context.t('selectAbsenceDate'),
                style: TextStyle(
                  color: _selectedDate != null ? theme.textTheme.bodyLarge?.color : theme.textTheme.bodySmall?.color,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDropdownField() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return DropdownButtonFormField<String>(
      initialValue: _selectedExcuseType,
      decoration: InputDecoration(
        labelText: context.t('excuseType'),
        hintStyle: TextStyle(color: theme.textTheme.bodySmall?.color?.withOpacity(0.9)),
        prefixIcon: Icon(Icons.category, color: theme.iconTheme.color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        filled: true,
        fillColor: isDark ? theme.cardColor.withOpacity(0.6) : theme.cardColor,
      ),
      items: _excuseTypes.map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedExcuseType = newValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return context.t('pleaseSelectExcuseType');
        }
        return null;
      },
    );
  }
  
  Widget _buildPhotoUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).cardColor.withOpacity(0.6)
                : Theme.of(context).cardColor,
          ),
          child: Column(
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 48,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(height: 12),
              Text(
                context.t('uploadMedicalDocuments'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.t('uploadInstructions'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.add_photo_alternate),
                label: Text(context.t('choosePhotos')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        
        if (_uploadedImages.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            '${context.t('uploadedDocuments')} (${_uploadedImages.length})',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: _uploadedImages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _uploadedImages[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ],
    );
  }
  
  void _pickImages() {
    // Simulate image picker functionality
    // In a real app, you would use image_picker package
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.t('imagePickerMessage')),
        backgroundColor: Colors.blue,
      ),
    );
  }
  
  void _removeImage(int index) {
    setState(() {
      _uploadedImages.removeAt(index);
    });
  }
  
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.t('pleaseSelectAbsenceDate')),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(context.t('requestSubmitted')),
            content: Text(context.t('requestSubmittedMessage')),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Go back to sidebar
                },
                child: Text(context.t('ok')),
              ),
            ],
          );
        },
      );
    }
  }
}