import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  PickedFile file;

  final pickedFile = await picker.pickImage(source: source);
}

Future<Uint8List> createPlaceholderImage(int width, int height,
    {String text = 'Placeholder'}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);

  // Desenarea unui fundal alb
  final paint = Paint()..color = Colors.white;
  canvas.drawRect(
      Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()), paint);

  // Stilul textului
  final textStyle = ui.TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  // Centrarea textului
  final paragraphStyle = ui.ParagraphStyle(
    textAlign: TextAlign.center,
  );

  // Crearea paragrafului cu textul dorit
  final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle())
    ..pushStyle(textStyle)
    ..addText(text);
  final paragraph = paragraphBuilder.build()
    ..layout(ui.ParagraphConstraints(width: width.toDouble()));

  // Poziționarea paragrafului în mijlocul imaginii
  final offsetX = (width - paragraph.width) / 2;
  final offsetY = (height - paragraph.height) / 2;
  canvas.drawParagraph(paragraph, Offset(offsetX, offsetY));

  // Finalizarea înregistrării și obținerea obiectului Image
  final picture = recorder.endRecording();
  final image = await picture.toImage(width, height);

  // Convertirea imaginii în Uint8List
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
