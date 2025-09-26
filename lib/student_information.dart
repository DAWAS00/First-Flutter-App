import 'package:flutter/material.dart';
import 'utils/translations.dart';

class StudentInformationPage extends StatefulWidget {
  const StudentInformationPage({super.key});

  @override
  State<StudentInformationPage> createState() => _StudentInformationPageState();
}

class _StudentInformationPageState extends State<StudentInformationPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Editable fields - these can be changed by the student
  final TextEditingController _phoneController = TextEditingController(text: '+1 (555) 123-4567');
  final TextEditingController _emailController = TextEditingController(text: 'john.carter@ucla.edu');
  final TextEditingController _emergencyContactController = TextEditingController(text: 'Jane Carter - +1 (555) 987-6543');
  final TextEditingController _addressController = TextEditingController(text: '123 Westwood Blvd, Los Angeles, CA 90024');
  
  // Non-editable fields - these are managed by the university
  final String studentId = '123456789';
  final String fullName = 'John Carter';
  final String dateOfBirth = '05/15/1998';
  final String academicYear = 'Junior (3rd Year)';
  final String major = 'Computer Science';
  final String advisor = 'Dr. Olivia Bennett';
  final String gpa = '3.85/4.0';
  final String creditsCompleted = '78/120';
  final String expectedGraduation = 'Spring 2025';
  final String enrollmentStatus = 'Full-time';

  bool _isEditing = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _emergencyContactController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.t('infoUpdated')),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      // Reset controllers to original values
      _phoneController.text = '+1 (555) 123-4567';
      _emailController.text = 'john.carter@ucla.edu';
      _emergencyContactController.text = 'Jane Carter - +1 (555) 987-6543';
      _addressController.text = '123 Westwood Blvd, Los Angeles, CA 90024';
    });
  }

  Widget _buildNonEditableField(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).textTheme.bodySmall?.color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.lock,
            color: Theme.of(context).textTheme.bodySmall?.color,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller, IconData icon, {String? Function(String?)? validator}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isEditing ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isEditing ? Theme.of(context).colorScheme.primary : Theme.of(context).dividerColor,
          width: _isEditing ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _isEditing ? Theme.of(context).colorScheme.primary : Colors.green[500],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: _isEditing ? Theme.of(context).colorScheme.primary : Theme.of(context).textTheme.bodySmall?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                _isEditing
                    ? TextFormField(
                        controller: controller,
                        validator: validator,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      )
                    : Text(
                        controller.text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
              ],
            ),
          ),
          Icon(
            _isEditing ? Icons.edit : Icons.edit_outlined,
            color: _isEditing ? Theme.of(context).colorScheme.primary : Colors.green[600],
            size: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          context.t('studentInformation'),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: null,
        elevation: 0,
        actions: [
          if (!_isEditing)
            IconButton(
              onPressed: _toggleEdit,
              icon: const Icon(Icons.edit),
              tooltip: context.t('editInformation'),
            ),
          if (_isEditing) ...[
            IconButton(
              onPressed: _cancelEdit,
              icon: const Icon(Icons.close),
              tooltip: context.t('cancel'),
            ),
            IconButton(
              onPressed: _saveChanges,
              icon: const Icon(Icons.check),
              tooltip: context.t('saveChanges'),
            ),
          ],
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with legend
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.t('fieldTypesLegend'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.lock, color: Theme.of(context).textTheme.bodySmall?.color, size: 20),
                        const SizedBox(width: 8),
                        Text(context.t('universityManaged'), style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.edit_outlined, color: Colors.green[600], size: 20),
                        const SizedBox(width: 8),
                        Text(context.t('studentEditable'), style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              Text(
                context.t('academicInformation'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 16),
              
              // Non-editable academic fields
              _buildNonEditableField(context.t('studentId'), studentId, Icons.badge),
              _buildNonEditableField(context.t('fullName'), fullName, Icons.person),
              _buildNonEditableField(context.t('dateOfBirth'), dateOfBirth, Icons.cake),
              _buildNonEditableField(context.t('academicYear'), academicYear, Icons.school),
              _buildNonEditableField(context.t('major'), major, Icons.book),
              _buildNonEditableField(context.t('advisor'), advisor, Icons.supervisor_account),
              _buildNonEditableField(context.t('gpa'), gpa, Icons.grade),
              _buildNonEditableField(context.t('creditsCompleted'), creditsCompleted, Icons.assignment_turned_in),
              _buildNonEditableField(context.t('expectedGraduation'), expectedGraduation, Icons.event),
              _buildNonEditableField(context.t('enrollmentStatus'), enrollmentStatus, Icons.how_to_reg),
              
              const SizedBox(height: 24),
              
              Text(
                context.t('contactInformation'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 16),
              
              // Editable contact fields
              _buildEditableField(
                context.t('emailAddress'),
                _emailController,
                Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.t('emailRequired');
                  }
                  if (!value.contains('@')) {
                    return context.t('validEmail');
                  }
                  return null;
                },
              ),
              
              _buildEditableField(
                context.t('phoneNumber'),
                _phoneController,
                Icons.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.t('phoneRequired');
                  }
                  return null;
                },
              ),
              
              _buildEditableField(
                context.t('address'),
                _addressController,
                Icons.home,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.t('addressRequired');
                  }
                  return null;
                },
              ),
              
              _buildEditableField(
                context.t('emergencyContact'),
                _emergencyContactController,
                Icons.emergency,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.t('emergencyRequired');
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}