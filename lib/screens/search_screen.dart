// screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app_demo/utils/colors.dart';
import 'package:social_app_demo/utils/utils.dart';
import '../controllers/search_controller.dart';
import '../models/search_parameters_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> businesses = [];
  final List businessTypes = Utils().businessTypes();

  String location = '';
  double radius = 10000; // default radius
  List<String> businessType = [];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final searchController = Provider.of<SearchesController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby Businesses"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                // location
                Flexible(
                  child: TextField(
                    onChanged: (value) => location = value,
                    decoration: const InputDecoration(
                        labelText: 'Location or Postcode'),
                  ),
                ),
                const SizedBox(width: 10),

                // radius
                Flexible(
                  child: TextField(
                    onChanged: (value) {
                      try {
                        radius = double.parse(value);
                      } catch (e) {
                        // Handle invalid input
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Radius'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                // business types
                SizedBox(
                  width: MediaQuery.of(context).size.width - 125,
                  height: 35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: businessTypes.length,
                    itemBuilder: (c, i) {
                      final bType = businessTypes[i];
                      return _typeWidget(bType);
                    },
                  ),
                ),
                const SizedBox(width: 10),

                // search button
                Flexible(
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      SearchParametersModel searchParameters =
                          SearchParametersModel(
                        location: location,
                        radius: radius,
                        businessType: businessType,
                      );

                      final businessesData = await searchController
                          .searchBusinesses(searchParameters);

                      setState(() {
                        businesses = businessesData;
                        isLoading = false;
                      });
                    },
                    child: const Text("Search"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // list businesses
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : businesses.isEmpty
                      ? const Center(
                          child: Text(
                            'No business returned',
                            style: TextStyle(color: appLightGrayColor),
                          ),
                        )
                      : ListView.builder(
                          itemCount: businesses.length,
                          itemBuilder: (c, i) {
                            return _business(businesses[i]);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  // business type widget
  _typeWidget(item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (businessType.contains(item['slug'])) {
            businessType.remove(item['slug']);
          } else {
            businessType.add(item['slug']);
          }
        });
      },
      child: Container(
        height: 35,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: businessType.contains(item['slug'])
              ? appLightGrayColor
              : appWhiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: appGrayColor),
        ),
        child: Row(
          children: [
            // selected business type indicator
            businessType.contains(item['slug'])
                ? const SizedBox(
                    width: 15,
                    child: Icon(
                      Icons.check,
                      size: 10,
                      color: appGreenColor,
                    ),
                  )
                : Container(),

            // business type name and tap effect
            Text(
              item['name'],
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // businesses widget
  _business(item) {
    return GestureDetector(
      onTap: () => Utils().launchMap(item['address']),
      child: Container(
        // margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: appWhiteColor,
          border: Border(bottom: BorderSide(color: appLightGrayColor)),
        ),
        child: Row(
          children: [
            // name and address
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item['address'],
                    style: const TextStyle(fontSize: 12, color: appGrayColor),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

            // ratings
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item['rating'].toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '/5',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Utils().rating(item['rating']),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
