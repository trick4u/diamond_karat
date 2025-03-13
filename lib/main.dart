import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:excel/excel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Test loading and reading the Excel asset
  try {
    final bytes = await rootBundle.load('assets/diamond.xlsx');
    final excel = Excel.decodeBytes(bytes.buffer.asUint8List());
    final sheet = excel.tables[excel.tables.keys.first]; // Get the first sheet

    // Print basic info to console
    print('Excel file loaded successfully!');
    print('Sheet name: ${sheet?.sheetName}');
    print('Total rows: ${sheet?.rows.length}');

    // Find the starting row of the actual data (skip empty rows)
    int startRow = 0;
    for (var i = 0; i < sheet!.rows.length; i++) {
      final row = sheet.rows[i];
      // Check if the row has the header "Qty" in column 3 (D)
      if (row.length > 3 && row[3]?.value.toString() == 'Qty') {
        startRow = i;
        break;
      }
    }

    // Find the starting column of the actual data (skip empty columns)
    int startCol = 3; // We know from the output that data starts at column D (index 3)

    // Extract headers starting from the correct column
    final headerRow = sheet.rows[startRow];
    final headers = headerRow
        .sublist(startCol, startCol + 17) // Take only the 17 columns of actual data
        .map((cell) => cell?.value.toString() ?? '')
        .toList();
    print('Header row: $headers');

    // Extract data rows (skip the header row and any rows after the 100 diamonds)
    for (var i = startRow + 1; i < startRow + 101 && i < sheet.rows.length; i++) {
      final row = sheet.rows[i];
      // Skip rows that don't have valid data in the Lot ID column (index 4 after startCol)
      if (row.length <= startCol + 1 || row[startCol + 1]?.value == null) {
        continue;
      }
      final data = row
          .sublist(startCol, startCol + 17) // Take only the 17 columns of actual data
          .map((cell) => cell?.value.toString() ?? '')
          .toList();
      print('Row ${i - startRow}: $data');
    }
  } catch (e, stackTrace) {
    print('Error loading Excel file: $e');
    print('Stack trace: $stackTrace');
  }

  // Run a minimal app to keep the process alive
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Excel Test')),
        body: const Center(child: Text('Check the console for Excel contents')),
      ),
    );
  }
}