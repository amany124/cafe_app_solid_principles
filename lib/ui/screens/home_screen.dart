import 'package:flutter/material.dart';
import 'package:mentor3/managers/order_manager.dart';
import 'package:mentor3/models/beverage.dart';
import 'package:mentor3/models/order.dart';


import '../widgets/order_form.dart';
import '../widgets/order_list.dart';

class HomeScreen extends StatefulWidget {
  final OrderManager manager;

  const HomeScreen({super.key, required this.manager});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final beverages = [
    Beverage(name: "شاي", imagePath: "assets/images/shai.webp"),
    Beverage(name: "قهوة تركي", imagePath: "assets/images/coffe.jpg"),
    Beverage(name: "كركديه", imagePath: "assets/images/karkada.jpg"),
  ];

  List<Order> _pendingOrders = [];

  @override
  void initState() {
    super.initState();
    _loadPending();
  }

  Future<void> _loadPending() async {
    final orders = await widget.manager.pendingOrders();
    setState(() {
      _pendingOrders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade400,
        title: const Text("☕ Ahwa ala kefak" , style: TextStyle(
          color: Colors.white
        ),),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart , color: Colors.white,),
            onPressed: () {
              Navigator.pushNamed(context, '/report');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            OrderForm(
              manager: widget.manager,
              beverages: beverages,
              onOrderAdded: _loadPending,
            ),
            const SizedBox(height: 20),
            OrderList(
              orders: _pendingOrders,
              manager: widget.manager,
              isPending: true,
              onOrderCompleted: _loadPending,
            ),
          ],
        ),
      ),
    );
  }
}
