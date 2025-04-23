import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:prodex/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:prodex/utils/constants/image.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget(
      {super.key,
      required this.cardHeight,
      required this.image,
      required this.title,
      required this.price,
      required this.rating,
      required this.onTap});

  final double? cardHeight;
  final String image;
  final String title;
  final double price;
  final double rating;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        height: cardHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: PColors.iconBlack,
                blurRadius: 5,
                spreadRadius: 0,
                offset: Offset(1.5, 0.5))
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: PColors.white,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productThumbnail(context),
                const Spacer(),
                productTitle(context),
                priceSection(context),
                ratingSection(),
                const Spacer(),
                //const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget productThumbnail(BuildContext context) {
    return Container(
        //height: context.height * 0.17,
        constraints: BoxConstraints(minHeight: context.height * 0.15),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: PColors.mainContainer),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                    PImages.errorImage,
                    color: PColors.error,
                  ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: LoadingAnimationWidget.threeRotatingDots(
                      color: PColors.primary,
                      size: 26,
                    ),
                  );
                }
              }),
        ));
  }

  Widget productTitle(BuildContext context) {
    return AutoSizeText(
      title,
      minFontSize: 12,
      maxFontSize: 18,
      maxLines: 2,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: PColors.textPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w500),
    );
  }

  Widget priceSection(BuildContext context) {
    return AutoSizeText(
      '\$$price ',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
          // color: const Color.fromARGB(255, 0, 94, 255),
          fontWeight: FontWeight.w600,
          fontSize: 17),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      minFontSize: 12,
      maxFontSize: 18,
    );
  }

  Widget ratingSection() {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => const Icon(
        Icons.star_rounded,
        color: PColors.primary,
      ),
      unratedColor: PColors.secondary,
      itemCount: 5,
      itemSize: 22.0,
      direction: Axis.horizontal,
    );
  }
}
