import 'package:fluttermvvp_week7/data/network/network_api_services.dart';
import 'package:fluttermvvp_week7/model/city.dart';
import 'package:fluttermvvp_week7/model/costs/costs.dart';
import 'package:fluttermvvp_week7/model/model.dart';

class HomeRepository {
  final _apiServices = NetworkApiServices();

  Future<List<Province>> fetchProvinceList() async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/province');
      List<Province> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => Province.fromJson(e))
            .toList();
      }
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<List<City>> fetchCityList(var provId) async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/city');
      List<City> result = [];
      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => City.fromJson(e))
            .toList();
      }
      List<City> selectedCities = [];
      for (var c in result) {
        if (c.provinceId == provId) {
          selectedCities.add(c);
        }
      }
      return selectedCities;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Costs>> fetchCostList(
      String selectedProvinceOrigin,
      String selectedCityOrigin,
      String selectedProvinceDestination,
      String selectedCityDestination,
      int itemWeight,
      String selectedCourier) async {
    try {
      dynamic response = await _apiServices.postApiResponse(
        '/starter/cost',
        {
          "origin": selectedCityOrigin,
          "destination": selectedCityDestination,
          "weight": itemWeight,
          "courier": selectedCourier.toLowerCase(),
        },
      );
      if (response['rajaongkir']['status']['code'] != 200) {
        throw Exception(
            "Error: ${response['rajaongkir']['status']['description']}");
      }
      return (response['rajaongkir']['results'] as List)
          .expand((result) => (result['costs'] as List)
              .map((cost) => Costs.fromJson(cost as Map<String, dynamic>)))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
