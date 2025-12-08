// lib/services/cart_service.dart
import '../models/plant_model.dart';

class CartItem {
  final Plant plant;
  int quantity;

  CartItem({
    required this.plant,
    this.quantity = 1,
  });

  double get totalPrice => plant.price * quantity;
}

class CartService {
  static final CartService _instance = CartService._internal();
  final List<CartItem> _cartItems = [];

  factory CartService() {
    return _instance;
  }

  CartService._internal();

  List<CartItem> get cartItems => _cartItems;

  void addItem(Plant plant) {
    final existingItem = _cartItems.firstWhere(
      (item) => item.plant.id == plant.id,
      orElse: () => CartItem(plant: plant),
    );

    if (_cartItems.contains(existingItem)) {
      existingItem.quantity++;
    } else {
      _cartItems.add(existingItem);
    }
  }

  void removeItem(int plantId) {
    _cartItems.removeWhere((item) => item.plant.id == plantId);
  }

  void updateQuantity(int plantId, int quantity) {
    final item = _cartItems.firstWhere((item) => item.plant.id == plantId);
    if (quantity > 0) {
      item.quantity = quantity;
    } else {
      removeItem(plantId);
    }
  }

  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get itemCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void clearCart() {
    _cartItems.clear();
  }
}
