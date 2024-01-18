import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'colors.dart';

class Utils {
  /// The `navTo` function is used to navigate to a new page in a Dart application using the `Navigator`
  /// class.
  ///
  /// Args:
  ///   context: The context parameter is a reference to the current build context. It is typically
  /// passed down from the parent widget to its child widgets. The context provides access to various
  /// resources and services, such as theme, localization, and navigation.
  ///   page: The "page" parameter is the widget or screen that you want to navigate to. It can be any
  /// widget that extends the Flutter "Widget" class, such as a StatelessWidget or a StatefulWidget.
  navTo(context, page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  /// The function `businessTypes()` returns a list of dictionaries containing names and slugs of
  /// various business types.
  ///
  /// Returns:
  ///   The businessTypes() function returns an array of objects. Each object represents a business type
  /// and has two properties: 'name' and 'slug'. The 'name' property represents the name of the business
  /// type, while the 'slug' property represents a unique identifier for the business type.
  businessTypes() {
    return [
      {'name': 'Schools', 'slug': 'school'},
      {'name': 'Libraries', 'slug': 'library'},
      {'name': 'Amusement Centres', 'slug': 'amusement_center'},
      {'name': 'Event Venues', 'slug': 'event_venue'},
      {'name': 'ATM', 'slug': 'atm'},
      {'name': 'Banks', 'slug': 'bank'},
      {'name': 'Restaurant', 'slug': 'restaurant'},
      {'name': 'Coffee Shops', 'slug': 'coffee_shop'},
      {'name': 'Post Office', 'slug': 'post_office'},
      {'name': 'Hospitals', 'slug': 'hospital'},
      {'name': 'Hotels', 'slug': 'hotel'},
      {'name': 'Barber Shops', 'slug': 'barber_shop'},
      {'name': 'Travel Agency', 'slug': 'travel_agency'},
      {'name': 'Shopping Malls', 'slug': 'shopping_mall'},
      {'name': 'Train Stations', 'slug': 'train_station'},
      {'name': 'Bus Stop', 'slug': 'bus_stop'},
      //// add more business types
      // {'name': '', 'slug': ''},
    ];
  }

  /// The function "rating" returns a row of star icons, with the number of filled stars determined by
  /// the "value" parameter.
  ///
  /// Args:
  ///   value: The "value" parameter in the "rating" function represents the rating value that you want
  /// to display. It is used to determine how many filled stars should be displayed based on the rating
  /// value.
  ///
  /// Returns:
  ///   a Row widget with a list of Icons. The Icons are displayed as star outlines. The color of each
  /// star is determined by the value parameter. If the value is greater than or equal to the index of
  /// the star, the star will be colored with the appBlueColor. Otherwise, the star will be left with
  /// its default color.
  rating(value) {
    return Row(
      children: [
        for (int i = 1; i <= 5; i++)
          Icon(
            Icons.star_outline,
            size: 12,
            color: value >= i ? appBlueColor : null,
          ),
      ],
    );
  }

  /// The `launchMap` function launches a map application with a query for the specified address.
  ///
  /// Args:
  ///   addr: The `addr` parameter is the address that you want to search for on the map.
  launchMap(addr) async {
    await MapsLauncher.launchQuery(addr);
  }
}
