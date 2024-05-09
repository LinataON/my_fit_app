import 'package:flutter/material.dart';
import 'package:my_fit_app/components/workouts-list.dart';
import 'package:my_fit_app/services/auth.dart';


import '../components/active-workouts.dart';
import '../domain/workout.dart';
class HomePage extends StatefulWidget{
HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int sectionIndex = 0;

@override
Widget build(BuildContext context){
return Container(
child: Scaffold(
backgroundColor: Theme.of(context).primaryColor,
appBar: AppBar(
  title: Text('MyFit /' + (sectionIndex == 0 ? 'Active Workouts' : 'Find Workouts')),
  leading: Icon(Icons.fitness_center),
  actions: <Widget>[
    TextButton.icon(
      onPressed: () {
        AuthService().logOut();
      },
      icon: Icon(Icons.supervised_user_circle),
      label: Text(''),
    )
  ],
),
body: sectionIndex == 0 ? ActiveWorkouts() : WorkoutsList(),
bottomNavigationBar: BottomNavigationBar(
  items: const <BottomNavigationBarItem> [
    BottomNavigationBarItem(
      icon: Icon(Icons.fitness_center),
      label: 'My Workouts'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Find Workouts'
    ),

  ],
  currentIndex: sectionIndex,
  backgroundColor: Colors.white30,
  selectedItemColor: Colors.white,
  onTap: (int index){
    setState( () => sectionIndex = index) ;
  },
),
),
);
}
}

