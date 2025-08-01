const fs = require('fs');

const quizData = {
    quiz: {
        questions: {
            question1: {
                questionText: "Ağaçlar, çevreye nasıl katkı sağlar?",
                options: ["Hava kalitesini iyileştirir", "Su tüketimini artırır", "Toprağı tuzlandırır"],
                correctAnswer: 0
            },
            question2: {
                questionText: "Orman yangınlarının oluşum nedenleri nelerdir?",
                options: ["Doğal nedenler", "İnsan kaynaklı etkenler", "Meteorolojik olaylar"],
                correctAnswer: 1
            },
            question3: {
                questionText: "Sürdürülebilir ormancılık neden önemlidir?",
                options: ["Ekonomik kalkınmayı teşvik eder", "Orman kaynaklarını korur", "Trafik sıkışıklığını azaltır"],
                correctAnswer: 1
            },
            question4: {
                questionText: "Ormancılıkla ilgili faaliyetlerden biri hangisidir?",
                options: ["Okyanus temizliği", "Ağaçlandırma", "Meteoroloji tahminleri"],
                correctAnswer: 1
            },
            question5: {
                questionText: "Ormanların ekosisteme katkıları nelerdir?",
                options: ["Biyolojik çeşitlilik sağlar", "Hava kirliliğini artırır", "Erozyonu hızlandırır"],
                correctAnswer: 0
            },
            question6: {
                questionText: "Ağaçların fotosentez yoluyla hangi gazı emdiği bilinir?",
                options: ["Oksijen", "Azot", "Karbon dioksit"],
                correctAnswer: 2
            },
            question7: {
                questionText: "Orman yangınlarını önlemek için alınabilecek tedbirler nelerdir?",
                options: ["Ormanlarda ateş yürüyüşü düzenlemek", "Yangın gözetleme kuleleri inşa etmek", "Çöpleri ormanlara bırakmak"],
                correctAnswer: 1
            },
            question8: {
                questionText: "Sürdürülebilir ormancılık hangi prensiplere dayanır?",
                options: ["Hızlı tüketim", "Üretkenlik kaybı", "Yenilenebilir kaynak kullanımı"],
                correctAnswer: 2
            },
            question9: {
                questionText: "Ormancılıkla ilgili faaliyetlerden biri hangisidir?",
                options: ["Telekomünikasyon altyapısı", "Orman yangınları ile mücadele", "Teknoloji geliştirme"],
                correctAnswer: 1
            },
            question10: {
                questionText: "Ağaçlandırma çalışmalarının amacı nedir?",
                options: ["Ormanların yok edilmesi", "Orman alanlarını genişletmek", "Ormanların korunması ve yenilenmesi"],
                correctAnswer: 2
            },
            question11: {
                questionText: "Doğal yaşam alanlarının korunması neden önemlidir?",
                options: ["Ekonomik kalkınmayı destekler", "Biyolojik çeşitliliği korur", "Trafik kazalarını azaltır"],
                correctAnswer: 1
            },
            question12: {
                questionText: "Ormanların ekosistem üzerindeki etkileri nelerdir?",
                options: ["Hava kalitesini düşürür", "Toprak erozyonunu artırır", "Biyolojik çeşitliliği destekler"],
                correctAnswer: 2
            },
            question13: {
                questionText: "Ormancılıkta hangi kaynaklar kullanılır?",
                options: ["Petrol ve doğalgaz", "Yenilenebilir enerji kaynakları", "Ahşap ve odun"],
                correctAnswer: 2
            },
            question14: {
                questionText: "Ormanlarda biyolojik çeşitliliğin korunması neden önemlidir?",
                options: ["Tarım verimliliğini artırır", "Habitat kaybını önler", "Su kaynaklarını korur"],
                correctAnswer: 1
            },
            question15: {
                questionText: "Ormancılıkta sürdürülebilirlik nasıl sağlanabilir?",
                options: ["Büyük orman yangınları", "Üretim hızını artırma", "Doğal kaynakları koruma"],
                correctAnswer: 2
            },
            question16: {
                questionText: "Orman yangınları ne gibi zararlara yol açabilir?",
                options: ["Toprak verimliliğini artırır", "Ekosistem dengesini bozar", "Yeraltı su seviyesini artırır"],
                correctAnswer: 1
            },
            question17: {
                questionText: "Ağaçların gövdesi nedir?",
                options: ["Kök", "Gövde", "Dal"],
                correctAnswer: 1
            },
            question18: {
                questionText: "Ağaçların faydaları nelerdir?",
                options: ["Gıda üretimi", "Hava kirliliğini artırma", "Oksijen üretimi"],
                correctAnswer: 2
            },
            question19: {
                questionText: "Ormancılıkla ilgili sürdürülebilir uygulamalar nelerdir?",
                options: ["Orman tahribatı", "Orman yangınları", "Ağaçlandırma"],
                correctAnswer: 2
            },
            question20: {
                questionText: "Ağaçlandırma neden yapılır?",
                options: ["Toprak erozyonunu artırmak için", "Hava kirliliğini azaltmak için", "Orman alanlarını genişletmek için"],
                correctAnswer: 1
            },
            question21: {
                questionText: "Orman yangınları nasıl kontrol altına alınabilir?",
                options: ["Yangın gözetleme kuleleri", "Doğal kaynak kullanımı", "Hava kirliliği"],
                correctAnswer: 0
            },
            question22: {
                questionText: "Sürdürülebilir ormancılık hangi kavramları içerir?",
                options: ["Biyolojik çeşitlilik", "Yenilenebilir enerji", "Küresel ısınma"],
                correctAnswer: 0
            },
            question23: {
                questionText: "Ağaçlandırma çalışmaları ne amaçla yapılır?",
                options: ["Ekosistem dengesini korumak için", "Tarımsal üretimi artırmak için", "Doğal kaynakları tüketmek için"],
                correctAnswer: 0
            },
            question24: {
                questionText: "Orman yangınlarının oluşum nedenleri arasında hangisi vardır?",
                options: ["Su sıkıntısı", "İnsan faktörleri", "Toprak erozyonu"],
                correctAnswer: 1
            },
            question25: {
                questionText: "Sürdürülebilir ormancılık ile ilgili prensipler nelerdir?",
                options: ["Küresel ısınma", "Biyolojik çeşitlilik", "Sınırlı kaynaklar"],
                correctAnswer: 1
            },
            question26: {
                questionText: "Ormanlarda biyolojik çeşitliliğin korunmasının önemi nedir?",
                options: ["Ekonomik büyümeyi teşvik etmek", "Yerel ekosistemleri korumak", "Kentsel alanları genişletmek"],
                correctAnswer: 1
            },
            question27: {
                questionText: "Ormancılıkta kullanılan kaynaklar arasında hangisi yer alır?",
                options: ["Hava kirliliği", "Tarımsal ilaçlar", "Odun ve ahşap ürünler"],
                correctAnswer: 2
            },
            question28: {
                questionText: "Ağaçlandırma çalışmaları ne amaçla yapılır?",
                options: ["Doğal kaynakları tüketmek için", "Ekosistem dengesini korumak için", "Tarımsal üretimi artırmak için"],
                correctAnswer: 1
            },
            question29: {
                questionText: "Orman yangınlarının oluşum nedenleri arasında hangisi vardır?",
                options: ["Toprak erozyonu", "Su sıkıntısı", "İnsan faktörleri"],
                correctAnswer: 2
            },
            question30: {
                questionText: "Ağaçların faydaları nelerdir?",
                options: ["Hava kirliliğini artırma", "Oksijen üretimi", "Gıda üretimi"],
                correctAnswer: 1
            },
            question31: {
                questionText: "Ormanların ekosistem üzerindeki etkileri nelerdir?",
                options: ["Biyolojik çeşitliliği destekler", "Hava kalitesini düşürür", "Toprak erozyonunu artırır"],
                correctAnswer: 0
            },
            question32: {
                questionText: "Ağaçların gövdesi nedir?",
                options: ["Dal", "Kök", "Gövde"],
                correctAnswer: 2
            },
            question33: {
                questionText: "Ağaçların fotosentez yoluyla hangi gazı emdiği bilinir?",
                options: ["Karbon dioksit", "Oksijen", "Azot"],
                correctAnswer: 0
            },
            question34: {
                questionText: "Orman yangınlarını önlemek için alınabilecek tedbirler nelerdir?",
                options: ["Yangın gözetleme kuleleri inşa etmek", "Ormanlarda ateş yürüyüşü düzenlemek", "Çöpleri ormanlara bırakmak"],
                correctAnswer: 0
            },
            question35: {
                questionText: "Orman yangınları ne gibi zararlara yol açabilir?",
                options: ["Yeraltı su seviyesini artırır", "Toprak verimliliğini artırır", "Ekosistem dengesini bozar"],
                correctAnswer: 2
            },
            question36: {
                questionText: "Orman yangınları nasıl kontrol altına alınabilir?",
                options: ["Doğal kaynak kullanımı", "Yangın gözetleme kuleleri", "Hava kirliliği"],
                correctAnswer: 1
            },
            question37: {
                questionText: "Ağaçların fotosentez yoluyla hangi gazı emdiği bilinir?",
                options: ["Azot", "Oksijen", "Karbon dioksit"],
                correctAnswer: 2
            },
            question38: {
                questionText: "Ağaçların gövdesi nedir?",
                options: ["Gövde", "Kök", "Dal"],
                correctAnswer: 0
            },
            question39: {
                questionText: "Ağaçların faydaları nelerdir?",
                options: ["Oksijen üretimi", "Gıda üretimi", "Hava kirliliğini artırma"],
                correctAnswer: 0
            },
            question40: {
                questionText: "Sürdürülebilir ormancılık hangi prensiplere dayanır?",
                options: ["Üretkenlik kaybı", "Hızlı tüketim", "Yenilenebilir kaynak kullanımı"],
                correctAnswer: 2
            }
        }
    }
};

// JSON verisini dosyaya yazma işlemi
const jsonData = JSON.stringify(quizData, null, 2);
fs.writeFileSync('quiz-data.json', jsonData);

console.log('JSON dosyası oluşturuldu: quiz-data.json');
