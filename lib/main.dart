import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ormannet_proje/firebase_options.dart'; // Doğru olduğundan emin olun veya gerekliyse kaldırın
import 'education_page.dart';
import 'quiz_page.dart';
import 'feedback_screen.dart';
import 'map_page.dart';
import 'donation_page.dart';
import 'certificate_screen.dart';
import 'login_page.dart'; // Giriş sayfasını içe aktar

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ormannet',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(), // Giriş sayfasını başlangıç rotası olarak ayarlayın
      routes: {
        '/home': (context) => HomePage(
            userName:
                ''), // Bu sadece örnek için; `userName` dinamik olarak atanacak
        '/feedback': (context) => FeedbackScreen(),
        '/map': (context) => MapPage(),
        '/donation': (context) => DonationPage(),
        '/certificate': (context) => CertificateScreen(),
        '/quiz': (context) => QuizPage(),
        '/education': (context) => EducationPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final String userName;

  const HomePage({Key? key, required this.userName}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ormannet'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(userName),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                child: Text(userName[0]),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Harita'),
              onTap: () {
                Navigator.pushNamed(context, '/map');
              },
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Eğitim'),
              onTap: () {
                Navigator.pushNamed(context, '/education');
              },
            ),
            ListTile(
              leading: const Icon(Icons.nature),
              title: const Text('Bağış Yap'),
              onTap: () {
                Navigator.pushNamed(context, '/donation');
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Geri Bildirim'),
              onTap: () {
                Navigator.pushNamed(context, '/feedback');
              },
            ),
            ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text('Quiz'),
              onTap: () {
                Navigator.pushNamed(context, '/quiz');
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app), // Çıkış ikonu
              title: const Text('Çıkış Yap'),
              onTap: () async {
                await _signOut(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/orman_2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            'Ormannet',
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
