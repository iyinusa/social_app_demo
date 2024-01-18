// controllers/search_controller.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding_resolver/geocoding_resolver.dart';
import '../models/search_parameters_model.dart';

class SearchesController extends ChangeNotifier {
  List<dynamic> businessNames = [];

  /// The function `searchBusinesses` uses the Google Places API to search for nearby businesses based
  /// on specified parameters and returns a list of business names, addresses, and ratings.
  ///
  /// Args:
  ///   parameters (SearchParametersModel): The `parameters` object is of type `SearchParametersModel`
  /// and contains the following properties:
  ///
  /// Returns:
  ///   a list of business names, addresses, and ratings.
  searchBusinesses(SearchParametersModel parameters) async {
    try {
      // Replace YOUR_API_KEY with your actual Google Cloud API key.
      // Make sure to enable the Places API for your project in the Google Cloud Console.
      const apiKey = 'AIzaSyDzKO2fDhNHKetUSX0jXXXXXXXXXXXXXXX';
      const endpoint = 'https://places.googleapis.com/v1/places:searchNearby';

      // get Coordinate of location/postcode
      final loc = await getCoordinate(parameters.location);

      if (loc != null) {
        final response = await http.post(
          Uri.parse(endpoint),
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-Api-Key': apiKey,
            'X-Goog-FieldMask': '*',
          },
          body: json.encode({
            "includedTypes": parameters.businessType,
            "maxResultCount": 10,
            "locationRestriction": {
              "circle": {
                "center": {
                  "latitude": loc.latitude,
                  "longitude": loc.longitude,
                },
                "radius": parameters.radius,
              }
            },
            "rankPreference": "DISTANCE"
          }),
        );

        if (response.statusCode == 200) {
          businessNames = [];
          final Map<String, dynamic> data = json.decode(response.body);

          for (var result in data['places']) {
            businessNames.add({
              'name': result['displayName']['text'],
              'address': result['formattedAddress'],
              'rating': result['rating'] ?? 0,
            });
          }

          return businessNames;
        } else {
          print('Error: ${response.body}');
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  /// The function `getCoordinate()` uses a GeoCoder to retrieve the first suggested address for a given
  /// address string.
  ///
  /// Returns:
  ///   The function `getCoordinate()` is returning the first element in the list of `LookupAddress`
  /// objects.
  getCoordinate(address) async {
    GeoCoder geoCoder = GeoCoder();
    List<LookupAddress> addresses =
        await geoCoder.getAddressSuggestions(address: address);

    return addresses.first;
  }
}
