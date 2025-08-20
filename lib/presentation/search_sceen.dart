import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast_weather/common/assets_string.dart';
import 'package:sky_cast_weather/domain/common_query_model.dart';
import 'package:sky_cast_weather/domain/search_cities_response.dart';
import 'package:sky_cast_weather/presentation/city_detail_screen.dart';
import 'package:sky_cast_weather/presentation/widget/async_value_widget.dart';
import 'package:sky_cast_weather/presentation/widget/custom_search_bar.dart';
import 'package:sky_cast_weather/provider/weather_api_providers.dart';
import 'package:sky_cast_weather/service/responsive_service.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key, this.onSearch});
  final Function(CityData)? onSearch;

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
    final isDesktop = Responsive.isDesktop(context);

    return isDesktop
        ? Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                        color: Colors.transparent, // Changed to transparent
                      ),
                      width: 200,
                      child: TextField(
                        controller: searchController,
                        onChanged: (v) {},
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                          fillColor: Colors
                              .transparent, // Also set fillColor to transparent
                          filled: true, // Enable fillColor
                        ),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ValueListenableBuilder(
                    valueListenable: searchController,
                    builder: (context, value, child) {
                      return value.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchText = searchController.text.trim();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 26,
                              ))
                          : const SizedBox();
                    },
                  )
                ],
              ),
              if (searchController.text.isNotEmpty)
                AsyncValueWidget(
                    
                    loadingChild: Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Lottie.asset(AssetsString.search),
                      ),
                    ),
                    data: ref.watch(searchCitiesProvider(
                        CommonQueryModel(city: _searchText))),
                    child: (data) {
                      final cities = data;
                      return cities.isEmpty
                          ? Center(
                              child: Lottie.asset(AssetsString.location),
                            )
                          : SizedBox(
                              height: 500,
                              child: ListView.builder(
                                  itemCount: cities.length,
                                  itemBuilder: (context, index) {
                                    final city = cities[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: InkWell(
                                        onTap: () {
                                          searchController.clear();
                                          widget.onSearch?.call(city);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              city.name ?? '-',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                    }),
            ],
          )
        : Scaffold(
            backgroundColor: Colors.white70,
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
                   
                    loadingChild: Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Lottie.asset(AssetsString.search),
                      ),
                    ),
                    data: ref.watch(searchCitiesProvider(
                        CommonQueryModel(city: _searchText))),
                    child: (data) {
                      final cities = data;
                      return cities.isEmpty
                          ? const Center(
                              child: Text("No Data..."),
                            )
                          : CustomScrollView(
                              slivers: [
                                SliverPadding(
                                  padding: const EdgeInsets.all(16.0),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        final city = cities[index];
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 4),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CityDetailScreen(
                                                            cityData: city,
                                                          )));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      city.name ?? '-',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.black,
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
