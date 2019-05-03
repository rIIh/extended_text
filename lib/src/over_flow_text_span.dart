import 'package:extended_text/src/text_painter_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OverFlowTextSpan extends TextSpan {
  ///helper for textPainter
  final TextPainterHelper _textPainterHelper;
  TextPainterHelper get textPainterHelper => _textPainterHelper;

  ///background to cover up the original text under [OverFlowTextSpan]
  final Color background;

  OverFlowTextSpan(
      {TextStyle style,
      String text,
      List<TextSpan> children,
      GestureRecognizer recognizer,
      this.background})
      : _textPainterHelper = TextPainterHelper(),
        //assert(background != null),
        super(
            style: style,
            text: text,
            children: children,
            recognizer: recognizer);

  TextPainter layout(TextPainter painter) {
    return _textPainterHelper.layout(painter, this, compareChildren: true);
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final OverFlowTextSpan typedOther = other;
    return typedOther.text == text &&
        typedOther.style == style &&
        typedOther.recognizer == recognizer &&
        typedOther.background == background &&
        listEquals<TextSpan>(typedOther.children, children);
  }

  @override
  int get hashCode =>
      hashValues(style, text, recognizer, background, hashList(children));

  @override
  RenderComparison compareTo(TextSpan other) {
    if (other is OverFlowTextSpan) {
      if (other.background != background) {
        return RenderComparison.paint;
      }
    }

    // TODO: implement compareTo
    return super.compareTo(other);
  }
}
