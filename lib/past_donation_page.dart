import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PastDonationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Geçmiş Bağışlarım'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('donations')
            .where('userId',
                isEqualTo:
                    user!.uid) // Sadece mevcut kullanıcının bağışlarını getir
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Veriler alınamadı: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Henüz bağış yapılmamış.'));
          }

          return ListView(
            padding: EdgeInsets.all(16),
            children: snapshot.data!.docs.map((document) {
              return Card(
                elevation: 3,
                child: ListTile(
                  title: Text('${document['name']} ${document['surname']}'),
                  subtitle: Text('${document['donation']}'),
                  trailing: Text(
                    '${document['timestamp'].toDate().toString()}',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
