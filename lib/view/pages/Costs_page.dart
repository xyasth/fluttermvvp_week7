part of "pages.dart";

class Costs_Page extends StatefulWidget {
  const Costs_Page({super.key});

  @override
  State<Costs_Page> createState() => _CostsPageState();
}

class _CostsPageState extends State<Costs_Page> {
  HomeViewmodel homeViewmodel = HomeViewmodel();
  final TextEditingController _weightController = TextEditingController();
  dynamic selectedProvinceOrigin;
  dynamic selectedCityOrigin;
  dynamic selectedProvinceDestination;
  dynamic selectedCityDestination;
  dynamic selectedCourier;
  List<String> courierLists = ["JNE", "POS", "TIKI"];

  @override
  void initState() {
    super.initState();
    homeViewmodel.getProvinceList();
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Hitung Ongkir",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<HomeViewmodel>(
        create: (_) => homeViewmodel,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Courier Dropdown
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          DropdownButton<String>(
                            isExpanded: true,
                            value: selectedCourier,
                            icon: const Icon(Icons.arrow_drop_down),
                            hint: const Text("Pilih kurir"),
                            items: courierLists.map<DropdownMenuItem<String>>(
                                (String courier) {
                              return DropdownMenuItem<String>(
                                value: courier,
                                child: Text(courier.toUpperCase()),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedCourier = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Weight Input
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Berat barang (gr)",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "Origin",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 2),
                // Origin Province Dropdown
                Row(
                  children: [
                    Expanded(
                      child: Consumer<HomeViewmodel>(
                        builder: (context, value, _) {
                          switch (value.provinceList.status) {
                            case Status.loading:
                              return const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                            case Status.error:
                              return Align(
                                alignment: Alignment.center,
                                child:
                                    Text(value.provinceList.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                  isExpanded: true,
                                  value: selectedProvinceOrigin,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text("Pilih Provinsi"),
                                  items: value.provinceList.data!
                                      .map<DropdownMenuItem<Province>>(
                                          (Province value) {
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.province.toString()));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedProvinceOrigin = newValue;
                                      selectedCityOrigin = null;
                                    });
                                    if (newValue != null) {
                                      homeViewmodel.getCityListOrigin(
                                          selectedProvinceOrigin.provinceId);
                                    }
                                  });
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    // Origin City Dropdown
                    Expanded(
                      child: Consumer<HomeViewmodel>(
                        builder: (context, value, _) {
                          switch (value.cityListOrigin.status) {
                            case Status.loading:
                              return const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                            case Status.error:
                              return Align(
                                alignment: Alignment.center,
                                child: Text(
                                    value.cityListOrigin.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                  isExpanded: true,
                                  value: selectedCityOrigin,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text("Pilih Kota"),
                                  items: value.cityListOrigin.data!
                                      .map<DropdownMenuItem<City>>(
                                          (City value) {
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.cityName.toString()));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCityOrigin = newValue;
                                    });
                                  });
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "Destination",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 2),
                // Destination Province Dropdown
                Row(
                  children: [
                    Expanded(
                      child: Consumer<HomeViewmodel>(
                        builder: (context, value, _) {
                          switch (value.provinceList.status) {
                            case Status.loading:
                              return const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                            case Status.error:
                              return Align(
                                alignment: Alignment.center,
                                child:
                                    Text(value.provinceList.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                  isExpanded: true,
                                  value: selectedProvinceDestination,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text("Pilih Provinsi"),
                                  items: value.provinceList.data!
                                      .map<DropdownMenuItem<Province>>(
                                          (Province value) {
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.province.toString()));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedProvinceDestination = newValue;
                                      selectedCityDestination = null;
                                    });
                                    if (newValue != null) {
                                      homeViewmodel.getCityListDestination(
                                          selectedProvinceDestination
                                              .provinceId);
                                    }
                                  });
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Destination City Dropdown
                    Expanded(
                      child: Consumer<HomeViewmodel>(
                        builder: (context, value, _) {
                          switch (value.cityListDestination.status) {
                            case Status.loading:
                              return const Align(
                                alignment: Alignment.center,
                                child: Text("isi provinsi terlebih dahulu"),
                              );
                            case Status.error:
                              return Align(
                                alignment: Alignment.center,
                                child: Text(value.cityListDestination.message
                                    .toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                  isExpanded: true,
                                  value: selectedCityDestination,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text("Pilih Kota"),
                                  items: value.cityListDestination.data!
                                      .map<DropdownMenuItem<City>>(
                                          (City value) {
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.cityName.toString()));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCityDestination = newValue;
                                    });
                                  });
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                // Check Cost Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedCourier != null &&
                          selectedProvinceOrigin != null &&
                          selectedCityOrigin != null &&
                          selectedProvinceDestination != null &&
                          selectedCityDestination != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("mengcek harga..."),
                        ));
                        homeViewmodel.getCostList(
                          selectedProvinceOrigin.toString(),
                          selectedCityOrigin.cityId.toString(),
                          selectedProvinceDestination.toString(),
                          selectedCityDestination.cityId.toString(),
                          int.tryParse(_weightController.text.trim()) ?? 0,
                          selectedCourier.toString(),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              "Mohon lengkapi semua pilihan terlebih dahulu!"),
                        ));
                      }
                    },
                    child: const Text(
                      "hitung harga",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Padding inside the button
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(4), // Rounded corners
                      ),
                      textStyle: TextStyle(
                        fontSize: 12, // Size of the text // Bold text
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Consumer<HomeViewmodel>(
                  builder: (context, value, _) {
                    if (value.costList.status == Status.loading) {
                      return Center(
                          child: Text("Isi data diatas terlebih dahulu"));
                    } else if (value.costList.status == Status.error) {
                      return Center(
                          child: Text("Error: ${value.costList.message}"));
                    } else if (value.costList.status == Status.completed) {
                      final costData =
                          value.costList.data; // Get the List<Costs>
                      if (costData != null && costData.isNotEmpty) {
                        return Column(
                          children: costData.map((costs) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              surfaceTintColor:
                                  const Color.fromARGB(255, 17, 0, 255),
                              child: ListTile(
                                title:
                                    Text(costs.service.toString() ?? "Invalid"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Supaya teks rata kiri
                                  children: [
                                    Text("Service: ${costs.service ?? "-"}"),
                                    Text(
                                        "Cost: Rp${costs.cost![0].value ?? 0}"),
                                    Text(
                                        "Estimated day: ${costs.cost![0].etd ?? ""}"),
                                    // Tambahkan subtitle lainnya sesuai kebutuhan
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return const Text("No costs available.");
                      }
                    } else {
                      return Container(); // This handles any other unknown state
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
