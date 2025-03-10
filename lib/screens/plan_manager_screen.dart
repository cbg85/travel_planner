import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/plan.dart';
import '../widgets/create_plan_modal.dart';
import '../widgets/plan_list.dart';

class PlanManagerScreen extends StatefulWidget {
  const PlanManagerScreen({super.key});

  @override
  _PlanManagerScreenState createState() => _PlanManagerScreenState();
}

class _PlanManagerScreenState extends State<PlanManagerScreen> {
  final List<Plan> _plans = [];

  void _addPlan(String name, String description, DateTime date) {
    setState(() {
      _plans.add(Plan(id: const Uuid().v4(), name: name, description: description, date: date));
    });
  }

  void _toggleCompletion(String id) {
    setState(() {
      final plan = _plans.firstWhere((p) => p.id == id);
      plan.toggleCompleted();
    });
  }

  void _editPlan(String id, String newName, String newDescription, DateTime newDate) {
    setState(() {
      final planIndex = _plans.indexWhere((p) => p.id == id);
      if (planIndex != -1) {
        _plans[planIndex] = Plan(
          id: id,
          name: newName,
          description: newDescription,
          date: newDate,
          isCompleted: _plans[planIndex].isCompleted,
        );
      }
    });
  }

  void _deletePlan(String id) {
    setState(() {
      _plans.removeWhere((p) => p.id == id);
    });
  }

  void _showCreatePlanDialog() {
    showDialog(
      context: context,
      builder: (context) => CreatePlanModal(onAddPlan: _addPlan),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adoption & Travel Planner")),
      body: PlanList(plans: _plans, onToggle: _toggleCompletion, onDelete: _deletePlan, onEdit: _editPlan),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePlanDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
