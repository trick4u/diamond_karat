

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cart/card_bloc.dart';

import '../../models/diamond.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Column(
            children: [
              // Summary
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Cart Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Total Carat: ${state.totalCarat.toStringAsFixed(2)}'),
                        Text('Total Price: \$${state.totalPrice.toStringAsFixed(2)}'),
                        Text('Average Price: \$${state.averagePrice.toStringAsFixed(2)}'),
                        Text('Average Discount: ${state.averageDiscount.toStringAsFixed(2)}%'),
                      ],
                    ),
                  ),
                ),
              ),
              // Cart Items
              Expanded(
                child: state.cartItems.isEmpty
                    ? const Center(child: Text('Cart is empty.'))
                    : ListView.builder(
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          final diamond = state.cartItems[index];
                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Lot ID: ${diamond.lotId}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Carat: ${diamond.carat}'),
                                  Text('Lab: ${diamond.lab}'),
                                  Text('Shape: ${diamond.shape}'),
                                  Text('Color: ${diamond.color}'),
                                  Text('Clarity: ${diamond.clarity}'),
                                  Text('Final Amount: \$${diamond.finalAmount}'),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<CartBloc>().add(RemoveFromCart(diamond));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Removed from Cart')),
                                      );
                                    },
                                    child: const Text('Remove from Cart'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}