
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/diamond.dart';


abstract class ResultEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDiamonds extends ResultEvent {
  final List<Diamond> diamonds;

  LoadDiamonds(this.diamonds);

  @override
  List<Object?> get props => [diamonds];
}

class SortByPrice extends ResultEvent {
  final bool ascending;

  SortByPrice(this.ascending);

  @override
  List<Object?> get props => [ascending];
}

class SortByCarat extends ResultEvent {
  final bool ascending;

  SortByCarat(this.ascending);

  @override
  List<Object?> get props => [ascending];
}

// State
class ResultState extends Equatable {
  final List<Diamond> diamonds;

  const ResultState(this.diamonds);

  @override
  List<Object?> get props => [diamonds];
}

// BLoC
class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(const ResultState([])) {
    on<LoadDiamonds>(_onLoadDiamonds);
    on<SortByPrice>(_onSortByPrice);
    on<SortByCarat>(_onSortByCarat);
  }

  void _onLoadDiamonds(LoadDiamonds event, Emitter<ResultState> emit) {
    emit(ResultState(event.diamonds));
  }

  void _onSortByPrice(SortByPrice event, Emitter<ResultState> emit) {
    final sorted = List<Diamond>.from(state.diamonds);
    sorted.sort((a, b) => event.ascending
        ? a.finalAmount.compareTo(b.finalAmount)
        : b.finalAmount.compareTo(a.finalAmount));
    emit(ResultState(sorted));
  }

  void _onSortByCarat(SortByCarat event, Emitter<ResultState> emit) {
    final sorted = List<Diamond>.from(state.diamonds);
    sorted.sort((a, b) => event.ascending
        ? a.carat.compareTo(b.carat)
        : b.carat.compareTo(a.carat));
    emit(ResultState(sorted));
  }
}