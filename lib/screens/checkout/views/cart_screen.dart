import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopeasy/constants.dart';
import '../../../../features/cart_wishlist/presentation/controllers/cart_wishlist_controller.dart';
import '../../../../features/cart_wishlist/domain/models/cart_item.dart';
import 'package:shopeasy/screens/product/views/components/product_quantity.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _couponController = TextEditingController();
  final CartWishlistController _controller = CartWishlistController.instance;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _applyCoupon() {
    if (_couponController.text.isEmpty) return;
    final success = _controller.applyCoupon(_couponController.text);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Coupon '${_couponController.text.toUpperCase()}' applied!"),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Coupon Code. Try 'FLUTTER10', 'WELCOME15', or 'SUPER20'"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _handleCheckout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            Text("Order Confirmed", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          "Your payment was successful and your order has been placed. Thank you for shopping with us!",
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(context);
              _controller.clearCart();
            },
            child: const Text("Continue Shopping", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        if (_controller.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final items = _controller.cartItems;

        if (items.isEmpty) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding * 1.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Bag.svg",
                        colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    Text(
                      "Your cart is empty",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Text(
                      "Explore our popular categories and add products to your cart to start shopping.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(defaultPadding),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = items[index];
                      return _CartItemRow(item: item, controller: _controller);
                    },
                    childCount: items.length,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const SizedBox(height: defaultPadding / 2),
                      Text(
                        "Have a coupon code?",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _couponController,
                              textCapitalization: TextCapitalization.characters,
                              decoration: InputDecoration(
                                hintText: "e.g., FLUTTER10, WELCOME15",
                                filled: true,
                                fillColor: Theme.of(context).brightness == Brightness.light
                                    ? Colors.grey.shade100
                                    : const Color(0xFF1E1E24),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding,
                                  vertical: defaultPadding / 1.5,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: _controller.activeCoupon.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear, color: Colors.grey),
                                        onPressed: () {
                                          _couponController.clear();
                                          _controller.removeCoupon();
                                        },
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(width: defaultPadding / 2),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding,
                                vertical: defaultPadding / 1.1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            onPressed: _applyCoupon,
                            child: const Text("Apply", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      if (_controller.activeCoupon.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            "Active Coupon: ${_controller.activeCoupon} (${(_controller.couponDiscountPercent * 100).toInt()}% OFF)",
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                      ],
                      const SizedBox(height: defaultPadding),
                      _PricingBreakdownCard(controller: _controller),
                      const SizedBox(height: defaultPadding),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          onPressed: _handleCheckout,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Proceed to Checkout (\$${_controller.grandTotal.toStringAsFixed(2)})",
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CartItemRow extends StatelessWidget {
  final CartItem item;
  final CartWishlistController controller;

  const _CartItemRow({required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                item.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: defaultPadding / 2),
          // Info Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.brand.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    // Color Circle indicator
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Color(item.selectedColor),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 1,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Size: ${item.selectedSize}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price
                    Row(
                      children: [
                        Text(
                          "\$${item.effectivePrice.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (item.priceAfterDiscount != null) ...[
                          const SizedBox(width: 6),
                          Text(
                            "\$${item.price.toStringAsFixed(2)}",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                        ]
                      ],
                    ),
                    // Quantity Control
                    ProductQuantity(
                      numOfItem: item.quantity,
                      onIncrement: () {
                        controller.updateCartQuantity(item.id!, item.quantity + 1);
                      },
                      onDecrement: () {
                        if (item.quantity > 1) {
                          controller.updateCartQuantity(item.id!, item.quantity - 1);
                        } else {
                          controller.removeFromCart(item.id!);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Delete Button
          IconButton(
            alignment: Alignment.topRight,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
            onPressed: () {
              controller.removeFromCart(item.id!);
            },
          ),
        ],
      ),
    );
  }
}

class _PricingBreakdownCard extends StatelessWidget {
  final CartWishlistController controller;

  const _PricingBreakdownCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade50
            : const Color(0xFF121216),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          _buildSummaryRow(context, "Subtotal", "\$${controller.subtotal.toStringAsFixed(2)}"),
          if (controller.couponDiscountPercent > 0) ...[
            const SizedBox(height: 10),
            _buildSummaryRow(
              context,
              "Discount (${(controller.couponDiscountPercent * 100).toInt()}% off)",
              "-\$${controller.couponDiscountAmount.toStringAsFixed(2)}",
              valueColor: Colors.green,
            ),
          ],
          const SizedBox(height: 10),
          _buildSummaryRow(context, "Tax (5% Flat)", "\$${controller.taxAmount.toStringAsFixed(2)}"),
          const SizedBox(height: 10),
          _buildSummaryRow(
            context,
            "Shipping Fee",
            controller.shippingFee == 0.0 ? "FREE" : "\$${controller.shippingFee.toStringAsFixed(2)}",
            valueColor: controller.shippingFee == 0.0 ? Colors.green : null,
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          _buildSummaryRow(
            context,
            "Grand Total",
            "\$${controller.grandTotal.toStringAsFixed(2)}",
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
              : Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
        Text(
          value,
          style: isTotal
              ? Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  )
              : Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: valueColor,
                  ),
        ),
      ],
    );
  }
}
