import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key,
      required this.choosenAnswers,
      required this.restartQuiz,
      required this.exitQuiz});
  final List<String> choosenAnswers;
  final void Function() restartQuiz;
  final void Function() exitQuiz;

//this return a list of values but not a list of strings or widgets
//thats why use Map, maps values to keys, Map<keys, values>
//this list or map will passed the values to show in the result screen
  List<Map<String, Object>> getSummaryData() {
    //this list of maps needs to be passed to questions summary
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < choosenAnswers.length; i++) {
      summary.add({
        //key(in this case a string):value
        //the key in this case is a string, that's why it uses a quotation
        //use colon to separate key and value, instead of equal sign
        'question_index': i, //i is inital zero or the index is zero
        'question': questions[i].text, //based on the index or i
        'correct_answer': questions[i]
            .answers[0], //always the first answer is the correct one
        'user_answer': choosenAnswers[i]
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where(
      (data) {
        return data['user_answer'] == data['correct_answer'];
      },
    ).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
              'You Answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: restartQuiz, child: const Text('Restart Quiz')),
            TextButton(onPressed: exitQuiz, child: const Text('Exit Quiz'))
          ],
        ),
      ),
    );
  }
}
