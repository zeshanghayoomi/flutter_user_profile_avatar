import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'conditional_child.dart';

class ActivityIndicator extends StatelessWidget {
  final bool isSmall;
  final Color androidColor;

  double get _size {
    return isSmall ? 8 : 16;
  }

  const ActivityIndicator({this.isSmall = true, this.androidColor});

  @override
  Widget build(BuildContext context) {
    return ConditionalChild(
      condition: Platform.isIOS,
      thenBuilder: () => CupertinoActivityIndicator(
        radius: _size,
      ),
      elseBuilder: () => Container(
        child: Center(
          child: SizedBox(
            width: _size * 2,
            height: _size * 2,
            child: CircularProgressIndicator(
              strokeWidth: isSmall ? 2 : 4,
              valueColor: AlwaysStoppedAnimation<Color>(
                androidColor ?? const Color(0xff008171),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
