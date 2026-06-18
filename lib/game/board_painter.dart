// lib/game/board_painter.dart
import 'package:flutter/material.dart';
import 'game_state.dart';
import '../utils/constants.dart';

class BoardPainter extends CustomPainter {
  final GameState st;
  BoardPainter(this.st);

  @override
  void paint(Canvas canvas, Size size) {
    final s = st.size;
    final cell = size.width / s;

    // cells
    for (int i = 0; i < s * s; i++) {
      final r = i ~/ s, c = i % s;
      final rect =
          Rect.fromLTWH(c * cell + 2, r * cell + 2, cell - 4, cell - 4);
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(8)),
          Paint()..color = kCell);
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(8)),
          Paint()
            ..color = kCellEdge
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1);
    }

    // path
    if (st.path.length >= 2) {
      Offset ctr(int i) =>
          Offset((i % s) * cell + cell / 2, (i ~/ s) * cell + cell / 2);
      final p = Path()..moveTo(ctr(st.path.first).dx, ctr(st.path.first).dy);
      for (int i = 1; i < st.path.length; i++) {
        p.lineTo(ctr(st.path[i]).dx, ctr(st.path[i]).dy);
      }
      canvas.drawPath(
          p,
          Paint()
            ..color = kPathGlow.withOpacity(0.5)
            ..style = PaintingStyle.stroke
            ..strokeWidth = cell * 0.42
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6));
      canvas.drawPath(
          p,
          Paint()
            ..color = kPath
            ..style = PaintingStyle.stroke
            ..strokeWidth = cell * 0.26
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round);
    }

    // start & end markers
    void marker(int cell0, Color color, IconData _unused) {
      final r = cell0 ~/ s, c = cell0 % s;
      final o = Offset(c * cell + cell / 2, r * cell + cell / 2);
      canvas.drawCircle(
          o,
          cell * 0.30,
          Paint()
            ..color = color.withOpacity(0.4)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6));
      canvas.drawCircle(o, cell * 0.22, Paint()..color = color);
      canvas.drawCircle(o, cell * 0.22,
          Paint()
            ..color = Colors.white.withOpacity(0.7)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    }

    marker(st.level.start, kStart, Icons.circle);
    marker(st.level.end, kEnd, Icons.circle);
  }

  @override
  bool shouldRepaint(BoardPainter old) => true;
}
