import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_myself/ShopApp/models/post_search_model.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text("Search"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultTextForm(
                  controller: searchController,
                  label: "Search",
                  prefixIcon: const Icon(Icons.search_rounded),
                  onChanged: (value) {
                    cubit.postSearchData(text: value);
                  },
                  validator: (value) => null,
                ),
                const SizedBox(
                  height: 15,
                ),
                if (state is SearchPostLoadingState)
                  LinearProgressIndicator(
                    color: defaultColor,
                    backgroundColor: Colors.white,
                  ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit.postSearchModel != null,
                    builder: (context) {
                      return searchBuilder(
                        cubit: cubit,
                        products: cubit.postSearchModel?.data!.data,
                      );
                    },
                    fallback: (context) => const Center(
                      child: Text(
                        "Search For Something...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget searchBuilder({
    required ShopCubit cubit,
    required List<SearchData>? products,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        controller: cubit.searchScrollController,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage('${products?[index].image}'),
                    height: 120,
                    width: 120,
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${products?[index].name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          '${products?[index].price}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).postFavoritesData(
                              productID: products![index].id!,
                            );
                          },
                          icon: Icon(
                            ShopCubit.get(context)
                                        .favorites[products?[index].id] ??
                                    false
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: defaultColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => Row(
          children: [
            const SizedBox(width: 130, height: 10),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        itemCount: products?.length ?? 0,
      ),
    );
  }
}
