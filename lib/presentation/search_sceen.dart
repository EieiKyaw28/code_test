import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast_weather/common/assets_string.dart';
import 'package:sky_cast_weather/domain/common_query_model.dart';
import 'package:sky_cast_weather/presentation/city_detail_screen.dart';
import 'package:sky_cast_weather/presentation/widget/async_value_widget.dart';
import 'package:sky_cast_weather/presentation/widget/custom_search_bar.dart';
import 'package:sky_cast_weather/provider/weather_api_providers.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  String? _searchText;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          elevation: 4,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: CustomSearchBar(
            controller: searchController,
            onSearch: () {
              setState(() {
                _searchText = searchController.text.trim();
              });
            },
          ),
          centerTitle: true,
        ),
        body: _searchText == null
            ? Center(
                child: Lottie.asset(AssetsString.location),
              )
            : AsyncValueWidget(
                onConfirm: () {
                  ref.invalidate(searchCitiesProvider);
                },
                loadingChild: Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Lottie.asset(AssetsString.search),
                  ),
                ),
                data: ref.watch(
                    searchCitiesProvider(CommonQueryModel(city: _searchText))),
                child: (data) {
                  final cities = data;
                  return CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(16.0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final city = cities[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CityDetailScreen(
                                                  cityName: city.name,
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            city.name ?? '-',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(1, 1),
                                                  blurRadius: 2.0,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: cities.length,
                          ),
                        ),
                      ),
                    ],
                  );
                }));
  }
}
