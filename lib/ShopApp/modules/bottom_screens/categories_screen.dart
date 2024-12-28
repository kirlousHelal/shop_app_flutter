import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/states.dart';

import '../../models/get_categories_model.dart';
import '../../shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.getCategoriesModel != null,
          builder: (context) {
            return categoryBuilder(
                cubit: cubit, categories: cubit.getCategoriesModel?.data?.data);
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

  Widget categoryBuilder({
    required ShopCubit cubit,
    required List<Category?>? categories,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          controller: cubit.categoryScrollController,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return categoryItem(model: categories[index]!);
          },
          separatorBuilder: (context, index) => Row(
                children: [
                  const SizedBox(
                    width: 120,
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
          itemCount: categories!.length),
    );
  }

  Widget categoryItem({required Category model}) => Row(
        children: [
          Image(
            image: NetworkImage(model.image as String),
            fit: BoxFit.cover,
            height: 120,
            width: 120,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              model.name as String,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded),
        ],
      );
}
