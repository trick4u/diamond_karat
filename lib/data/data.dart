

import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

import '../models/diamond.dart';

class DiamondData {
  static Future<List<Diamond>> loadDiamonds() async {
    final bytes = await rootBundle.load('assets/diamond.xlsx');
    final excel = Excel.decodeBytes(bytes.buffer.asUint8List());
    final sheet = excel.tables[excel.tables.keys.first]!;

    List<Diamond> diamonds = [];
    int startRow = 0;
    int startCol = 3; // Data starts at column D (index 3)

    // Find the header row
    for (var i = 0; i < sheet.rows.length; i++) {
      final row = sheet.rows[i];
      if (row.length > startCol && row[startCol]?.value.toString() == 'Qty') {
        startRow = i;
        break;
      }
    }

    // Load data rows (skip header and limit to 100 diamonds)
    for (var i = startRow + 1; i < startRow + 101 && i < sheet.rows.length; i++) {
      final row = sheet.rows[i];
      if (row.length <= startCol + 1 || row[startCol + 1]?.value == null) {
        continue; // Skip rows with no Lot ID (e.g., summary row)
      }

      final data = row.sublist(startCol, startCol + 17); // 17 columns of data
      diamonds.add(Diamond(
        lotId: data[1]?.value.toString() ?? '',
        size: data[2]?.value.toString() ?? '',
        carat: double.tryParse(data[3]?.value.toString() ?? '0.0') ?? 0.0,
        lab: data[4]?.value.toString() ?? '',
        shape: data[5]?.value.toString() ?? '',
        color: data[6]?.value.toString() ?? '',
        clarity: data[7]?.value.toString() ?? '',
        cut: data[8]?.value.toString() ?? '',
        polish: data[9]?.value.toString() ?? '',
        symmetry: data[10]?.value.toString() ?? '',
        fluorescence: data[11]?.value.toString() ?? '',
        discount: double.tryParse(data[12]?.value.toString() ?? '0.0') ?? 0.0,
        perCaratRate: double.tryParse(data[13]?.value.toString() ?? '0.0') ?? 0.0,
        finalAmount: double.tryParse(data[14]?.value.toString() ?? '0.0') ?? 0.0,
        keyToSymbol: data[15]?.value.toString() ?? '',
        labComment: data[16]?.value.toString() ?? '',
      ));
    }

    return diamonds;
  }

  // Extract unique values for filters
  static Future<List<String>> getLabs() async {
    final diamonds = await loadDiamonds();
    return diamonds.map((d) => d.lab).toSet().toList();
  }

  static Future<List<String>> getShapes() async {
    final diamonds = await loadDiamonds();
    return diamonds.map((d) => d.shape).toSet().toList();
  }

  static Future<List<String>> getColors() async {
    final diamonds = await loadDiamonds();
    return diamonds.map((d) => d.color).toSet().toList();
  }

  static Future<List<String>> getClarity() async {
    final diamonds = await loadDiamonds();
    return diamonds.map((d) => d.clarity).toSet().toList();
  }
}