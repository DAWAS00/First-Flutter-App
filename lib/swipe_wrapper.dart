import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sidebar_controller.dart';

class SwipeWrapper extends StatefulWidget {
  final Widget child;

  const SwipeWrapper({super.key, required this.child});

  @override
  State<SwipeWrapper> createState() => _SwipeWrapperState();
}

class _SwipeWrapperState extends State<SwipeWrapper> {
  bool _isSwipeStarted = false;
  double _startX = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _startX = details.globalPosition.dx;
        _isSwipeStarted = _startX < 50; // Only start swipe from left edge
      },
      onPanUpdate: (details) {
        if (_isSwipeStarted) {
          double deltaX = details.globalPosition.dx - _startX;
          if (deltaX > 100) { // Swipe threshold
            context.read<SidebarController>().openSidebar();
            _isSwipeStarted = false;
          }
        }
      },
      onPanEnd: (details) {
        _isSwipeStarted = false;
      },
      child: widget.child,
    );
  }
}