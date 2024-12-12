import 'package:flutter/material.dart';
import 'package:fluttermvvp_week7/data/response/api_response.dart';
import 'package:fluttermvvp_week7/model/city.dart';
import 'package:fluttermvvp_week7/model/costs/costs.dart';
import 'package:fluttermvvp_week7/model/model.dart';
import 'package:fluttermvvp_week7/repository/home_repository.dart';

class HomeViewmodel with ChangeNotifier {
  final _homeRepo = HomeRepository();

  ApiResponse<List<Province>> provinceList = ApiResponse.loading();
  ApiResponse<List<City>> cityListOrigin = ApiResponse.loading();
  ApiResponse<List<City>> cityListDestination = ApiResponse.loading();
  ApiResponse<List<Costs>> costList = ApiResponse.loading();

  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  setProvinceList(ApiResponse<List<Province>> response) {
    provinceList = response;
    notifyListeners();
  }

  setCityListOrigin(ApiResponse<List<City>> response) {
    cityListOrigin = response;
    notifyListeners();
  }

  setCityListDestination(ApiResponse<List<City>> response) {
    cityListDestination = response;
    notifyListeners();
  }

  setCostList(ApiResponse<List<Costs>> response) {
    costList = response;
    notifyListeners();
  }

  Future<void> getProvinceList() async {
    setProvinceList(ApiResponse.loading());
    _homeRepo.fetchProvinceList().then(
      (value) {
        setProvinceList(ApiResponse.completed(value));
      },
    ).onError((error, StackTrace) {
      setProvinceList(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<List<City>> cityList = ApiResponse.loading();

  setCityList(ApiResponse<List<City>> response) {
    cityList = response;
    notifyListeners();
  }

  Future<void> getCityListOrigin(provId) async {
    setCityListOrigin(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setCityListOrigin(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCityListOrigin(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getCityListDestination(provId) async {
    setCityListDestination(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setCityListDestination(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCityListDestination(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getCityList(var provId) async {
    setCityList(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then(
      (value) {
        setCityList(ApiResponse.completed(value));
      },
    ).onError((error, StackTrace) {
      setCityList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getCostList(
      String selectedProvinceOrigin,
      String selectedCityOrigin,
      String selectedProvinceDestination,
      String selectedCityDestination,
      int itemWeight,
      String selectedCourier) async {
    setLoading(true);
    _homeRepo
        .fetchCostList(
            selectedProvinceOrigin,
            selectedCityOrigin,
            selectedProvinceDestination,
            selectedCityDestination,
            itemWeight,
            selectedCourier)
        .then((value) {
      setCostList(ApiResponse.completed(value));
      setLoading(false);
    }).onError((error, stackTrace) {
      setCostList(ApiResponse.error(error.toString()));
    });
  }
}
