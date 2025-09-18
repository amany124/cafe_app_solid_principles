import 'beverage.dart';

class Order {
  final String id;
  final String customerName;
  final Beverage beverage;
  final String notes;
  bool completed;

  Order({
    required this.customerName,
    required this.beverage,
    required this.notes,
  })  : id = DateTime.now().millisecondsSinceEpoch.toString(),
        completed = false;

  void markCompleted() {
    completed = true;
  }
}
