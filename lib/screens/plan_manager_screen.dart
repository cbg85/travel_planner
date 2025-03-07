import 'package:flutter/material.dart';
import '../models/plan.dart';
import '../widgets/plan_list.dart';
import '../widgets/create_plan_modal.dart';
import 'package:table_calendar/table_calendar.dart';

class PlanManagerScreen extends StatefulWidget {
  const PlanManagerScreen({super.key});

  @override
  _PlanManagerScreenState createState() => _PlanManagerScreenState();
}

class _PlanManagerScreenState extends State<PlanManagerScreen> {
  List<Plan> plans = [];
  DateTime _selectedDate = DateTime.now();

  void _addPlan(String name, String description, DateTime date) {
    setState(() {
      plans.add(Plan(name: name, description: description, date: date));
    });
  }

  void _updatePlan(int index, String newName, String newDescription) {
    setState(() {
      plans[index].name = newName;
      plans[index].description = newDescription;
    });
  }

  void _toggleCompletion(int index) {
    setState(() {
      plans[index].isCompleted = !plans[index].isCompleted;
    });
  }

  void _deletePlan(int index) {
    setState(() {
      plans.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adoption & Travel Planner')),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
          ),
          Expanded(
            child: PlanList(
              plans: plans,
              onToggleComplete: _toggleCompletion,
              onUpdate: _updatePlan,
              onDelete: _deletePlan,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => CreatePlanModal(onSubmit: _addPlan),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
