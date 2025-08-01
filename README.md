# OrmanNet

OrmanNet, Türkiye Tarım ve Orman Bakanlığı’na bağlı özel bir şirkette staj kapsamında geliştirilmiş, Flutter tabanlı bir mobil uygulamadır.  
Amaç, orman alanlarının harita üzerinde görselleştirilmesi, eğitim videoları, kullanıcı yönetimi, bağış sistemi ve sertifika modülünü içeren kapsamlı bir platform sunmaktır.

---

## Özellikler

- Harita üzerinde orman alanlarının görselleştirilmesi  
- Video eğitim içerikleri ve eğitim sonrası testler  
- Firebase Authentication ile kullanıcı kayıt ve giriş  
- Bağış yapma ve geçmiş bağışların görüntülenmesi  
- Sertifika görüntüleme  
- Kullanıcı geri bildirim ekranı

---

## Teknolojiler

- Flutter (Dart)  
- Firebase (Authentication, Realtime Database)  
- Google Maps API  
- Yerel REST API (Orman verisi için)  
- Git / GitHub

---

## Dosya ve Klasör Yapısı

ormannet_proje/
├── lib/
│ ├── main.dart # Uygulama başlangıç noktası
│ ├── login_page.dart # Kullanıcı giriş ekranı
│ ├── register_page.dart # Kullanıcı kayıt ekranı
│ ├── map_page.dart # Harita ve orman alanları
│ ├── education_page.dart # Eğitim videoları ekranı
│ ├── quiz_page.dart # Eğitim sonrası test ekranı
│ ├── donation_page.dart # Bağış ekranı
│ ├── past_donation_page.dart # Geçmiş bağışların listelenmesi
│ ├── certificate_screen.dart # Sertifika görüntüleme
│ ├── feedback_screen.dart # Geri bildirim ekranı
│ └── services/ # API ve Firebase servisleri
├── assets/ # Video ve görsel dosyalar
├── android/ # Android platform dosyaları
├── ios/ # iOS platform dosyaları
└── pubspec.yaml # Proje bağımlılıkları



---

## Uygulama İşleyişi

- **map_page.dart:** Yerel REST API’den orman alanı koordinatları çekilir, Google Maps üzerinde poligonlar olarak gösterilir.  
- **education_page.dart ve quiz_page.dart:** Eğitim videoları izlenir, ardından kullanıcı bilgisi test edilir. Sonuçlar Firebase’e kaydedilir.  
- **login_page.dart ve register_page.dart:** Firebase Authentication ile kullanıcı yönetimi yapılır.  
- **donation_page.dart:** Kullanıcı bağış yapabilir, bilgiler Firebase Realtime Database’e kaydedilir.  
- **past_donation_page.dart:** Kullanıcının geçmiş bağışları listelenir.  
- **certificate_screen.dart:** Bağış veya eğitim sonrası sertifikalar görüntülenir.  
- **feedback_screen.dart:** Kullanıcılar uygulama hakkında geri bildirimde bulunabilir.

---

## Kurulum ve Çalıştırma

```bash
git clone https://github.com/ahsenedakk/ormannet_proje.git
cd ormannet_proje
flutter pub get
flutter run
Not: Firebase servislerini kullanabilmek için google-services.json (Android) ve GoogleService-Info.plist (iOS) dosyalarını ilgili platform klasörlerine yerleştirmeniz gerekmektedir.

Lisans
MIT Lisansı kapsamında dağıtılmaktadır.

İletişim
Ahsen Eda Kocaballı
GitHub
ahsenedakk@gmail.com


