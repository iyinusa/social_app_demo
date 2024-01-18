// models/search_parameters_model.dart
class SearchParametersModel {
  final String location; // or postcode
  final double radius;
  final List businessType;

  SearchParametersModel({
    required this.location,
    required this.radius,
    required this.businessType,
  });
}
