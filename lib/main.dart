import 'package:flutter/material.dart';
import 'screens/plan_manager_screen.dart';

void main() {
  runApp(const AdoptionTravelPlannerApp());
}

class AdoptionTravelPlannerApp extends StatelessWidget {
  const AdoptionTravelPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adoption & Travel Planner',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PlanManagerScreen(),
    );
  }
}
