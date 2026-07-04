import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/components/cart_button.dart';
import 'package:shop/components/custom_modal_bottom_sheet.dart';
import 'package:shop/components/network_image_with_loader.dart';
import 'package:shop/screens/product/views/added_to_cart_message_screen.dart';
import 'package:shop/screens/product/views/components/product_list_tile.dart';
import 'package:shop/screens/product/views/location_permission_store_availability_screen.dart';
import 'package:shop/screens/product/views/size_guide_screen.dart';
import 'package:shop/models/product_model.dart';
import '../../../../features/cart_wishlist/presentation/controllers/cart_wishlist_controller.dart';

import '../../../constants.dart';
import 'components/product_quantity.dart';
import 'components/selected_colors.dart';
import 'components/selected_size.dart';
import 'components/unit_price.dart';

class ProductBuyNowScreen extends StatefulWidget {
  const ProductBuyNowScreen({super.key, this.product});

  final ProductModel? product;

  @override
  State<ProductBuyNowScreen> createState() => _ProductBuyNowScreenState();
}

class _ProductBuyNowScreenState extends State<ProductBuyNowScreen> {
  late ProductModel _activeProduct;
  int _quantity = 1;
  int _selectedColorIndex = 2;
  int _selectedSizeIndex = 1;

  final List<Color> _colors = const [
    Color(0xFFEA6262),
    Color(0xFFB1CC63),
    Color(0xFFFFBF5F),
    Color(0xFF9FE1DD),
    Color(0xFFC482DB),
  ];

  final List<String> _sizes = const ["S", "M", "L", "XL", "XXL"];

  @override
  void initState() {
    super.initState();
    _activeProduct = widget.product ??
        ProductModel(
          image: productDemoImg1,
          title: "Sleeveless Ruffle",
          brandName: "LIPSY LONDON",
          price: 145,
          priceAfetDiscount: 134.7,
          dicountpercent: 7,
        );
  }

  double get _unitPrice => _activeProduct.priceAfetDiscount ?? _activeProduct.price;
  double get _totalPrice => _unitPrice * _quantity;

  @override
  Widget build(BuildContext context) {
    final controller = CartWishlistController.instance;

    return Scaffold(
      bottomNavigationBar: CartButton(
        price: _totalPrice,
        title: "Add to cart",
        subTitle: "Total price",
        press: () async {
          await controller.addToCart(
            title: _activeProduct.title,
            brand: _activeProduct.brandName,
            image: _activeProduct.image,
            price: _activeProduct.price,
            priceAfterDiscount: _activeProduct.priceAfetDiscount,
            discountPercent: _activeProduct.dicountpercent,
            color: _colors[_selectedColorIndex].toARGB32(),
            size: _sizes[_selectedSizeIndex],
            quantity: _quantity,
          );

          if (!context.mounted) return;
          customModalBottomSheet(
            context,
            isDismissible: false,
            child: const AddedToCartMessageScreen(),
          );
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2, vertical: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Expanded(
                  child: Text(
                    _activeProduct.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, _) {
                    final isBookmarked = controller.wishlistItems.any(
                      (item) => item.title == _activeProduct.title,
                    );
                    return IconButton(
                      onPressed: () {
                        controller.toggleWishlist(
                          title: _activeProduct.title,
                          brand: _activeProduct.brandName,
                          image: _activeProduct.image,
                          price: _activeProduct.price,
                          priceAfterDiscount: _activeProduct.priceAfetDiscount,
                          discountPercent: _activeProduct.dicountpercent,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isBookmarked
                                  ? "Removed from Wishlist"
                                  : "Added to Wishlist!",
                            ),
                            backgroundColor: isBookmarked ? Colors.grey : primaryColor,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/Bookmark.svg",
                        colorFilter: ColorFilter.mode(
                          isBookmarked ? primaryColor : Theme.of(context).textTheme.bodyLarge!.color!,
                          BlendMode.srcIn,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: AspectRatio(
                      aspectRatio: 1.05,
                      child: NetworkImageWithLoader(_activeProduct.image),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnitPrice(
                            price: _activeProduct.price * _quantity,
                            priceAfterDiscount: _activeProduct.priceAfetDiscount != null
                                ? _activeProduct.priceAfetDiscount! * _quantity
                                : null,
                          ),
                        ),
                        ProductQuantity(
                          numOfItem: _quantity,
                          onIncrement: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                          onDecrement: () {
                            if (_quantity > 1) {
                              setState(() {
                                _quantity--;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider()),
                SliverToBoxAdapter(
                  child: SelectedColors(
                    colors: _colors,
                    selectedColorIndex: _selectedColorIndex,
                    press: (value) {
                      setState(() {
                        _selectedColorIndex = value;
                      });
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: SelectedSize(
                    sizes: _sizes,
                    selectedIndex: _selectedSizeIndex,
                    press: (value) {
                      setState(() {
                        _selectedSizeIndex = value;
                      });
                    },
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  sliver: ProductListTile(
                    title: "Size guide",
                    svgSrc: "assets/icons/Sizeguid.svg",
                    isShowBottomBorder: true,
                    press: () {
                      customModalBottomSheet(
                        context,
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: const SizeGuideScreen(),
                      );
                    },
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: defaultPadding / 2),
                        Text(
                          "Store pickup availability",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        const Text(
                            "Select a size to check store availability and In-Store pickup options.")
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  sliver: ProductListTile(
                    title: "Check stores",
                    svgSrc: "assets/icons/Stores.svg",
                    isShowBottomBorder: true,
                    press: () {
                      customModalBottomSheet(
                        context,
                        height: MediaQuery.of(context).size.height * 0.92,
                        child: const LocationPermissonStoreAvailabilityScreen(),
                      );
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding))
              ],
            ),
          )
        ],
      ),
    );
  }
}
