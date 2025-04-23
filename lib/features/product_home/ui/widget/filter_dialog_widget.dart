import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodex/features/product_home/controller/product_controller.dart';
import 'package:prodex/utils/constants/colors.dart';

class FilterDialogWidget extends StatelessWidget {
  FilterDialogWidget({
    super.key,
  });

  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
        title: Text(
          'Filter',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: !controller.isLoading.value
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      return Wrap(
                        spacing: 4.0,
                        runSpacing: 2.0,
                        children: controller.categoryList.map((category) {
                          final isSelected =
                              controller.selectedCategories.contains(category);
                          return FilterChip(
                            label: Text(
                              category,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            labelPadding: const EdgeInsets.all(1),
                            selected: isSelected,
                            onSelected: (_) =>
                                controller.toggleCategory(category),
                            selectedColor: PColors.primary,
                          );
                        }).toList(),
                      );
                    }),
                    const SizedBox(height: 10),
                    Text(
                      'Price',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.minPriceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Min',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: controller.maxPriceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Max',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text.rich(
                      TextSpan(children: [
                        const TextSpan(text: 'Tags'),
                        TextSpan(
                          text: '(comma-separated)',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 10),
                        )
                      ]),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    TextField(
                      controller: controller.tagController,
                      decoration: InputDecoration(
                          hintText: 'tag1, tag2, tag3',
                          filled: true,
                          fillColor: Colors.grey.shade300),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: controller.resetFilter,
                child: const Text('Reset'),
              ),
              ElevatedButton(
                onPressed: controller.submitFilters,
                child: const Text('Submit'),
              ),
            ],
          )
        ],
      );
    });
  }
}
