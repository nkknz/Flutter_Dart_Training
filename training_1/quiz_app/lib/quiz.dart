import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';

const startAlignment = Alignment.topRight;
const endAlignment = Alignment.bottomLeft;
const color1 = Color.fromARGB(255, 57, 36, 103);
const color2 = Color.fromARGB(255, 93, 53, 135);

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  //To get the list of selected answers when pressing the button
  List<String> selectedAnswers = [];
  //a variable to show that start-screen is equal to this screen, to initialized
  var activeScreen = 'start-screen';

  //this will switch the screen to the questions screen
  switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

//this functions shows the result after the number of selected answers is equal to the questions
//this also makes the selected answers reset to empty when the result is shown
  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  void resetQuiz() {
    setState(() {
      // Reset choosenAnswers to an empty list
      selectedAnswers = []; //or use this 'selectedAnswers.clear();'
      // Change activeScreen to 'questions-screen'
      activeScreen = 'questions-screen';
    });
  }

  void exitQuiz() {
    setState(() {
      // Reset choosenAnswers to an empty list
      selectedAnswers = []; //or use this 'selectedAnswers.clear();'
      // Change activeScreen to 'questions-screen'
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(context) {
    Widget? screenWidget = StartScreen(switchScreen);

//this statement determines if the questions-screen is selected, it shows the QuestionsScreen widget
//and the onSelectAnswer, it passes the function and gets the chooseAnswer method
    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

//this statement determines that if the result screen is selected, then it will show the ResultScreen widget
//the choosenAnswers where passed to have an indirect access to the function and its data
    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        choosenAnswers: selectedAnswers,
        restartQuiz: resetQuiz,
        exitQuiz: exitQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [color1, color2],
                begin: startAlignment,
                end: endAlignment),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
