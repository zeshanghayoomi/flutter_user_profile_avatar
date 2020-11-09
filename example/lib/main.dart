import 'package:flutter/material.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: UserProfileAvatar(
        radius: 0,
        notificationCount: 1,
        avatarUrl:
            'https://upload.wikimedia.org/wikipedia/commons/f/ff/Pizigani_1367_Chart_10MB.jpg',
      ),
    );
  }
}
