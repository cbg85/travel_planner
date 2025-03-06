import 'package:flutter/material.dart';
import '../models/plan.dart';

class PlanItem extends StatelessWidget {
  final Plan plan;
  final VoidCallback onSwipeComplete;
  final VoidCallback onLongPressEdit;
  final VoidCallback onDoubleTapDelete;

  PlanItem({
    required this.plan,
    required this.onSwipeComplete,
    required this.onLongPressEdit,
    required this.onDoubleTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(plan.name),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onSwipeComplete(),
      background: Container(color: Colors.green, alignment: Alignment.centerRight, padding: EdgeInsets.only(right: 20), child: Icon(Icons.check, color: Colors.white)),
      child: GestureDetector(
        onLongPress: onLongPressEdit,
        onDoubleTap: onDoubleTapDelete,
        child: Card(
          color: plan.isCompleted ? Colors.grey[300] : Colors.white,
          child: ListTile(
            title: Text(plan.name, style: TextStyle(decoration: plan.isCompleted ? TextDecoration.lineThrough : null)),
            subtitle: Text(plan.description),
            trailing: plan.isCompleted ? Icon(Icons.check_circle, color: Colors.green) : Icon(Icons.circle_outlined),
          ),
        ),
      ),
    );
  }
}
