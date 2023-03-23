import 'package:flutter/material.dart';
import 'package:test_charts/widget/chat_page.dart';

import '../constant/responsive.dart';
import '../constant/svg_picture_custom.dart';

class ButtonFloatingStatus extends StatefulWidget {
  final Function callbackExpand;
  final Function callBackOffset;
  Offset position;

  ButtonFloatingStatus({Key? key, required this.callbackExpand, required this.callBackOffset, required this.position,}) : super(key: key);

  @override
  State<ButtonFloatingStatus> createState() => _ButtonFloatingStatusState();
}

class _ButtonFloatingStatusState extends State<ButtonFloatingStatus> {
  late BuildContext buildContext;
  late Responsive responsive;

  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    responsive = Responsive(buildContext);

    final screenWidthHalf = MediaQuery.of(context).size.width / 2;

    return Positioned(
      top: widget.position.dy < responsive.getHeightResponsive(60.0)
          ? responsive.getHeightResponsive(60.0)
          : widget.position.dy > responsive.getHeightResponsive(650.0)
          ? responsive.getHeightResponsive(650.0)
          : widget.position.dy,
      right: widget.position.dx > screenWidthHalf ? 1.0 : null,
      left: widget.position.dx < screenWidthHalf ? 1.0 : null,
      child: Center(
        child: Draggable(
          feedback: Column(children: [
            SvgPictureCustom(
                width: 64.0,
                height: 64.0,
                path: 'assets/bot.svg'
            ),
          ]),
          childWhenDragging: Container(),
          onDragEnd: (details) {
            widget.position = details.offset;
            widget.callBackOffset(widget.position);
            setState(() {

            });
          },
          child: GestureDetector(
            onTap: (){
              isExpand = !isExpand;
              widget.callbackExpand(isExpand);
              setState(() {

              });
            },
            child: SvgPictureCustom(
                width: 64.0,
                height: 64.0,
                path: 'assets/bot.svg'
            ),
          ),
        ),
      ),
    );
  }
}