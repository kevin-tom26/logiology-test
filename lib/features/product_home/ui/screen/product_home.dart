import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodex/features/product_home/controller/product_controller.dart';
import 'package:prodex/features/product_home/ui/widget/auto_complete_search.dart';
import 'package:prodex/features/product_home/ui/widget/filter_dialog_widget.dart';
import 'package:prodex/features/product_home/ui/widget/product_card_widget.dart';
import 'package:prodex/routes.dart';
import 'package:prodex/utils/constants/colors.dart';
import 'package:prodex/utils/constants/image.dart';
import 'package:prodex/utils/constants/text_string.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final ProductController controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: productAppbar(context),
      body: GestureDetector(
        onTap: () => controller.searchFocusNode.unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Container(
          margin: EdgeInsets.only(
            top: context.height * 0.01,
            left: context.width * 0.03,
            right: context.width * 0.03,
          ),
          child: Column(
            children: [
              filterSection(context),
              productSection(context),
            ],
          ),
        ),
      ),
    );
  }

  //--Product Appbar
  AppBar productAppbar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(PImages.logoSmall, scale: 2.3),
          Text(
            ' ${PStrings.appName}',
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.profile);
            },
            icon: const Icon(Icons.person_2_outlined))
      ],
      centerTitle: false,
      elevation: 4,
      backgroundColor: PColors.white,
      surfaceTintColor: PColors.white,
      shadowColor: Colors.black.withOpacity(0.55),
    );
  }

  //--Product Filter section
  Widget filterSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Expanded(
            child: AutoCompleteSearch(),
          ),
          GestureDetector(
            onTap: () {
              showFilterDialog(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: PColors.primary,
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(left: 8),
              child: const Icon(
                Icons.filter_alt_rounded,
                color: PColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  //--Product section
  Widget productSection(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value && !controller.isLoadingMore.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.uiProductList.isEmpty) {
          return Center(
            child: Text(
              "No Product Available!",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        return Stack(
          children: [
            GridView.builder(
              padding:
                  const EdgeInsets.only(left: 6, right: 6, top: 10, bottom: 20),
              controller: controller.scrollController,
              itemCount: controller.uiProductList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                final product = controller.uiProductList[index];
                return ProductCardWidget(
                    cardHeight: null,
                    image: product.thumbnail,
                    title: product.title,
                    price: product.price,
                    rating: product.rating,
                    onTap: () {
                      controller.searchFocusNode.unfocus();
                      Get.toNamed(AppRoutes.productDetail,
                          arguments: {'product': product});
                    });
              },
            ),
            if (controller.isLoadingMore.value)
              const Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Center(
                    child: CircularProgressIndicator(
                  color: PColors.primary,
                )),
              ),
          ],
        );
      }),
    );
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return FilterDialogWidget();
      },
    );
  }
}
