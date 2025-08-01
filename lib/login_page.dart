import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ormannet_proje/main.dart';
import 'register_page.dart'; // Kayıt ekranı için sayfayı import ediyoruz

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Yükleniyor durumunu saklamak için bir boolean
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // Form anahtarını oluştur
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.95).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _login(BuildContext context) async {
    setState(() {
      _isLoading =
          true; // Login işlemi başladığında yükleniyor durumunu true yap
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Kullanıcı adı bilgilerini Firestore'dan al
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('userdata')
          .doc(userCredential.user!.uid)
          .get();

      String userName = userData['name'];

      // Başarılı girişten sonra ana ekrana yönlendir ve kullanıcı adını gönder
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(userName: userName)),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Giriş Başarısız"),
            content: const Text("Giriş yapılırken bir hata oluştu."),
            actions: [
              TextButton(
                child: const Text("Tamam"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        _isLoading =
            false; // İşlem tamamlandığında yükleniyor durumunu false yap
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.lightGreenAccent],
            stops: [0.0, 0.7],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey, // Form anahtarını ekleyin
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Ortada hizalamak için
                children: [
                  _isLoading
                      ? Column(
                          children: const [
                            CircularProgressIndicator(), // Yükleniyor durumunda gösterilecek gösterge
                            SizedBox(height: 16.0),
                            Text('Giriş yapılıyor...'),
                          ],
                        )
                      : Column(
                          children: [
                            const Text(
                              'Hoş Geldiniz!',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24.0),
                            Container(
                              width: 300, // Genişliği kısalttık
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: const Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        const BorderSide(color: Colors.green),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16.0),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email alanı boş bırakılamaz';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Container(
                              width: 300, // Genişliği kısalttık
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Şifre',
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        const BorderSide(color: Colors.green),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16.0),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Şifre alanı boş bırakılamaz';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            ScaleTransition(
                              scale: _scaleAnimation,
                              child: ElevatedButton(
                                onPressed: _isLoading
                                    ? null
                                    : () async {
                                        if (_formKey.currentState!.validate()) {
                                          await _animationController.forward();
                                          await _login(context);
                                          await _animationController.reverse();
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0, vertical: 12.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text('Giriş Yap',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white)),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterPage()), // Kayıt sayfasına yönlendir
                                );
                              },
                              child: const Text(
                                'Hesabınız yok mu? Kayıt Olun!',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
