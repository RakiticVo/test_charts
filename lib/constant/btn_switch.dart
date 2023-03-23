import 'package:flutter/material.dart';

import 'app_colors.dart';

class BtnSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double? height;
  final double? width;
  final Color? color;
  const BtnSwitch({Key? key, required this.value, required this.onChanged, this.height, this.width, this.color}) : super(key: key);

  @override
  State<BtnSwitch> createState() => _BtnSwitchState();
}

class _BtnSwitchState extends State<BtnSwitch> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: widget.width ?? 45.0,
            height: widget.height ?? 45.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: widget.value == false
                ? AppColors.neutral02
                : widget.color ?? AppColors.primaryBlue,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Container(
                alignment: widget.value
                  ? ((Directionality.of(context) == TextDirection.rtl)
                    ? Alignment.centerLeft
                    : Alignment.centerRight )
                  : ((Directionality.of(context) == TextDirection.rtl)
                    ? Alignment.centerRight
                    : Alignment.centerLeft),
                child: Container(
                  width: widget.height != null ? widget.height! - 5.0 : 25.0 - 2.0,
                  height: widget.height != null ? widget.height! - 5.0 : 25.0 - 2.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
