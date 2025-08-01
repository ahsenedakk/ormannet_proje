import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<LatLng> forestAreas = [];
  bool isLoading = true; // Yükleme durumunu izleyen değişken

  @override
  void initState() {
    super.initState();
    fetchForestAreas();
  }

  Future<void> fetchForestAreas() async {
    setState(() {
      isLoading = true; // Veri çekilmeye başlandığında yüklüyor durumunu göster
    });

    try {
      final response =
          await http.get(Uri.parse('http://192.168.137.28:3000/api/parkAreas'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          forestAreas = parseForestAreas(data);
          isLoading = false; // Veri çekildiğinde yüklemeyi kapat
        });
      } else {
        throw Exception('Failed to load forest areas');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false; // Hata durumunda da yüklemeyi kapat
      });
    }
  }

  List<LatLng> parseForestAreas(dynamic data) {
    List<LatLng> areas = [];
    for (var element in data['elements']) {
      if (element['type'] == 'node') {
        areas.add(LatLng(element['lat'], element['lon']));
      }
    }
    return areas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.map),
            SizedBox(width: 10),
            Text('Harita'),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchForestAreas,
            // Yenile düğmesine tıklanınca yapılacak işlem
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter:
                  LatLng(39.9334, 32.8597), // Ankara'nın koordinatları
              initialZoom: 10.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: forestAreas.map((area) {
                  return Marker(
                    point: area,
                    width: 80.0,
                    height: 80.0,
                    child: const Icon(Icons.local_florist, color: Colors.green),
                  );
                }).toList(),
              ),
            ],
          ),
          if (isLoading) // Yükleniyor durumunda gösterilecek widget
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text(
                      'Veriler yükleniyor...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MapPage(),
  ));
}
