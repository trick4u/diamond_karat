import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

class Diamond extends Equatable {
  final String lotId;
  final String size;
  final double carat;
  final String lab;
  final String shape;
  final String color;
  final String clarity;
  final String cut;
  final String polish;
  final String symmetry;
  final String fluorescence;
  final double discount;
  final double perCaratRate;
  final double finalAmount;
  final String keyToSymbol;
  final String labComment;
  final int qty;

  const Diamond({
    required this.lotId,
    required this.size,
    required this.carat,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
    required this.cut,
    required this.polish,
    required this.symmetry,
    required this.fluorescence,
    required this.discount,
    required this.perCaratRate,
    required this.finalAmount,
    required this.keyToSymbol,
    required this.labComment,
    required this.qty,
  });

  // Convert Diamond to JSON for persistent storage
  Map<String, dynamic> toJson() {
    return {
      'qty': qty,
      'lotId': lotId,
      'size': size,
      'carat': carat,
      'lab': lab,
      'shape': shape,
      'color': color,
      'clarity': clarity,
      'cut': cut,
      'polish': polish,
      'symmetry': symmetry,
      'fluorescence': fluorescence,
      'discount': discount,
      'perCaratRate': perCaratRate,
      'finalAmount': finalAmount,
      'keyToSymbol': keyToSymbol,
      'labComment': labComment,
    };
  }

  // Create Diamond from JSON
  factory Diamond.fromJson(Map<String, dynamic> json) {
    return Diamond(
      qty: (json['qty'] as int?) ?? 1,
      lotId: json['lotId'] as String? ?? '',
      size: json['size'] as String? ?? '',
      carat: (json['carat'] as num?)?.toDouble() ?? 0.0,
      lab: json['lab'] as String? ?? '',
      shape: json['shape'] as String? ?? '',
      color: json['color'] as String? ?? '',
      clarity: json['clarity'] as String? ?? '',
      cut: json['cut'] as String? ?? '',
      polish: json['polish'] as String? ?? '',
      symmetry: json['symmetry'] as String? ?? '',
      fluorescence: json['fluorescence'] as String? ?? '',
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      perCaratRate: (json['perCaratRate'] as num?)?.toDouble() ?? 0.0,
      finalAmount: (json['finalAmount'] as num?)?.toDouble() ?? 0.0,
      keyToSymbol: json['keyToSymbol'] as String? ?? '',
      labComment: json['labComment'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [
        lotId,
        size,
        carat,
        lab,
        shape,
        color,
        clarity,
        cut,
        polish,
        symmetry,
        fluorescence,
        discount,
        perCaratRate,
        finalAmount,
        keyToSymbol,
        labComment,
        qty,
      ];
}