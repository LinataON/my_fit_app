import 'package:flutter/material.dart';
import 'package:my_fit_app/components/workouts-list.dart';


import '../domain/workout.dart';
class HomePage extends StatelessWidget{
const HomePage({Key? key}) : super(key: key);

@override
Widget build(BuildContext context){
return Container(
child: Scaffold(
backgroundColor: Theme.of(context).primaryColor,
appBar: AppBar(title: Text('My Fitness Plan'), leading: Icon(Icons.fitness_center), ),
body: WorkoutsList(),
),
);
}
}

