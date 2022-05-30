import 'package:flutter/material.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        avatarUrl: 'https://picsum.photos/id/237/5000/5000',
        onAvatarTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tapped on avatar'),
            ),
          );
        },
        notificationCount: 10,
        notificationBubbleTextStyle: const TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        avatarSplashColor: Colors.purple,
        radius: 100,
        isActivityIndicatorSmall: false,
        avatarBorderData: AvatarBorderData(
          borderColor: Colors.black54,
          borderWidth: 5.0,
        ),
      ),
    );
  }
}
