import '../models/order.dart';

class OrderRepository {
  final List<Order> _orders = [];

  Future<void> addOrder(Order order) async {
    _orders.add(order);
  }

  Future<List<Order>> getAllOrders() async {
    return _orders;
  }

  Future<void> updateOrder(Order order) async {
    final idx = _orders.indexWhere((o) => o.id == order.id);
    if (idx != -1) {
      _orders[idx] = order;
    }
  }
}
