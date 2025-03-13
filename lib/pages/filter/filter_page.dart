import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/filter/filter_bloc.dart';
import '../../data/data.dart';
import '../result/result_page.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Filter Diamonds')),
        body: BlocBuilder<FilterBloc, FilterState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Carat Range
                  const Text('Carat Range'),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(labelText: 'From'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            final caratFrom = double.tryParse(value) ?? 0.0;
                            context.read<FilterBloc>().add(UpdateCaratRange(caratFrom, state.caratTo));
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(labelText: 'To'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            final caratTo = double.tryParse(value) ?? 6.0;
                            context.read<FilterBloc>().add(UpdateCaratRange(state.caratFrom, caratTo));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Lab Dropdown
                  DropdownButton<String>(
                    hint: const Text('Select Lab'),
                    value: state.lab.isEmpty ? null : state.lab,
                    items: DiamondData.getLabs()
                        .map((lab) => DropdownMenuItem(value: lab, child: Text(lab)))
                        .toList()
                      ..add(const DropdownMenuItem(value: '', child: Text('All'))),
                    onChanged: (value) {
                      context.read<FilterBloc>().add(UpdateLab(value ?? ''));
                    },
                  ),

                  // Shape Dropdown
                  DropdownButton<String>(
                    hint: const Text('Select Shape'),
                    value: state.shape.isEmpty ? null : state.shape,
                    items: DiamondData.getShapes()
                        .map((shape) => DropdownMenuItem(value: shape, child: Text(shape)))
                        .toList()
                      ..add(const DropdownMenuItem(value: '', child: Text('All'))),
                    onChanged: (value) {
                      context.read<FilterBloc>().add(UpdateShape(value ?? ''));
                    },
                  ),

                  // Color Dropdown
                  DropdownButton<String>(
                    hint: const Text('Select Color'),
                    value: state.color.isEmpty ? null : state.color,
                    items: DiamondData.getColors()
                        .map((color) => DropdownMenuItem(value: color, child: Text(color)))
                        .toList()
                      ..add(const DropdownMenuItem(value: '', child: Text('All'))),
                    onChanged: (value) {
                      context.read<FilterBloc>().add(UpdateColor(value ?? ''));
                    },
                  ),

                  // Clarity Dropdown
                  const SizedBox(height: 16),
                  DropdownButton<String>(
                    hint: const Text('Select Clarity'),
                    value: state.clarity.isEmpty ? null : state.clarity,
                    items: ['FL', 'IF', 'VVS1', 'VVS2', 'VS1', 'VS2', 'SI1', 'SI2', 'I1']
                        .map((clarity) => DropdownMenuItem(value: clarity, child: Text(clarity)))
                        .toList()
                      ..add(const DropdownMenuItem(value: '', child: Text('All'))),
                    onChanged: (value) {
                      context.read<FilterBloc>().add(UpdateClarity(value ?? ''));
                    },
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FilterBloc>().add(ApplyFilters());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            filteredDiamonds: state.filteredDiamonds,
                          ),
                        ),
                      );
                    },
                    child: const Text('Search'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}