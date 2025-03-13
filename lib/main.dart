import 'package:flutter/material.dart';
import 'data/data.dart'; // Import the DiamondData class

void main() {
  // Run the app in a minimal way for console testing
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Call the test function after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printDiamondData();
    });

    // Return a minimal MaterialApp (required for Flutter to run)
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Check the console for diamond data output.'),
        ),
      ),
    );
  }

  // Function to print diamond data to the console
  void printDiamondData() {
    // Print total number of diamonds
    final diamonds = DiamondData.getDiamonds();
    debugPrint('Total Diamonds: ${diamonds.length}');

    // Print each diamond
    debugPrint('\n--- List of Diamonds ---');
    for (var i = 0; i < diamonds.length; i++) {
      final diamond = diamonds[i];
      debugPrint('Diamond ${i + 1}:');
      debugPrint('  Lot ID: ${diamond.lotId}');
      debugPrint('  Size: ${diamond.size}');
      debugPrint('  Carat: ${diamond.carat}');
      debugPrint('  Lab: ${diamond.lab}');
      debugPrint('  Shape: ${diamond.shape}');
      debugPrint('  Color: ${diamond.color}');
      debugPrint('  Clarity: ${diamond.clarity}');
      debugPrint('  Cut: ${diamond.cut}');
      debugPrint('  Polish: ${diamond.polish}');
      debugPrint('  Symmetry: ${diamond.symmetry}');
      debugPrint('  Fluorescence: ${diamond.fluorescence}');
      debugPrint('  Discount: ${diamond.discount}%');
      debugPrint('  Per Carat Rate: \$${diamond.perCaratRate}');
      debugPrint('  Final Amount: \$${diamond.finalAmount}');
      debugPrint('  Key to Symbol: ${diamond.keyToSymbol}');
      debugPrint('  Lab Comment: ${diamond.labComment}');
      debugPrint('  Quantity: ${diamond.qty}');
      debugPrint('-------------------');
    }

    // Print unique labs
    final labs = DiamondData.getLabs();
    debugPrint('\n--- Unique Labs ---');
    debugPrint(labs.join(', '));

    // Print unique shapes
    final shapes = DiamondData.getShapes();
    debugPrint('\n--- Unique Shapes ---');
    debugPrint(shapes.join(', '));

    // Print unique colors
    final colors = DiamondData.getColors();
    debugPrint('\n--- Unique Colors ---');
    debugPrint(colors.join(', '));
  }
}