import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class SvgPictureCustom extends StatefulWidget {

  final double width;
  final double height;
  final String path;
  final Color? color;
  final BoxFit? fit;

  const SvgPictureCustom({Key? key, required this.width, required this.height,
    required this.path, this.color, this.fit}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SvgPictureCustomState createState() => _SvgPictureCustomState();
}

class _SvgPictureCustomState extends State<SvgPictureCustom> {

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: (widget.color == null)
          ? SvgPicture.asset(
        widget.path,
        semanticsLabel: 'vector',
        fit: widget.fit ?? BoxFit.contain,
      )
          : SvgPicture.asset(
        widget.path,
        semanticsLabel: 'vector',
        color: widget.color,
        fit: widget.fit ?? BoxFit.contain,
      ),
    );
  }
}