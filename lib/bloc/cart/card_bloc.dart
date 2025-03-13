

import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/diamond.dart';

// Events
abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final Diamond diamond;

  AddToCart(this.diamond);

  @override
  List<Object?> get props => [diamond];
}

class RemoveFromCart extends CartEvent {
  final Diamond diamond;

  RemoveFromCart(this.diamond);

  @override
  List<Object?> get props => [diamond];
}

// State
class CartState extends Equatable {
  final List<Diamond> cartItems;
  final double totalCarat;
  final double totalPrice;
  final double averagePrice;
  final double averageDiscount;

  const CartState({
    this.cartItems = const [],
    this.totalCarat = 0.0,
    this.totalPrice = 0.0,
    this.averagePrice = 0.0,
    this.averageDiscount = 0.0,
  });

  @override
  List<Object?> get props => [
        cartItems,
        totalCarat,
        totalPrice,
        averagePrice,
        averageDiscount,
      ];
}

// BLoC
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  Future<void> _saveCart(List<Diamond> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = cartItems.map((diamond) => jsonEncode(diamond.toJson())).toList();
    await prefs.setStringList('cart', cartJson);
  }

  Future<List<Diamond>> _loadCartFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getStringList('cart') ?? [];
    return cartJson
        .map((json) => Diamond.fromJson(jsonDecode(json)))
        .toList();
  }

  CartState _calculateSummary(List<Diamond> cartItems) {
    final totalCarat = cartItems.fold(0.0, (sum, item) => sum + item.carat);
    final totalPrice = cartItems.fold(0.0, (sum, item) => sum + item.finalAmount);
    final averagePrice = cartItems.isEmpty ? 0.0 : totalPrice / cartItems.length;
    final averageDiscount = cartItems.isEmpty
        ? 0.0
        : cartItems.fold(0.0, (sum, item) => sum + item.discount) / cartItems.length;
    return CartState(
      cartItems: cartItems,
      totalCarat: totalCarat,
      totalPrice: totalPrice,
      averagePrice: averagePrice,
      averageDiscount: averageDiscount,
    );
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    final cartItems = await _loadCartFromStorage();
    emit(_calculateSummary(cartItems));
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    final updatedCart = List<Diamond>.from(state.cartItems)..add(event.diamond);
    await _saveCart(updatedCart);
    emit(_calculateSummary(updatedCart));
  }

  Future<void> _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    final updatedCart = List<Diamond>.from(state.cartItems)
      ..removeWhere((item) => item.lotId == event.diamond.lotId);
    await _saveCart(updatedCart);
    emit(_calculateSummary(updatedCart));
  }
}