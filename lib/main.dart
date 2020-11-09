import 'package:flutter/material.dart';

import 'user_profile_avatar.dart';

const url = 'https://picsum.photos/id/237/1000/1000';
const url2 =
    'https://upload.wikimedia.org/wikipedia/commons/f/ff/Pizigani_1367_Chart_10MB.jpg';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: UserProfileAvatar(
            onAvatarTap: () {},
            avatarUrl: url2,
            radius: 300,
            notificationCount: 1,
            // avatarBorderData: AvatarBorderData(
            //   borderColor: Colors.brown,
            //   borderWidth: 10,
            // ),
          ),
        ),
      ),
    );
  }
}
