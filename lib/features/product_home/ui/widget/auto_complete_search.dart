import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:prodex/features/product_home/controller/product_controller.dart';
import 'package:prodex/features/product_home/model/product_model.dart';
import 'package:prodex/routes.dart';
import 'package:prodex/utils/constants/colors.dart';

class AutoCompleteSearch extends StatelessWidget {
  AutoCompleteSearch({super.key});

  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<ProductModel>(
      controller: controller.searchController,
      focusNode: controller.searchFocusNode,
      suggestionsCallback: (search) {
        if (search.isNotEmpty) {
          return controller.productSuggestionListFn(search);
        } else {
          return [];
        }
      },
      builder: (context, productController, searchFocusNode) {
        return searchTextField(
          context,
          controller: productController,
          focusNode: searchFocusNode,
          onTap: () {
            if (productController.text.isEmpty) {
              Get.snackbar('Error', 'Search field is empty!!');
            } else {
              ProductModel? productItem = controller.products.firstWhereOrNull(
                (productTitle) =>
                    productTitle.title.toLowerCase() ==
                    productController.text.trim().toLowerCase(),
              );
              if (productItem != null) {
                Get.toNamed(AppRoutes.productDetail,
                    arguments: {'product': productItem});
              } else {
                Get.snackbar('No data', 'Searched data not available!!');
              }
            }
            searchFocusNode.unfocus();
          },
        );
      },
      hideOnEmpty: true,
      hideWithKeyboard: false,
      itemBuilder: (context, productItem) {
        return ListTile(
          title: Text(
            productItem.title,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
      constraints: BoxConstraints(maxHeight: context.height * 0.35),
      onSelected: (productItem) {
        Get.toNamed(AppRoutes.productDetail,
            arguments: {'product': productItem});
        controller.searchController.text = productItem.title;
        controller.searchFocusNode.unfocus();
      },
    );
  }

  //--Product search field
  Widget searchTextField(BuildContext context,
      {TextEditingController? controller,
      void Function()? onTap,
      FocusNode? focusNode}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: PColors.textPrimary,
            ),
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
                onTap: onTap, child: const Icon(Icons.search_rounded)),
            hintText: "Search",
            hintStyle: const TextStyle(color: PColors.darkGrey)),
      ),
    );
  }
}
