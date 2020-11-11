# Flutter User Profile Avatar
A simple widget that display round profile picture where the picture is fetched from network and displays circular progress indicator whilst the image is being loaded. Also, has the ability to display notification bubble.

<img src="https://github.com/zeshanghayoomi/flutter_user_profile_avatar/blob/master/repo_assets/simulator.gif" width="300" height="600">

<br>

## How to use
```dart

UserProfileAvatar(
        avatarUrl: 'https://picsum.photos/id/237/5000/5000',
        onAvatarTap: () {
          print('Avatar Tapped..');
        },
        notificationCount: 10,
        notificationBubbleTextStyle: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        avatarSplashColor: Colors.purple,
        radius: 100,
        isActivityIndicatorSmall: false,
        avatarBorderData: AvatarBorderData(
          borderColor: Colors.white,
          borderWidth: 5.0,
        ),
      )

```

## Properties

* ***avatarUrl***<br>The url for the image, if this set to null or empty then an empty user avatar gets displayed by default.

<br>
<img src="https://github.com/zeshanghayoomi/flutter_user_profile_avatar/blob/master/repo_assets/1.png" width="200" height="200">
<br>

* ***onAvatarTap***<br>Use this to perform any action when the avatar gets tapped.

* ***notificationCount***<br>Pass an int to display the notification bubble. **99+** gets displayed if notification count was larger than 100.

* ***notificationBubbleTextStyle***<br>Used to style the notification count, if null then the default one will be applied.

* ***avatarSplashColor***<br>Splash color when user taps on the avatar.

* ***radius***<br>Use this to size the avatar.
  * minimum default radius is **15**
  * maximum default radius is **150**

* ***isActivityIndicatorSmall***<br>use this to display small/large circular progress indicator **(native)** when image is loading, default is **true**.

<br>
<img src="https://github.com/zeshanghayoomi/flutter_user_profile_avatar/blob/master/repo_assets/2.png" width="200" height="200">
<img src="https://github.com/zeshanghayoomi/flutter_user_profile_avatar/blob/master/repo_assets/3.png" width="200" height="200">
<br>

* ***avatarBorderData***<br>Use this to apply border width and color of the avatar.
