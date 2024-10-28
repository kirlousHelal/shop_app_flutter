import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/states.dart';

import '../../models/get_favorites_model.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.getFavoritesModel != null,
          builder: (context) {
            return favoriteBuilder(
                cubit: cubit, products: cubit.getFavoritesModel?.data?.data);
          },
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: defaultColor,
            ),
          ),
        );
      },
    );
  }

  Widget favoriteBuilder(
      {required ShopCubit cubit, required List<Products>? products}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          controller: cubit.favoriteScrollController,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Row(
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                      image: NetworkImage('${products?[index].product?.image}'),
                      // fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                    ),
                    if (products?[index].product?.discount != 0)
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 10),
                        color: Colors.red,
                        child: const Text("DISCOUNT",
                            style: TextStyle(color: Colors.white)),
                      )
                  ],
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${products?[index].product?.name}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            "${products?[index].product?.price}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          if (products?[index].product?.discount != 0)
                            Text(
                              "${products?[index].product?.oldPrice}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                ShopCubit.get(context).postFavoritesData(
                                    productID: products?[index].product?.id);
                              },
                              icon: Icon(
                                ShopCubit.get(context).favorites[
                                            products?[index].product?.id] ??
                                        false
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: defaultColor,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => Row(
                children: [
                  const SizedBox(
                    width: 130,
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
          itemCount: products?.length ?? 0),
    );
  }
}
