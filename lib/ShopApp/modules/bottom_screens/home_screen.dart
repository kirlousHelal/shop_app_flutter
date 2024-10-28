import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_myself/ShopApp/shared/styles/colors.dart';

import '../../models/home_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
            condition: cubit.homeModel != null,
            builder: (context) {
              return homeBuilder(
                  cubit: cubit, model: cubit.homeModel!.data, context: context);
            },
            fallback: (context) => Center(
                  child: CircularProgressIndicator(
                    color: defaultColor,
                  ),
                ));
      },
    );
  }

  Widget homeBuilder(
      {required ShopCubit cubit, required DataModel? model, required context}) {
    return SingleChildScrollView(
      controller: cubit.homeScrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model?.banners!.map(
                (e) {
                  return Image(
                    image: NetworkImage(e.image as String),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  );
                },
              ).toList(),
              options: CarouselOptions(
                initialPage: 0,
                height: 200,
                scrollPhysics: const BouncingScrollPhysics(),
                reverse: false,
                viewportFraction: 1,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlay: true,
              )),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image(
                              image: NetworkImage(
                                "${cubit.getCategoriesModel?.data!.data?[index]?.image}",
                              ),
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                            ),
                            Container(
                              color: Colors.black.withOpacity(0.8),
                              width: 120,
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 5),
                              child: Text(
                                "${cubit.getCategoriesModel?.data!.data?[index]?.name}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemCount:
                          cubit.getCategoriesModel?.data!.data!.length ?? 0,
                    )),
                const SizedBox(height: 30),
                const Text(
                  "New Products",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 30),
                productsBuilder(cubit.homeModel?.data?.products, context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget productsBuilder(List<ProductModel>? products, context) {
    return Container(
      color: Colors.grey[400],
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1 / 1.3,
        children: List.generate(
          products!.length!,
          (index) {
            return Container(
              color: Colors.white,
              child: productItem(products[index], context),
            );
          },
        ),
      ),
    );
  }

  Widget productItem(ProductModel product, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(product.image as String),
              height: 120,
              // fit: BoxFit.cover,
              width: double.infinity,
            ),
            if (product.discount != 0)
              Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                color: Colors.red,
                child: const Text("DISCOUNT",
                    style: TextStyle(color: Colors.white)),
              )
          ],
        ),
        const SizedBox(height: 5),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name as String,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "${product.price}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (product.discount != 0)
                      Text(
                        "${product.oldPrice}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .postFavoritesData(productID: product.id);
                        },
                        icon: Icon(
                          ShopCubit.get(context).favorites[product.id]!
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: defaultColor,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
