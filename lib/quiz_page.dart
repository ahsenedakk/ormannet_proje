import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> quizQuestions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool isLoading = true;
  String feedbackMessage = '';
  Color feedbackColor = Colors.transparent;
  bool isAnswerSelected = false;
  String selectedOption = '';
  String correctAnswer = '';

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('quiz_questions').get();
      List<Map<String, dynamic>> allQuestions = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      // Shuffle the list and take the first 10 questions
      allQuestions.shuffle(Random());
      quizQuestions = allQuestions.take(10).toList();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching questions: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void checkAnswer(String option) {
    if (isAnswerSelected) return;

    setState(() {
      isAnswerSelected = true;
      selectedOption = option;
      correctAnswer = quizQuestions[currentQuestionIndex]['answer'];
      bool isCorrect = option == correctAnswer;

      if (isCorrect) {
        score++;
        feedbackMessage = 'Doğru cevap!';
        feedbackColor = Colors.green;
      } else {
        feedbackMessage = 'Yanlış cevap! Doğru cevap: $correctAnswer';
        feedbackColor = Colors.red;
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        if (currentQuestionIndex < quizQuestions.length - 1) {
          currentQuestionIndex++;
          feedbackMessage = '';
          feedbackColor = Colors.transparent;
          isAnswerSelected = false;
          selectedOption = '';
        } else {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Quiz Bitti!'),
              content: Text('Skorunuz: $score / ${quizQuestions.length}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('Tamam'),
                ),
              ],
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Soru ${currentQuestionIndex + 1} / ${quizQuestions.length}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                quizQuestions[currentQuestionIndex]['question'],
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: quizQuestions[currentQuestionIndex]['options']
                  .map<Widget>((option) {
                bool isSelected = isAnswerSelected && option == selectedOption;
                bool isCorrect =
                    option == quizQuestions[currentQuestionIndex]['answer'];

                Color optionColor = Colors.white;
                IconData? icon;
                if (isSelected) {
                  optionColor = isCorrect ? Colors.green : Colors.red;
                  icon = isCorrect ? Icons.check : Icons.close;
                }

                return GestureDetector(
                  onTap: () => checkAnswer(option),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: optionColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          option,
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        if (isSelected)
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: optionColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(icon, color: Colors.white, size: 20),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                feedbackMessage,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: feedbackColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Skor: $score',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
