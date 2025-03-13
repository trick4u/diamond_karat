

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cart/card_bloc.dart';

import '../../bloc/result/result_bloc.dart';
import '../../models/diamond.dart';
import '../cart/cart_page.dart';


class ResultPage extends StatelessWidget {
  final List<Diamond> filteredDiamonds;

  const ResultPage({super.key, required this.filteredDiamonds});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultBloc()..add(LoadDiamonds(filteredDiamonds)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Filtered Diamonds'),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ResultBloc, ResultState>(
          builder: (context, state) {
            return Column(
              children: [
                // Sorting Options
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        hint: const Text('Sort by Price'),
                        items: const [
                          DropdownMenuItem(value: 'asc', child: Text('Price: Low to High')),
                          DropdownMenuItem(value: 'desc', child: Text('Price: High to Low')),
                        ],
                        onChanged: (value) {
                          if (value == 'asc') {
                            context.read<ResultBloc>().add(SortByPrice(true));
                          } else if (value == 'desc') {
                            context.read<ResultBloc>().add(SortByPrice(false));
                          }
                        },
                      ),
                      DropdownButton<String>(
                        hint: const Text('Sort by Carat'),
                        items: const [
                          DropdownMenuItem(value: 'asc', child: Text('Carat: Low to High')),
                          DropdownMenuItem(value: 'desc', child: Text('Carat: High to Low')),
                        ],
                        onChanged: (value) {
                          if (value == 'asc') {
                            context.read<ResultBloc>().add(SortByCarat(true));
                          } else if (value == 'desc') {
                            context.read<ResultBloc>().add(SortByCarat(false));
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: state.diamonds.isEmpty
                      ? const Center(child: Text('No diamonds match your filters.'))
                      : ListView.builder(
                          itemCount: state.diamonds.length,
                          itemBuilder: (context, index) {
                            final diamond = state.diamonds[index];
                            return Card(
                              margin: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Lot ID: ${diamond.lotId}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Text('Size: ${diamond.size}'),
                                    Text('Carat: ${diamond.carat}'),
                                    Text('Lab: ${diamond.lab}'),
                                    Text('Shape: ${diamond.shape}'),
                                    Text('Color: ${diamond.color}'),
                                    Text('Clarity: ${diamond.clarity}'),
                                    Text('Cut: ${diamond.cut}'),
                                    Text('Polish: ${diamond.polish}'),
                                    Text('Symmetry: ${diamond.symmetry}'),
                                    Text('Fluorescence: ${diamond.fluorescence}'),
                                    Text('Discount: ${diamond.discount}%'),
                                    Text('Per Carat Rate: \$${diamond.perCaratRate}'),
                                    Text('Final Amount: \$${diamond.finalAmount}'),
                                    Text('Key to Symbol: ${diamond.keyToSymbol}'),
                                    Text('Lab Comment: ${diamond.labComment}'),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<CartBloc>().add(AddToCart(diamond));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Added to Cart')),
                                        );
                                      },
                                      child: const Text('Add to Cart'),
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
      ),
    );
  }
}