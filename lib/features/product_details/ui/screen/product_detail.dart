import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:prodex/features/product_home/model/product_model.dart';
import 'package:prodex/utils/constants/colors.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? detailArgs = Get.arguments;
    final ProductModel productObj = detailArgs?['product'];

    return Scaffold(
      appBar: productDetailAppbar(context),
      body: Container(
        margin: EdgeInsets.only(
          top: context.height * 0.02,
          left: context.width * 0.03,
          right: context.width * 0.03,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail Image
              Container(
                height: context.height * 0.35,
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: PColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 6,
                      spreadRadius: 6,
                      offset: const Offset(1, 2),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  productObj.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                productObj.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),

              // Description
              Text(
                productObj.description,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),

              // Category
              Text(
                'Category: ${productObj.category}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),

              // Tags
              Text(
                'Tags: ${productObj.tags.map((tag) => '#$tag').join(' ')}',
                style: Theme.of(context).textTheme.labelLarge,
              ),

              const SizedBox(height: 8),
              // Rating
              Row(
                children: [
                  RatingBarIndicator(
                    rating: productObj.rating,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star_rounded,
                      color: PColors.primary,
                    ),
                    unratedColor: PColors.secondary,
                    itemCount: 5,
                    itemSize: 22.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    productObj.rating.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Review Section Heading
              Text(
                'Reviews',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              // Reviews List
              ...productObj.reviews.map((review) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingBarIndicator(
                            rating: review.rating.toDouble(),
                            itemBuilder: (context, index) => Icon(
                              index < review.rating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                            ),
                            unratedColor: Colors.amber,
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),

                          const SizedBox(height: 8),

                          // Comment Text
                          Text(
                            review.comment,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),

                          // Reviewer Name and Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '- ${review.reviewerName}',
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                              Text(
                                '${review.date.day}/${review.date.month}/${review.date.year}',
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  AppBar productDetailAppbar(BuildContext context) {
    return AppBar(
      title: Text(
        'Product Detail',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
      automaticallyImplyLeading: false,
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Back to home",
              style: TextStyle(color: PColors.primary),
            ))
      ],
      centerTitle: false,
      elevation: 4,
      backgroundColor: PColors.white,
      surfaceTintColor: PColors.white,
      shadowColor: Colors.black.withOpacity(0.55),
    );
  }
}
