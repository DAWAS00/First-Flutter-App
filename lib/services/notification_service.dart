import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

/// Optimized notification service with lazy initialization and minimal memory footprint
class NotificationService {
  static NotificationService? _instance;
  static NotificationService get instance => _instance ??= NotificationService._();
  
  NotificationService._();
  
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  bool _isInitialized = false;
  bool _permissionsGranted = false;
  
  /// Lazy initialization - only initialize when actually needed
  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;
    
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    
    // Initialize timezone data only once
    tz.initializeTimeZones();
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    await _flutterLocalNotificationsPlugin!.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
    
    _isInitialized = true;
  }
  
  /// Request permissions only when needed
  Future<bool> requestPermissions() async {
    if (_permissionsGranted) return true;
    
    await _ensureInitialized();
    
    final bool? result = await _flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    
    _permissionsGranted = result ?? false;
    return _permissionsGranted;
  }
  
  /// Show immediate notification with minimal resource usage
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    NotificationPriority priority = NotificationPriority.defaultPriority,
  }) async {
    if (!await requestPermissions()) return;
    
    final androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      channelDescription: 'General notifications',
      importance: _mapPriority(priority),
      priority: Priority.defaultPriority,
      showWhen: false,
    );
    
    const iosDetails = DarwinNotificationDetails();
    
    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _flutterLocalNotificationsPlugin!.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }
  
  /// Schedule notification with optimized resource usage
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    NotificationPriority priority = NotificationPriority.defaultPriority,
  }) async {
    if (!await requestPermissions()) return;
    
    final androidDetails = AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Notifications',
      channelDescription: 'Scheduled academic notifications',
      importance: _mapPriority(priority),
      priority: Priority.defaultPriority,
    );
    
    const iosDetails = DarwinNotificationDetails();
    
    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _flutterLocalNotificationsPlugin!.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
  
  /// Cancel specific notification
  Future<void> cancelNotification(int id) async {
    if (!_isInitialized) return;
    await _flutterLocalNotificationsPlugin!.cancel(id);
  }
  
  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    if (!_isInitialized) return;
    await _flutterLocalNotificationsPlugin!.cancelAll();
  }
  
  /// Handle notification tap
  void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap - can be extended based on payload
    print('Notification tapped: ${response.payload}');
  }
  
  /// Map priority enum to Android importance
  Importance _mapPriority(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.low:
        return Importance.low;
      case NotificationPriority.high:
        return Importance.high;
      case NotificationPriority.defaultPriority:
      default:
        return Importance.defaultImportance;
    }
  }
  
  /// Dispose resources when no longer needed
  void dispose() {
    _flutterLocalNotificationsPlugin = null;
    _isInitialized = false;
    _permissionsGranted = false;
  }
}

/// Priority levels for notifications
enum NotificationPriority {
  low,
  defaultPriority,
  high,
}

/// Helper class with static methods for common notification types
/// Uses minimal memory by not maintaining state
class NotificationHelper {
  // Private constructor to prevent instantiation
  NotificationHelper._();
  
  /// Show assignment reminder with optimized settings
  static Future<void> showAssignmentReminder(
    String title,
    String courseName,
    DateTime dueDate,
  ) async {
    final id = title.hashCode.abs() % 10000; // Generate unique ID from title, ensure it's within 32-bit range
    await NotificationService.instance.scheduleNotification(
      id: id,
      title: 'Assignment Due Soon',
      body: '$title in $courseName is due soon',
      scheduledDate: dueDate.subtract(const Duration(hours: 24)),
      payload: 'assignment:$courseName',
      priority: NotificationPriority.high,
    );
  }
  
  /// Show exam reminder
  static Future<void> showExamReminder(
    String examName,
    String courseName,
    DateTime examDate,
  ) async {
    final id = examName.hashCode.abs() % 10000;
    await NotificationService.instance.scheduleNotification(
      id: id,
      title: 'Exam Tomorrow',
      body: '$examName in $courseName is scheduled for tomorrow',
      scheduledDate: examDate.subtract(const Duration(days: 1)),
      payload: 'exam:$courseName',
      priority: NotificationPriority.high,
    );
  }
  
  /// Show grade update notification
  static Future<void> showGradeUpdate(
    String courseName,
    String grade,
  ) async {
    final id = (courseName.hashCode + DateTime.now().millisecondsSinceEpoch) % 10000;
    await NotificationService.instance.showNotification(
      id: id,
      title: 'New Grade Available',
      body: 'Your grade for $courseName has been updated: $grade',
      payload: 'grade:$courseName',
      priority: NotificationPriority.defaultPriority,
    );
  }
  
  /// Show attendance reminder
  static Future<void> showAttendanceReminder(
    String title,
    String body,
    DateTime reminderDate,
  ) async {
    final id = title.hashCode.abs() % 10000;
    await NotificationService.instance.scheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledDate: reminderDate,
      payload: 'attendance',
      priority: NotificationPriority.defaultPriority,
    );
  }
}