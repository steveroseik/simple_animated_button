import 'package:flutter/material.dart';

///
/// [ElevatedLayerButton] Renders Button layers in 3D perspective
///
class ElevatedLayerButton extends StatefulWidget {
  /// Define height for button
  final double? buttonHeight;

  /// Define width for button
  final double? buttonWidth;

  /// Define Clicking Duration - [Duration(milliseconds: 200)]
  final Duration? animationDuration;

  /// Define Animation Curve - [Curves.ease]
  final Curve? animationCurve;

  /// Void Function for Button click
  final VoidCallback? onClick;

  /// Define Base Layer [BoxDecoration] for button
  final BoxDecoration? baseDecoration;

  /// Define Top Layer [BoxDecoration] for button
  final BoxDecoration? topDecoration;

  /// Define Top Layer Child [Widget] for button
  final Widget? topLayerChild;

  /// if anyone wants to add slightly rounded corners
  final BorderRadius? borderRadius;

  final double? aspectRatio;

  const ElevatedLayerButton({
    Key? key,
    this.buttonHeight,
    this.buttonWidth,
    this.aspectRatio,
    required this.animationDuration,
    required this.animationCurve,
    required this.onClick,
    this.baseDecoration,
    this.topDecoration,
    this.topLayerChild,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<ElevatedLayerButton> createState() => _ElevatedLayerButtonState();
}

class _ElevatedLayerButtonState extends State<ElevatedLayerButton> {
  bool buttonPressed = false;

  bool animationCompleted = true;

  bool get _enabled => widget.onClick != null;

  bool get _disabled => !_enabled;

  double? height;
  double? width;


  @override
  Widget build(BuildContext context) {
    height = widget.buttonHeight;
    width = widget.buttonWidth;
    return Opacity(
      opacity: _disabled ? 0.5 : 1,
      child: GestureDetector(
        onTapDown: (det) {
          if (!_disabled) {
            setState(() {
              buttonPressed = true;
              animationCompleted = false;
            });
          }
        },
        onTapCancel: (){
          if (!animationCompleted) {
            animationCompleted = true;
            setState(() => buttonPressed = false);
          }
        },
        onTapUp: (det){
          if (!animationCompleted) {
            animationCompleted = true;
            setState(() => buttonPressed = false);
            if (_enabled) {
              widget.onClick!();
            }
          }
        },
        child: (height == null || width == null ) ?
        SizedBox(
          height: height != null ? (height! * 1) : null,
          width: width != null ? (width! * 1) : null,
          child: AspectRatio(
            aspectRatio: widget.aspectRatio!,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Positioned.fill(
                  bottom: 0,
                  right: 0,
                  top: 4,
                  left: 4,
                  child: Container(
                    decoration: widget.baseDecoration??
                        const BoxDecoration(
                          color: Colors.black,
                        ),
                  ),
                ),
                AnimatedPositioned(
                  bottom: _enabled ? (buttonPressed ? 0 : 4) : 4,
                  right: _enabled ? (buttonPressed ? 0 : 4) : 4,
                  top:  _enabled ? (buttonPressed ? 4 : 0) : 4,
                  left:  _enabled ? (buttonPressed ? 4 : 0) : 4,
                  duration: widget.animationDuration ??
                      const Duration(milliseconds: 300),
                  curve: widget.animationCurve ?? Curves.ease,
                  onEnd: () {
                    // if (!animationCompleted) {
                    //   animationCompleted = true;
                    //   setState(() => buttonPressed = false);
                    //   if (_enabled) {
                    //     widget.onClick!();
                    //   }
                    // }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: widget.topDecoration??
                        const BoxDecoration(
                          color: Colors.black,
                        ),
                    child: widget.topLayerChild,
                  ),
                ),
              ],
            ),
          ),
        )
            : SizedBox(
          height: (height?? 0 * 1.1),
          width: (width?? 0 * 1.1),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: (width?? 0) * 0.9,
                  height: (height?? 0) * 0.9,
                  decoration: widget.baseDecoration??
                      const BoxDecoration(
                        color: Colors.black,
                      ),
                ),
              ),
              AnimatedPositioned(
                bottom: _enabled ? (buttonPressed ? 0 : 4) : 4,
                right: _enabled ? (buttonPressed ? 0 : 4) : 4,
                duration: widget.animationDuration ??
                    const Duration(milliseconds: 300),
                curve: widget.animationCurve ?? Curves.ease,
                onEnd: () {
                  // if (!animationCompleted) {
                  //   animationCompleted = true;
                  //   setState(() => buttonPressed = false);
                  //   if (_enabled) {
                  //     widget.onClick!();
                  //   }
                  // }
                },
                child: Container(
                  width: (width?? 0) * 0.9,
                  height: (height?? 0) * 0.9,
                  alignment: Alignment.center,
                  decoration: widget.topDecoration??
                      const BoxDecoration(
                        color: Colors.black,
                      ),
                  child: widget.topLayerChild,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
