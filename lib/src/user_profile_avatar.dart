import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user_profile_avatar/src/constants/constants.dart';
import 'package:user_profile_avatar/src/extensions/string_utils.dart';
import 'package:user_profile_avatar/src/models/avatar_border_data.dart';
import 'package:user_profile_avatar/src/ui_toolkit/activity_Indicator.dart';
import 'package:user_profile_avatar/src/ui_toolkit/conditional_child.dart';

class UserProfileAvatar extends StatefulWidget {
  final Key? _key;
  final String? _avatarUrl;
  final Function? _onAvatarTap;
  final AvatarBorderData? _avatarBorderData;
  final Color? _avatarSplashColor;
  final double _radius;
  final int? _notificationCount;
  final TextStyle? _notificationCountTextStyle;
  final bool _isActivityIndicatorSmall;
  final Color? _activityIndicatorAndroidColor;

  /// [avatarUrl] the uri for the image to be displayed.
  /// [onAvatarTap] called when user taps on the avatar.
  /// [avatarBorderData] used to style the border of the circle.
  /// [avatarSplashColor] the splash color when avatar is tapped.
  /// [radius] avatar radius where min = 15 and max = 150.
  /// [notificationCount] to display notification count, passing 0 or null hides the notification bubble.
  /// [notificationBubbleTextStyle] used to style the notification bubble value,
  /// [isActivityIndicatorSmall] displays native circular progress indicator when image is being loaded, use this to set the desired size.
  /// [activityIndicatorAndroidColor] used to set the color for circular progress indicator, only on android.
  UserProfileAvatar(
      {Key? key,
      required String avatarUrl,
      Function? onAvatarTap,
      AvatarBorderData? avatarBorderData,
      Color? avatarSplashColor,
      double radius = 15.0,
      int? notificationCount,
      TextStyle? notificationBubbleTextStyle,
      bool isActivityIndicatorSmall = true,
      Color? activityIndicatorAndroidColor})
      : _key = key,
        _avatarUrl = avatarUrl,
        _onAvatarTap = onAvatarTap,
        _avatarBorderData = avatarBorderData,
        _avatarSplashColor = avatarSplashColor,
        _radius = radius,
        _notificationCount = notificationCount,
        _notificationCountTextStyle = notificationBubbleTextStyle,
        _isActivityIndicatorSmall = isActivityIndicatorSmall,
        _activityIndicatorAndroidColor = activityIndicatorAndroidColor;

  @override
  _UserProfileAvatarState createState() => _UserProfileAvatarState();
}

class _UserProfileAvatarState extends State<UserProfileAvatar> with SingleTickerProviderStateMixin {
  final _inkwellCustomBorder = CircleBorder();
  final _notificationBubbleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 9,
    fontWeight: FontWeight.bold,
  );
  final _duration = Duration(milliseconds: 500);
  int? _tempNotificationCount;

  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );

    _animation = CurvedAnimation(
      curve: Curves.bounceOut,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _startNotificationCounterAnimation();
    final mainContainerSize = widget._radius * 2;
    final notificationBubbleSize = (widget._radius / 100) * 70;
    final mainContainerMinSize = 30.0;
    final mainContainerMaxSize = 300.0;
    final notificationBubbleMinSize = 20.0;
    final notificationBubbleMaxSize = 80.0;

    return InkWell(
      onTap: () => widget._onAvatarTap?.call(),
      customBorder: _inkwellCustomBorder,
      splashColor: widget._avatarSplashColor,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          height: mainContainerSize,
          width: mainContainerSize,
          constraints: BoxConstraints(
            minWidth: mainContainerMinSize * 1.4,
            minHeight: mainContainerMinSize * 1.4,
            maxHeight: mainContainerMaxSize,
            maxWidth: mainContainerMaxSize,
          ),
          child: Stack(
            children: [
              Center(
                child: ConditionalChild(
                  condition: isNullOrEmpty(widget._avatarUrl),
                  thenBuilder: () => Container(
                    height: widget._radius * 2,
                    width: widget._radius * 2,
                    constraints: BoxConstraints(
                      minWidth: mainContainerMinSize,
                      minHeight: mainContainerMinSize,
                    ),
                    child: Image.asset(
                      Asset.userEmptyAvatar,
                      fit: BoxFit.fill,
                    ),
                  ),
                  elseBuilder: () => CachedNetworkImage(
                    key: widget._key,
                    imageUrl: widget._avatarUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                      height: widget._radius * 2,
                      width: widget._radius * 2,
                      constraints: BoxConstraints(
                        minWidth: mainContainerMinSize,
                        minHeight: mainContainerMinSize,
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        color: Colors.black26,
                        shape: BoxShape.circle,
                        border: widget._avatarBorderData != null
                            ? Border.all(
                                color: widget._avatarBorderData!.borderColor,
                                width: widget._avatarBorderData!.borderWidth > 10
                                    ? 10
                                    : widget._avatarBorderData!.borderWidth,
                              )
                            : null,
                      ),
                    ),
                    placeholder: (_, __) => ActivityIndicator(
                      isSmall: widget._isActivityIndicatorSmall,
                      androidColor: widget._activityIndicatorAndroidColor,
                    ),
                    errorWidget: (_, __, ___) => Icon(
                      Icons.error,
                      color: Colors.grey,
                      size: mainContainerSize > 300
                          ? 300
                          : mainContainerSize < 30
                              ? 30
                              : mainContainerSize,
                    ),
                  ),
                ),
              ),
              ConditionalChild(
                condition: (widget._notificationCount ?? 0) > 0,
                thenBuilder: () => Align(
                  alignment: Alignment.topRight,
                  child: ScaleTransition(
                    scale: _animation as Animation<double>,
                    child: Container(
                      height: notificationBubbleSize,
                      width: notificationBubbleSize,
                      constraints: BoxConstraints(
                        minWidth: notificationBubbleMinSize,
                        minHeight: notificationBubbleMinSize,
                        maxWidth: notificationBubbleMaxSize,
                        maxHeight: notificationBubbleMaxSize,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          widget._notificationCount! > 99 ? '99+' : '${widget._notificationCount}',
                          style: widget._notificationCountTextStyle ?? _notificationBubbleTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startNotificationCounterAnimation() {
    if ((widget._notificationCount ?? 0) > 0 &&
        widget._notificationCount != _tempNotificationCount &&
        !_controller.isAnimating) {
      _tempNotificationCount = widget._notificationCount;
      _controller.forward(from: 0.0);
    }
  }
}
