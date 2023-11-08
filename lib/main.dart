import 'dart:convert';
import 'dart:io';

import 'api.dart';
import './templates/index.dart' as index_page;
import './templates/result.dart' as result_page;

Future<void> main() async {
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  final server = await HttpServer.bind(InternetAddress.anyIPv4, port);

  server.listen((req) async {
    final HttpRequest(response: res, :method, :uri) = req;

    try {
      switch ((method, uri.path)) {
        case ('GET', '/'):
          res
            ..statusCode = HttpStatus.ok
            ..headers.contentType = ContentType.html
            ..write(index_page.render())
            ..close();

        case ('POST', '/generate'):
          final formDataString = await utf8.decoder.bind(req).join();

          final formData = Uri.splitQueryString(formDataString);
          final data = formData['data'] ?? '';

          if (data.isEmpty) {
            res
              ..statusCode = HttpStatus.badRequest
              ..write('Invalid request: data is empty.')
              ..close();

            return;
          }

          final png = await generateQrFor(data);

          res
            ..statusCode = HttpStatus.ok
            ..headers.contentType = ContentType.html
            ..write(result_page.render(png))
            ..close();

        default:
          res
            ..statusCode = HttpStatus.notFound
            ..write('Not found: ${req.uri.path}.')
            ..close();
      }
    } catch (err) {
      res
        ..statusCode = HttpStatus.internalServerError
        ..write('Internal server error: $err.')
        ..close();

      return;
    }
  });
}
