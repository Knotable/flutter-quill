
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FloatingCursorWidget extends LeafRenderObjectWidget {
  const FloatingCursorWidget({
    required this.cursorColor,
    Key? key
   }) : super(key: key);

  final Color cursorColor;


  @override
  RenderObject createRenderObject(BuildContext context) {
    return FloatingCursorRender(cursorColor: cursorColor);
  }
}


class FloatingCursorRender extends RenderBox
  with RenderObjectWithChildMixin<RenderBox>{

  FloatingCursorRender({ required this.cursorColor });
  final Color cursorColor;

  bool _canPaint = false;
  double _lineHeight = 0;
  Offset _offset = Offset.zero;


  void move({
    required Offset offset, required double lineHeight }){
    _offset = offset;
    _lineHeight = lineHeight;
    _canPaint = true;
    markNeedsPaint();
  }

  void stop(){
    _canPaint = false;
    markNeedsPaint();
  }

  @override
  bool get sizedByParent => true;

  @override
  void performResize() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_canPaint) {
      final paint = Paint()
        ..color = cursorColor;
      final _cursorRect = Rect.fromLTRB(0, -_lineHeight/2, 2, _lineHeight/2);
      final caretRRect = RRect.fromRectAndRadius(
        _cursorRect.shift(_offset),
        const Radius.circular(1)
      );

      context.canvas.drawRRect(caretRRect, paint);
    }
  }
}
