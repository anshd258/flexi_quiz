import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexi_quiz/core/extension/buildcontext.dart';
import 'package:flexi_quiz/core/utility/discount_calculator.dart';
import 'package:flexi_quiz/data/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool discount;

  const ProductCard({required this.product, super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorSchema.secondary,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: product.thumbnail!,
                height: 125,
                width: double.infinity,
                fit: BoxFit.fitHeight,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Padding(
                  padding: const EdgeInsets.all(24),
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress),
                ),
                errorWidget: (context, url, error) => const Padding(
                  padding: EdgeInsets.all(24),
                  child: Icon(Icons.error),
                ),
              ),
            ),
            const Gap(2),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleSmall,
                      ),
                      const Gap(4),
                      Text(
                        product.description ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  RichText(
                      maxLines: 2,
                      text: TextSpan(
                          text: "\$${product.price?.round()}",
                          style: discount
                              ? context.textTheme.labelSmall?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Color(0xFFCED3DC),
                                  decorationThickness: 1)
                              : context.textTheme.labelSmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF303F60),
                                ),
                          children: discount
                              ? [
                                  TextSpan(
                                    text:
                                        " \$${deductPercentage(product.price ?? 0.0, product.discountPercentage ?? 0.0).round()}  ",
                                    style:
                                        context.textTheme.labelSmall?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: Color(0xFF303F60),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${product.discountPercentage}% off ",
                                    style:
                                        context.textTheme.labelSmall?.copyWith(
                                      color: Color.fromARGB(255, 74, 241, 118),
                                    ),
                                  )
                                ]
                              : null)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  
}
