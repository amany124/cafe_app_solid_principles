import 'package:flutter/material.dart';
import '../../managers/order_manager.dart';

class ReportScreen extends StatelessWidget {
  final OrderManager manager;

  const ReportScreen({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: Colors.brown.shade100,
      appBar: AppBar(title: const Text("Sales Report", style: TextStyle(
          color: Colors.white
        ),),
      backgroundColor: Colors.brown.shade400,
      iconTheme: const IconThemeData(
        color: Colors.white, //change your color here
      ),),
      body: FutureBuilder(
        future: manager.generateReport(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final report = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Orders: ${report.totalOrders}",
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 10),
                Text("Completed Orders: ${report.totalServed}",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 20),
                Text("Top Selling Drinks:",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),

                // Simple Table
                Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                  },
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(color: Colors.white),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Drink Name",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Quantity",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    ...report.topSelling.map(
                      (e) => TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.key),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${e.value}"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
