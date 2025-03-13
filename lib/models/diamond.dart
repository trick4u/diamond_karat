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
  });

  // Convert Diamond to JSON for persistent storage
  Map<String, dynamic> toJson() {
    return {
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
      lotId: json['lotId'],
      size: json['size'],
      carat: json['carat'],
      lab: json['lab'],
      shape: json['shape'],
      color: json['color'],
      clarity: json['clarity'],
      cut: json['cut'],
      polish: json['polish'],
      symmetry: json['symmetry'],
      fluorescence: json['fluorescence'],
      discount: json['discount'],
      perCaratRate: json['perCaratRate'],
      finalAmount: json['finalAmount'],
      keyToSymbol: json['keyToSymbol'],
      labComment: json['labComment'],
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
      ];
}