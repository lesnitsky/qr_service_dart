import 'dart:convert';
import 'dart:typed_data';

String render(Uint8List img) {
  return '''
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QR Code Generator</title>
    <style>
      html,
      body {
        height: 100%;
      }

      h1 {
        position: absolute;
        top: 0;
        left: 0.5em;
      }

      body {
        font-family: sans-serif;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
      }

      img {
        width: 256px;
        height: 256px;
      }

      .button {
        padding: 0.7em 1em;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #eee;
        cursor: pointer;
        margin-top: 1em;
        color: inherit;
        text-decoration: none;
        font-size: 13px;
      }

      footer {
        position: absolute;
        bottom: 1em;
      }
    </style>
  </head>
  <body>
    <h1>QR code generator</h1>
    <img src="data:image/png;base64,${base64.encode(img)}" />
    <a href="/" class="button">Generate again</a>
    <footer>Powered by <a href="https://globe.dev/">Globe.dev</a></footer>
  </body>
''';
}
