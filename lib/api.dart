import 'dart:typed_data';
import 'package:qr/qr.dart';
import 'package:image/image.dart' as img;

Future<Uint8List> generateQrFor(String data) async {
  final qrCode = QrCode(4, QrErrorCorrectLevel.L);

  qrCode.addData(data);

  final qrImage = QrImage(qrCode);

  final image = img.Image(
    width: qrImage.moduleCount,
    height: qrImage.moduleCount,
  );

  for (var x = 0; x < qrImage.moduleCount; x++) {
    for (var y = 0; y < qrImage.moduleCount; y++) {
      final (r, g, b) = switch (qrImage.isDark(y, x)) {
        true => (0, 0, 0),
        false => (255, 255, 255),
      };

      image.setPixelRgb(x, y, r, g, b);
    }
  }

  final resized = img.copyResize(image, width: 256, height: 256);
  return img.encodePng(resized);
}
