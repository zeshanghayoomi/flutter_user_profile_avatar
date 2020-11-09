import 'package:flutter/material.dart';

class ConditionalChild extends StatelessWidget {
  final bool _condition;
  final Function _thenBuilder;
  final Function _elseBuilder;

  const ConditionalChild(
      {@required bool condition,
      @required Function thenBuilder,
      Function elseBuilder})
      : _condition = condition,
        _thenBuilder = thenBuilder,
        _elseBuilder = elseBuilder;

  @override
  Widget build(BuildContext context) {
    return _condition
        ? _thenBuilder?.call() ?? SizedBox()
        : _elseBuilder?.call() ?? SizedBox();
  }
}
