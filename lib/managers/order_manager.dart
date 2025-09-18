import 'package:mentor3/repository/order_repository.dart';

import '../models/beverage.dart';
import '../models/order.dart';
import '../models/report.dart';


class OrderManager {
  final OrderRepository _repo;
  OrderManager(this._repo);

  Future<List<Order>> pendingOrders() async {
    final all = await _repo.getAllOrders();
    return all.where((o) => !o.completed).toList();
  }

  Future<List<Order>> completedOrders() async {
    final all = await _repo.getAllOrders();
    return all.where((o) => o.completed).toList();
  }

  Future<void> addOrder(String customerName, Beverage beverage, String notes) async {
    final order = Order(customerName: customerName, beverage: beverage, notes: notes);
    await _repo.addOrder(order);
  }

  Future<void> completeOrder(Order order) async {
    order.markCompleted();
    await _repo.updateOrder(order);
  }

  /// توليد تقرير المبيعات
  Future<Report> generateReport() async {
    final completed = await completedOrders();
    final pending = await pendingOrders();
    final all = [...completed, ...pending]; // كل الطلبات

    final Map<String, int> counts = {};
    for (final o in completed) {
      counts[o.beverage.name] = (counts[o.beverage.name] ?? 0) + 1;
    }

    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Report(
      totalServed: completed.length,
      totalOrders: all.length,
      topSelling: sorted,
    );
  }
}
