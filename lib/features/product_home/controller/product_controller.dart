import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodex/core/model/rest_response.dart';
import 'package:prodex/features/product_home/model/product_model.dart';
import 'package:prodex/features/product_home/service/product_service.dart';

class ProductController extends GetxController {
  final ProductService productService = ProductService();

  var isPagination = false.obs;
  int pageNo = 0;

  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs;

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  final scrollController = ScrollController();

  var isFilterApplied = false.obs;

  var products = <ProductModel>[].obs;
  var categoryList = <String>[].obs;
  var selectedCategories = <String>[].obs;
  var filteredProducts = <ProductModel>[].obs;

  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
  final tagController = TextEditingController();
  var tagList = <String>[].obs;
  var filteredCategories = <String>[].obs;

  var uiProductsList = <ProductModel>[].obs;
  var productSuggestionList = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    getCategoriesList();
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore.value &&
        hasMore.value &&
        !isFilterApplied.value) {
      isPagination(true);
      isLoadingMore(true);
      //await Future.delayed(Duration(seconds: 1));
      fetchProducts();
    }
  }

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  void resetFilter() {
    isFilterApplied(false);
    filteredProducts.clear();
    clearFilterData();
    Get.back();
  }

  void submitFilters() async {
    final minPrice = double.tryParse(minPriceController.text);
    final maxPrice = double.tryParse(maxPriceController.text);

    if (minPrice != null && maxPrice != null) {
      if (minPrice == 0.0 && maxPrice == 0.0) {
        Get.snackbar('Validation', 'Please enter a valid min or max price.');
        return;
      }

      if (maxPrice != 0.0 && maxPrice < minPrice) {
        Get.snackbar(
            'Validation', 'Max price should be greater than min price.');
        return;
      }
    }

    filteredCategories.value = selectedCategories;

    final tagsInput = tagController.text;
    tagList.value = tagsInput
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    await applyProductFilters().then((val) {
      isFilterApplied(true);
      Get.back();
    });
  }

  Future<List<ProductModel>> productSuggestionListFn(String query) async {
    productSuggestionList.clear();
    productSuggestionList.addAll(products.where((suggestion) =>
        suggestion.title.toLowerCase().startsWith(query.toLowerCase())));
    return productSuggestionList;
  }

  Future<void> applyProductFilters() async {
    final minPrice = double.tryParse(minPriceController.text) ?? 0.0;
    final maxPrice =
        double.tryParse(maxPriceController.text) ?? double.infinity;

    var result = products.where((product) {
      // Category filter
      final categoryMatches = filteredCategories.isEmpty ||
          filteredCategories.contains(product.category);

      // Price filter
      final priceMatches =
          product.price >= minPrice && product.price <= maxPrice;

      // Tag filter (case insensitive)
      final tagsLower = product.tags.map((tag) => tag.toLowerCase()).toList();
      final tagMatches = tagList.isEmpty ||
          tagList.any((tag) => tagsLower.contains(tag.toLowerCase()));

      return categoryMatches && priceMatches && tagMatches;
    }).toList();

    filteredProducts.value = result;
  }

  List<ProductModel> get uiProductList {
    if (isFilterApplied.value) {
      return filteredProducts;
    } else {
      return products;
    }
  }

  void clearFilterData() {
    selectedCategories.clear();
    minPriceController.clear();
    maxPriceController.clear();
    tagController.clear();
  }

  void fetchProducts() async {
    isLoading.value = true;
    final RestResponse response = await productService.getAllProducts(pageNo);
    if (response.apiSuccess) {
      if (!isPagination.value) {
        products.clear();
      }
      hasMore.value = (response.data['products'] as List).isNotEmpty;
      if (hasMore.value) {
        pageNo++;
      }
      response.data['products'].forEach((element) {
        products.add(ProductModel.fromJson(element));
      });
      isLoading.value = false;
      isLoadingMore(false);
    } else {
      isLoading(false);
      isLoadingMore(false);
      Get.snackbar('Error', response.message ?? 'Failed to load products');
    }
  }

  void getCategoriesList() async {
    isLoading.value = true;
    final RestResponse response = await productService.getCategoriesList();
    if (response.apiSuccess) {
      isLoading.value = false;
      if (response.data is List && (response.data as List).isNotEmpty) {
        categoryList.addAll(List<String>.from(response.data));
      }
    } else {
      isLoading(false);
      Get.snackbar('Error', response.message ?? 'Failed to load products');
    }
  }
}
