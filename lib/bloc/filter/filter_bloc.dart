

import 'package:equatable/equatable.dart';

import '../../data/data.dart';
import '../../models/diamond.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FilterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateCaratRange extends FilterEvent {
  final double caratFrom;
  final double caratTo;

  UpdateCaratRange(this.caratFrom, this.caratTo);

  @override
  List<Object?> get props => [caratFrom, caratTo];
}

class UpdateLab extends FilterEvent {
  final String lab;

  UpdateLab(this.lab);

  @override
  List<Object?> get props => [lab];
}

class UpdateShape extends FilterEvent {
  final String shape;

  UpdateShape(this.shape);

  @override
  List<Object?> get props => [shape];
}

class UpdateColor extends FilterEvent {
  final String color;

  UpdateColor(this.color);

  @override
  List<Object?> get props => [color];
}

class UpdateClarity extends FilterEvent {
  final String clarity;

  UpdateClarity(this.clarity);

  @override
  List<Object?> get props => [clarity];
}

class ApplyFilters extends FilterEvent {}

// State
class FilterState extends Equatable {
  final double caratFrom;
  final double caratTo;
  final String lab;
  final String shape;
  final String color;
  final String clarity;
  final List<Diamond> filteredDiamonds;

  const FilterState({
    this.caratFrom = 0.0,
    this.caratTo = 6.0,
    this.lab = '',
    this.shape = '',
    this.color = '',
    this.clarity = '',
    this.filteredDiamonds = const [],
  });

  FilterState copyWith({
    double? caratFrom,
    double? caratTo,
    String? lab,
    String? shape,
    String? color,
    String? clarity,
    List<Diamond>? filteredDiamonds,
  }) {
    return FilterState(
      caratFrom: caratFrom ?? this.caratFrom,
      caratTo: caratTo ?? this.caratTo,
      lab: lab ?? this.lab,
      shape: shape ?? this.shape,
      color: color ?? this.color,
      clarity: clarity ?? this.clarity,
      filteredDiamonds: filteredDiamonds ?? this.filteredDiamonds,
    );
  }

  @override
  List<Object?> get props => [
        caratFrom,
        caratTo,
        lab,
        shape,
        color,
        clarity,
        filteredDiamonds,
      ];
}

// BLoC
class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState()) {
    on<UpdateCaratRange>(_onUpdateCaratRange);
    on<UpdateLab>(_onUpdateLab);
    on<UpdateShape>(_onUpdateShape);
    on<UpdateColor>(_onUpdateColor);
    on<UpdateClarity>(_onUpdateClarity);
    on<ApplyFilters>(_onApplyFilters);
  }

  void _onUpdateCaratRange(UpdateCaratRange event, Emitter<FilterState> emit) {
    emit(state.copyWith(
      caratFrom: event.caratFrom,
      caratTo: event.caratTo,
    ));
  }

  void _onUpdateLab(UpdateLab event, Emitter<FilterState> emit) {
    emit(state.copyWith(lab: event.lab));
  }

  void _onUpdateShape(UpdateShape event, Emitter<FilterState> emit) {
    emit(state.copyWith(shape: event.shape));
  }

  void _onUpdateColor(UpdateColor event, Emitter<FilterState> emit) {
    emit(state.copyWith(color: event.color));
  }

  void _onUpdateClarity(UpdateClarity event, Emitter<FilterState> emit) {
    emit(state.copyWith(clarity: event.clarity));
  }

  void _onApplyFilters(ApplyFilters event, Emitter<FilterState> emit) {
    final allDiamonds = DiamondData.getDiamonds();
    final filtered = allDiamonds.where((diamond) {
      bool passesCarat = diamond.carat >= state.caratFrom && diamond.carat <= state.caratTo;
      bool passesLab = state.lab.isEmpty || diamond.lab == state.lab;
      bool passesShape = state.shape.isEmpty || diamond.shape == state.shape;
      bool passesColor = state.color.isEmpty || diamond.color == state.color;
      bool passesClarity = state.clarity.isEmpty || diamond.clarity == state.clarity;
      return passesCarat && passesLab && passesShape && passesColor && passesClarity;
    }).toList();
    emit(state.copyWith(filteredDiamonds: filtered));
  }
}