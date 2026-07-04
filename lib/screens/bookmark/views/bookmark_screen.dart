import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopeasy/components/product/product_card.dart';
import 'package:shopeasy/models/product_model.dart';
import 'package:shopeasy/route/route_constants.dart';
import '../../../../features/cart_wishlist/presentation/controllers/cart_wishlist_controller.dart';
import '../../../constants.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartWishlistController.instance;

    return Scaffold(
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator(color: primaryColor));
          }

          final items = controller.wishlistItems;

          if (items.isEmpty) {
            return Center(
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
                        "assets/icons/Bookmark.svg",
                        colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    Text(
                      "Your wishlist is empty",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Text(
                      "Bookmark products you love to save them here for quick access later.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                  vertical: defaultPadding,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: defaultPadding,
                    crossAxisSpacing: defaultPadding,
                    childAspectRatio: 0.66,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final item = items[index];
                      return ProductCard(
                        image: item.image,
                        brandName: item.brand,
                        title: item.title,
                        price: item.price,
                        priceAfetDiscount: item.priceAfterDiscount,
                        dicountpercent: item.discountPercent,
                        press: () {
                          // Map WishlistItem to ProductModel for details screen
                          final productModel = ProductModel(
                            image: item.image,
                            title: item.title,
                            brandName: item.brand,
                            price: item.price,
                            priceAfetDiscount: item.priceAfterDiscount,
                            dicountpercent: item.discountPercent,
                          );
                          Navigator.pushNamed(
                            context,
                            productDetailsScreenRoute,
                            arguments: {
                              'product': productModel,
                              'isAvailable': true,
                            },
                          );
                        },
                      );
                    },
                    childCount: items.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
