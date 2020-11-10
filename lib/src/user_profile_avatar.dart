import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_profile_avatar/src/constants/constants.dart';
import 'package:user_profile_avatar/src/extensions/string_utils.dart';
import 'package:user_profile_avatar/src/models/avatar_border_data.dart';
import 'package:user_profile_avatar/src/ui_toolkit/activity_Indicator.dart';
import 'package:user_profile_avatar/src/ui_toolkit/conditional_child.dart';

class UserProfileAvatar extends StatelessWidget {
  final Key _key;
  final String _avatarUrl;
  final Function _onAvatarTap;
  final AvatarBorderData _avatarBorderData;
  final Color _avatarSplashColor;
  final double _radius;
  final int _notificationCount;
  final TextStyle _notificationCountTextStyle;
  final bool _isActivityIndicatorSmall;
  final Color _activityIndicatorAndroidColor;

  static const _inkwellCustomBorder = const CircleBorder();
  static const _notificationBubbleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 9,
    fontWeight: FontWeight.bold,
  );

  const UserProfileAvatar(
      {Key key,
      @required String avatarUrl,
      Function onAvatarTap,
      AvatarBorderData avatarBorderData,
      Color avatarSplashColor,
      double radius = 15.0,
      int notificationCount,
      TextStyle notificationBubbleTextStyle,
      bool isActivityIndicatorSmall = true,
      Color activityIndicatorAndroidColor})
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
  Widget build(BuildContext context) {
    final mainContainerSize = _radius * 2;
    final notificationBubbleSize = (_radius / 100) * 70;
    final mainContainerMinSize = 30.0;
    final mainContainerMaxSize = 300.0;
    final notificationBubbleMinSize = 20.0;
    final notificationBubbleMaxSize = 80.0;

    return InkWell(
      onTap: _onAvatarTap,
      customBorder: _inkwellCustomBorder,
      splashColor: _avatarSplashColor,
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
                  condition: isNullOrEmpty(_avatarUrl),
                  thenBuilder: () => Container(
                    height: _radius * 2,
                    width: _radius * 2,
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
                    key: _key,
                    imageUrl: _avatarUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      height: _radius * 2,
                      width: _radius * 2,
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
                        border: _avatarBorderData != null
                            ? Border.all(
                                color: _avatarBorderData.borderColor,
                                width: _avatarBorderData.borderWidth > 10
                                    ? 10
                                    : _avatarBorderData.borderWidth,
                              )
                            : null,
                      ),
                    ),
                    placeholder: (_, __) => ActivityIndicator(
                      isSmall: _isActivityIndicatorSmall,
                      androidColor: _activityIndicatorAndroidColor,
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
                condition: (_notificationCount ?? 0) > 0,
                thenBuilder: () => Align(
                  alignment: Alignment.topRight,
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          _notificationCount > 99
                              ? '99+'
                              : '$_notificationCount',
                          style: _notificationCountTextStyle ??
                              _notificationBubbleTextStyle,
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
}
