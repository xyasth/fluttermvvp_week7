import 'package:flutter/material.dart';
import 'package:fluttermvvp_week7/data/response/api_response.dart';
import 'package:fluttermvvp_week7/model/city.dart';
import 'package:fluttermvvp_week7/model/costs/costs.dart';
import 'package:fluttermvvp_week7/model/model.dart';
import 'package:fluttermvvp_week7/repository/home_repository.dart';

class HomeViewmodel with ChangeNotifier {
  final _homeRepo = HomeRepository();

  ApiResponse<List<Province>> provinceList = ApiResponse.loading();
  ApiResponse<List<City>> _cityListAsal = ApiResponse.loading();
  ApiResponse<List<City>> _cityListTujuan = ApiResponse.loading();
  ApiResponse<List<City>> _cityList = ApiResponse.loading();
  ApiResponse<List<Costs>> costList = ApiResponse.loading();

  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Province List Methods
  setProvinceList(ApiResponse<List<Province>> response) {
    provinceList = response;
    notifyListeners();
  }

  Future<void> getProvinceList() async {
    setProvinceList(ApiResponse.loading());
    _homeRepo.fetchProvinceList().then((value) {
      setProvinceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProvinceList(ApiResponse.error(error.toString()));
    });
  }

  // City List for Asal Methods
  ApiResponse<List<City>> get cityListAsal => _cityListAsal;

  set cityListAsal(ApiResponse<List<City>> response) {
    _cityListAsal = response;
    notifyListeners();
  }

  Future<void> getCityListAsal(String provId) async {
    cityListAsal = ApiResponse.loading();
    _homeRepo.fetchCityList(provId).then((value) {
      cityListAsal = ApiResponse.completed(value);
    }).onError((error, stackTrace) {
      cityListAsal = ApiResponse.error(error.toString());
    });
  }

  // City List for Tujuan Methods
  ApiResponse<List<City>> get cityListTujuan => _cityListTujuan;

  set cityListTujuan(ApiResponse<List<City>> response) {
    _cityListTujuan = response;
    notifyListeners();
  }

  Future<void> getCityListTujuan(String provId) async {
    cityListTujuan = ApiResponse.loading();
    _homeRepo.fetchCityList(provId).then((value) {
      cityListTujuan = ApiResponse.completed(value);
    }).onError((error, stackTrace) {
      cityListTujuan = ApiResponse.error(error.toString());
    });
  }

  // General City List Methods (for other pages)
  ApiResponse<List<City>> get cityList => _cityList;

  set cityList(ApiResponse<List<City>> response) {
    _cityList = response;
    notifyListeners();
  }

  Future<void> getCityList(String provId) async {
    cityList = ApiResponse.loading();
    _homeRepo.fetchCityList(provId).then((value) {
      cityList = ApiResponse.completed(value);
    }).onError((error, stackTrace) {
      cityList = ApiResponse.error(error.toString());
    });
  }

  // Cost List Methods
  setCostList(ApiResponse<List<Costs>> response) {
    costList = response;
    notifyListeners();
  }

  Future<void> getCostList(
    String selectedProvinceAsal,
    String selectedCityAsal,
    String selectedProvinceTujuan,
    String selectedCityTujuan,
    int itemWeight,
    String selectedCourier,
  ) async {
    setLoading(true);
    _homeRepo
        .fetchCostList(
      selectedProvinceAsal,
      selectedCityAsal,
      selectedProvinceTujuan,
      selectedCityTujuan,
      itemWeight,
      selectedCourier,
    )
        .then((value) {
      setCostList(ApiResponse.completed(value));
      setLoading(false);
    }).onError((error, stackTrace) {
      setCostList(ApiResponse.error(error.toString()));
      setLoading(false);
    });
  }
}
