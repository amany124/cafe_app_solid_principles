import 'package:flutter/material.dart';
import 'package:mentor3/managers/order_manager.dart';
import 'package:mentor3/models/order.dart';


class OrderList extends StatelessWidget {
  final List<Order> orders;
  final OrderManager manager;
  final bool isPending;
  final VoidCallback onOrderCompleted;

  const OrderList({
    super.key,
    required this.orders,
    required this.manager,
    required this.isPending,
    required this.onOrderCompleted,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Text("No orders right now.");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(isPending ? " orders on waiting :" : "completed orders :",
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        ...orders.map((o) => Card(
              child: ListTile(
                leading: Image.asset(o.beverage.imagePath, width: 40, height: 40),
                title: Text("${o.customerName} - ${o.beverage.name}"),
                subtitle: Text(o.notes),
                trailing: isPending
                    ? IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () async {
                          await manager.completeOrder(o);
                          onOrderCompleted();
                        },
                      )
                    : const Icon(Icons.done_all, color: Colors.grey),
              ),
            )),
      ],
    );
  }
}
