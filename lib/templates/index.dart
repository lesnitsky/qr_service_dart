const _tmpl = '''
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
      body {
        font-family: sans-serif;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
      }

      h1 {
        position: absolute;
        top: 0;
        left: 0.5em;
      }

      form {
        display: flex;
        flex-direction: column;
        width: 300px;
      }

      input {
        margin-bottom: 10px;
        padding: 1em;
        border: 1px solid #ccc;
        border-radius: 5px;
      }

      button {
        padding: 0.7em 1em;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #eee;
        cursor: pointer;
      }

      footer {
        position: absolute;
        bottom: 1em;
      }
    </style>
  </head>
  <body>
    <h1>QR code generator</h1>
    <form action="/generate" method="post">
      <input type="text" name="data" id="data" placeholder="QR Code content" />
      <button type="submit" disabled>Generate</button>
    </form>

    <footer>Powered by <a href="https://globe.dev/">Globe.dev</a></footer>

    <script>
      const dataInput = document.getElementById('data');
      const submitButton = document.querySelector('button[type="submit"]');

      dataInput.addEventListener('input', () => {
        if (dataInput.value) {
          submitButton.removeAttribute('disabled');
        } else {
          submitButton.setAttribute('disabled', true);
        }
      });
    </script>
  </body>
</html>
''';

String render() => _tmpl;
