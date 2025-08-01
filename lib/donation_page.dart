import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ormannet_proje/past_donation_page.dart';
import 'package:ormannet_proje/login_page.dart'; // Eklenen import

class DonationPage extends StatefulWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _surname = '';
  String _email = '';
  String _selectedDonation = '';
  Map<String, double> donationOptions = {
    'Ağaç Dikimi': 50.0,
    'Yangın Söndürme Ekipmanları': 100.0,
    'Fidan Bakımı': 30.0,
    'Doğa Eğitimi': 20.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bağış Yap'),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Ad',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen adınızı girin';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Soyad',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen soyadınızı girin';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _surname = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-posta',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen e-postanızı girin';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Lütfen geçerli bir e-posta girin';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 40), // Daha fazla boşluk bırakıyoruz
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Bağış Seçenekleri:',
                        style: TextStyle(
                          fontSize: 18, // Daha büyük font
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic, // Daha şık bir stil
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: _buildDonationOption('Ağaç Dikimi'),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: _buildDonationOption(
                                    'Yangın Söndürme Ekipmanları'),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: _buildDonationOption('Fidan Bakımı'),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: _buildDonationOption('Doğa Eğitimi'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40), // Butonu biraz daha aşağı kaydırıyoruz
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (_selectedDonation.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Bağış Seçimi'),
                                  content: Text('Lütfen bir bağış seçiniz.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Tamam'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            _addDonation();
                            Navigator.pushNamed(
                              context,
                              '/certificate',
                              arguments: {
                                'name': _name,
                                'surname': _surname,
                                'donation': _selectedDonation,
                              },
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Bağış Yap',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PastDonationsPage(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        side: BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Geçmiş Bağışlarım',
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDonationOption(String option) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDonation = option;
        });
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedDonation == option ? Colors.green : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(option),
            SizedBox(height: 8),
            Text(
              '$option',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16, // Daha büyük ve şık bir font
                fontWeight: FontWeight.bold,
                color:
                    _selectedDonation == option ? Colors.green : Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${donationOptions[option]}₺',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16, // Fiyat bilgisini büyütüyoruz
                fontWeight: FontWeight.bold,
                color:
                    _selectedDonation == option ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(String option) {
    switch (option) {
      case 'Ağaç Dikimi':
        return Icon(Icons.local_florist, color: Colors.green);
      case 'Yangın Söndürme Ekipmanları':
        return Icon(FontAwesomeIcons.fireExtinguisher, color: Colors.green);
      case 'Fidan Bakımı':
        return Icon(FontAwesomeIcons.seedling, color: Colors.green);
      case 'Doğa Eğitimi':
        return Icon(Icons.book, color: Colors.green);
      default:
        return Icon(Icons.error);
    }
  }

  void _addDonation() {
    // Firestore'a bağış ekleyecek kodları buraya yazabilirsiniz.
    // Örneğin:
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance.collection('donations').add({
        'userId': user.uid,
        'name': _name,
        'surname': _surname,
        'email': _email,
        'donation': _selectedDonation,
        'timestamp': Timestamp.now(),
      });
    }
  }
}
