import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  //constructor
  //the this.summaryData to accept and set the summaryData
  const QuestionsSummary(this.summaryData, {super.key});

  //a property that contains all the maps from result screen to pass data from resultscreen
  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        //a widget built in to flutter
        //takes a single child in this the column and makes it scrollable
        child: Column(
          children: summaryData.map((data) {
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal:
                          15), // Ensure height equals width for a perfect circle
                  decoration: BoxDecoration(
                    color: data['user_answer'] == data['correct_answer']
                        ? Colors.green
                        : Colors.red,
                    shape: BoxShape.circle, // Set the shape to circle
                  ),
                  child: Text(
                    ((data['question_index'] as int) + 1).toString(),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  //expanded allows its child to take the available space along the flex widgets main axis
                  // flex widget is simply a row or column widget above the widget that you put into expanded
                  child: Column(
                    //column takes an infinite amount of screen even beyond the boundary
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['question'] as String,
                        style: GoogleFonts.lato(
                          color: const Color.fromARGB(255, 225, 255, 255),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data['user_answer'] as String,
                        style: GoogleFonts.lato(
                          color: const Color.fromARGB(186, 247, 214, 242),
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        data['correct_answer'] as String,
                        style: GoogleFonts.lato(
                          color: const Color.fromARGB(255, 96, 236, 131),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
