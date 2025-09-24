import 'package:flutter/material.dart';

class AttendancePolicyPage extends StatelessWidget {
  const AttendancePolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Attendance Policy',
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
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'University Attendance Policy',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please read this policy carefully to understand attendance requirements and procedures.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 25),
            
            // Absence Counting Section
            _buildPolicySection(
              context: context,
              title: 'How Absences Are Counted',
              icon: Icons.calculate_outlined,
              iconColor: Colors.orange,
              content: [
                _buildPolicyItem(
                  context,
                  '• Each missed class session counts as 1 absence',
                  'Whether you miss 1 hour or the entire class, it counts as one absence.',
                ),
                _buildPolicyItem(
                  context,
                  '• Late arrivals (15+ minutes) count as 0.5 absence',
                  'Arriving more than 15 minutes late will be recorded as half an absence.',
                ),
                _buildPolicyItem(
                  context,
                  '• Early departures (15+ minutes) count as 0.5 absence',
                  'Leaving more than 15 minutes before class ends counts as half an absence.',
                ),
                _buildPolicyItem(
                  context,
                  '• Maximum allowed absences: 25% of total class sessions',
                  'For a course with 32 sessions, you can miss up to 8 classes maximum.',
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            
            // Absence Limits Section
            _buildPolicySection(
              context: context,
              title: 'Absence Limits & Consequences',
              icon: Icons.warning_outlined,
              iconColor: Colors.red,
              content: [
                _buildPolicyItem(
                  context,
                  '• Warning at 15% absences (Yellow Alert)',
                  'You will receive a notification when you reach 15% of allowed absences.',
                ),
                _buildPolicyItem(
                  context,
                  '• Final warning at 20% absences (Orange Alert)',
                  'A serious warning will be issued when you reach 20% absence rate.',
                ),
                _buildPolicyItem(
                  context,
                  '• Course failure at 25%+ absences (Red Alert)',
                  'Exceeding 25% absence rate results in automatic course failure.',
                ),
                _buildPolicyItem(
                  context,
                  '• No makeup exams if absent on exam day without excuse',
                  'Missing exams without valid medical excuse results in zero grade.',
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            
            // Medical Excuse Section
            _buildPolicySection(
              context: context,
              title: 'Medical Excuse Submission Process',
              icon: Icons.local_hospital_outlined,
              iconColor: Colors.green,
              content: [
                _buildPolicyItem(
                  context,
                  '• Visit the university medical center within 3 days',
                  'You must see the university doctor within 3 days of your absence.',
                ),
                _buildPolicyItem(
                  context,
                  '• Bring your student ID and medical documents',
                  'Required: Student ID, medical report, prescription (if any).',
                ),
                _buildPolicyItem(
                  context,
                  '• Doctor will verify and approve the excuse',
                  'The university doctor will examine your case and approve valid excuses.',
                ),
                _buildPolicyItem(
                  context,
                  '• Approved excuses don\'t count toward absence limit',
                  'Medically excused absences will be removed from your record.',
                ),
                _buildPolicyItem(
                  context,
                  '• Submit excuse request through student portal',
                  'After doctor approval, submit the digital form in your student account.',
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            
            // Contact Information
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.contact_support_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Need Help?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildContactItem(Icons.local_hospital, 'University Medical Center', 'Building A, Floor 2, Room 205'),
                  _buildContactItem(Icons.schedule, 'Operating Hours', 'Sunday - Thursday: 8:00 AM - 4:00 PM'),
                  _buildContactItem(Icons.phone, 'Emergency Contact', '+1 (555) 123-4567'),
                  _buildContactItem(Icons.email, 'Email Support', 'medical@university.edu'),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPolicySection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> content,
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
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...content,
        ],
      ),
    );
  }
  
  Widget _buildPolicyItem(BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).textTheme.bodySmall?.color,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildContactItem(IconData icon, String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.green[600]),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  info,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}