import 'package:flutter/material.dart';
import '../models/plan.dart';
import '../widgets/plan_item.dart';
import '../widgets/create_plan_modal.dart';

class PlanManagerScreen extends StatefulWidget {
  @override
  _PlanManagerScreenState createState() => _PlanManagerScreenState();
}

class _PlanManagerScreenState extends State<PlanManagerScreen> {
  List<Plan> plans = [];

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

  void _openCreatePlanModal() {
    showModalBottomSheet(
      context: context,
      builder: (_) => CreatePlanModal(onSubmit: _addPlan),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adoption & Travel Planner')),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (ctx, index) => PlanItem(
          plan: plans[index],
          onSwipeComplete: () => _toggleCompletion(index),
          onLongPressEdit: () => _updatePlan(index, "Updated Name", "Updated Description"),
          onDoubleTapDelete: () => _deletePlan(index),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreatePlanModal,
        child: Icon(Icons.add),
      ),
    );
  }
}
