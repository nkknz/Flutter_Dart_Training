import 'package:flutter/material.dart';
import 'package:first_app/dice_roller.dart';

//final keyword - this wil never receive a new value
//const - same as final but constant only the time compiled

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.color1, this.color2,
      {super.key}); //automatically takes key as its key then passes it to parent class

  const GradientContainer.blue({super.key})
      : color1 = Colors.blue,
        color2 = Colors.blueGrey;
  //a contructor function for convenience

  final Color color1;
  final Color color2;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [color1, color2], begin: startAlignment, end: endAlignment),
      ),
      child: const Center(child: DiceRoller()),
    );
  }
}







/*class GradientContainer extends StatelessWidget {
  //Constructor Functions - To do this, repeat the class name add parenthesis
  //and/or curly braces(to have initialization), curly braces is not required outside the parenthesis
  //like this GradientContainer(){}, to take out blue lines - must put the curly braces inside the
  //parenthesis then put the word key
  //GradientContainer({key}): super(key: key) //super keyword refers to the parent class
  GradientContainer(
      {super.key,
      required this.colors}); //automatically takes key as its key then passes it to parent class

  final List<Color> colors;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors, begin: startAlignment, end: endAlignment),
      ),
      child: const Center(
        child: StyledText('Hello Chicken!'),
      ),
    );
  }
}
*/