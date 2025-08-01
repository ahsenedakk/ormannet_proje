import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CertificateScreen extends StatelessWidget {
  const CertificateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    String name = args['name']!;
    String surname = args['surname']!;
    String donation = args['donation']!;

    String certificateHtml = '''
      <html>
      <head>
        <meta charset="UTF-8">
      </head>
      <body style="background-color: #E0F7FA; padding: 50px;">
        <div style="text-align: center;">
          <h1 style="color: #004D40;">Teşekkür Sertifikası</h1>
          <p style="font-size: 18px;">Bu sertifika,</p>
          <h2>$name $surname</h2>
          <p style="font-size: 18px;">tarafından yapılan</p>
          <h3 style="color: #004D40;">$donation</h3>
          <p style="font-size: 18px;">bağışı için verilmiştir.</p>
        </div>
      </body>
      </html>
    ''';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sertifika'),
      ),
      backgroundColor: Color(0xFFE0F7FA), // Arka plan rengi açık mavi tonu
      body: SingleChildScrollView(
        child: Column(
          children: [
            Html(
              data: certificateHtml,
              style: {
                "html": Style(
                  backgroundColor: Colors.transparent,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
