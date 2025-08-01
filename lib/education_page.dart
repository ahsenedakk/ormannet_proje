import 'package:flutter/material.dart';
import 'package:ormannet_proje/quiz_page.dart'; // QuizPage'ini import etmeyi unutmayın

class EducationPage extends StatelessWidget {
  const EducationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orman Eğitimi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildListItem(
              context,
              title: 'Ağaç Nedir?',
              description:
                  'Ağaçlar, odun yapısıyla karakterize edilen büyük bitkilerdir. Fotosentez yaparak karbondioksit alırlar ve oksijen üretirler.',
            ),
            _buildListItem(
              context,
              title: 'Yaprak Dökme',
              description:
                  'Yaprak dökme, bazı bitkilerin soğuk ve kurak dönemlerde yapraklarını dökmeleri ve yeniden büyütmeleridir.',
            ),
            _buildListItem(
              context,
              title: 'Yangınların Oluşumu',
              description:
                  'Ormancılıkta yangınlar doğal veya insan kaynaklı olabilir ve biyolojik döngüde önemli bir rol oynarlar.',
            ),
            _buildListItem(
              context,
              title: 'Sürdürülebilir Ormancılık',
              description:
                  'Sürdürülebilir ormancılık, ormanların kaynaklarını koruyarak uzun vadeli faydalar sağlayan bir yönetim yaklaşımıdır.',
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Quiz\'e Başla',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[100]), // Yazı rengi açık gri
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ), // Buton ile son eleman arasındaki boşluğu belirle
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context,
      {required String title, required String description}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(description),
        ),
      ),
    );
  }
}
