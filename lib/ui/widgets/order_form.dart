import 'package:flutter/material.dart';
import 'package:mentor3/managers/order_manager.dart';
import 'package:mentor3/models/beverage.dart';


class OrderForm extends StatefulWidget {
  final OrderManager manager;
  final List<Beverage> beverages;
  final VoidCallback onOrderAdded;

  const OrderForm({
    super.key,
    required this.manager,
    required this.beverages,
    required this.onOrderAdded,
  });

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  final _customerController = TextEditingController();
  final _notesController = TextEditingController();
  Beverage? _selectedDrink;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Add new order", style: Theme.of(context).textTheme.titleLarge),
              TextFormField(
                controller: _customerController,
                decoration: const InputDecoration(labelText: 'customer name'  ),
                validator: (val) => val!.isEmpty ? "Enter customer name": null,
              ),
              DropdownButtonFormField<Beverage>(
                value: _selectedDrink,
                items: widget.beverages
                    .map((b) => DropdownMenuItem(
                          value: b,
                          child: Row(
                            children: [
                              Image.asset(b.imagePath, width: 30, height: 30),
                              const SizedBox(width: 8),
                              Text(b.name),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedDrink = val),
                decoration: const InputDecoration(labelText: "drinks"),
                validator: (val) => val == null ? "choose a drink" : null,
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: "notes"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await widget.manager.addOrder(
                      _customerController.text,
                      _selectedDrink!,
                      _notesController.text,
                    );
                    widget.onOrderAdded();
                    _customerController.clear();
                    _notesController.clear();
                    setState(() => _selectedDrink = null);
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
