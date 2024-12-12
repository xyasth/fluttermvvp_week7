part of "pages.dart";

class Costs_Page extends StatefulWidget {
  const Costs_Page({super.key});

  @override
  State<Costs_Page> createState() => _CostsPageState();
}

class _CostsPageState extends State<Costs_Page> {
  HomeViewmodel homeViewmodel = HomeViewmodel();
  final TextEditingController _weightController = TextEditingController();
  dynamic selectedProvinceAsal;
  dynamic selectedCityAsal;
  dynamic selectedProvinceTujuan;
  dynamic selectedCityTujuan;
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
        backgroundColor: Colors.lightGreen.shade700,
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
                const Text(
                  "Pengaturan Pengiriman",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue),
                ),
                const SizedBox(height: 16),
                // Courier and Weight Input
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedCourier,
                        icon: const Icon(Icons.arrow_drop_down),
                        hint: const Text("Pilih Kurir"),
                        items: courierLists
                            .map<DropdownMenuItem<String>>((String courier) {
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
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Berat Barang (gr)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  "Asal Pengiriman",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Consumer<HomeViewmodel>(
                        builder: (context, value, _) {
                          switch (value.provinceList.status) {
                            case Status.loading:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case Status.error:
                              return Center(
                                child:
                                    Text(value.provinceList.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                isExpanded: true,
                                value: selectedProvinceAsal,
                                icon: const Icon(Icons.arrow_drop_down),
                                hint: const Text("Pilih Provinsi"),
                                items: value.provinceList.data!
                                    .map<DropdownMenuItem<Province>>(
                                        (Province value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value.province.toString()),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedProvinceAsal = newValue;
                                    selectedCityAsal = null;
                                  });
                                  if (newValue != null) {
                                    homeViewmodel.getCityListAsal(
                                        selectedProvinceAsal.provinceId);
                                  }
                                },
                              );
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Consumer<HomeViewmodel>(
                        builder: (context, value, _) {
                          switch (value.cityListAsal.status) {
                            case Status.loading:
                              return const Center(
                                child: Text("Isi Provinsi terlebih dahulu"),
                              );
                            case Status.error:
                              return Center(
                                child:
                                    Text(value.cityListAsal.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                isExpanded: true,
                                value: selectedCityAsal,
                                icon: const Icon(Icons.arrow_drop_down),
                                hint: const Text("Pilih Kota"),
                                items: value.cityListAsal.data!
                                    .map<DropdownMenuItem<City>>((City value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value.cityName.toString()),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCityAsal = newValue;
                                  });
                                },
                              );
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  "Tujuan Pengiriman",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Consumer<HomeViewmodel>(
                        builder: (context, value, _) {
                          switch (value.provinceList.status) {
                            case Status.loading:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case Status.error:
                              return Center(
                                child:
                                    Text(value.provinceList.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                isExpanded: true,
                                value: selectedProvinceTujuan,
                                icon: const Icon(Icons.arrow_drop_down),
                                hint: const Text("Pilih Provinsi"),
                                items: value.provinceList.data!
                                    .map<DropdownMenuItem<Province>>(
                                        (Province value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value.province.toString()),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedProvinceTujuan = newValue;
                                    selectedCityTujuan = null;
                                  });
                                  if (newValue != null) {
                                    homeViewmodel.getCityListTujuan(
                                        selectedProvinceTujuan.provinceId);
                                  }
                                },
                              );
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Consumer<HomeViewmodel>(
                        builder: (context, value, _) {
                          switch (value.cityListTujuan.status) {
                            case Status.loading:
                              return const Center(
                                child: Text("Isi Provinsi terlebih dahulu"),
                              );
                            case Status.error:
                              return Center(
                                child: Text(
                                    value.cityListTujuan.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                isExpanded: true,
                                value: selectedCityTujuan,
                                icon: const Icon(Icons.arrow_drop_down),
                                hint: const Text("Pilih Kota"),
                                items: value.cityListTujuan.data!
                                    .map<DropdownMenuItem<City>>((City value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value.cityName.toString()),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCityTujuan = newValue;
                                  });
                                },
                              );
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedCourier != null &&
                          selectedProvinceAsal != null &&
                          selectedCityAsal != null &&
                          selectedProvinceTujuan != null &&
                          selectedCityTujuan != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Mengcek harga..."),
                        ));
                        homeViewmodel.getCostList(
                          selectedProvinceAsal.toString(),
                          selectedCityAsal.cityId.toString(),
                          selectedProvinceTujuan.toString(),
                          selectedCityTujuan.cityId.toString(),
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
                      "Hitung Harga",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      backgroundColor: Colors.lightGreen.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Consumer<HomeViewmodel>(
                  builder: (context, value, _) {
                    if (value.costList.status == Status.loading) {
                      return const Center(
                          child: Text("Isi data diatas terlebih dahulu"));
                    } else if (value.costList.status == Status.error) {
                      return Center(
                          child: Text("Error: ${value.costList.message}"));
                    } else if (value.costList.status == Status.completed) {
                      final costData = value.costList.data;
                      if (costData != null && costData.isNotEmpty) {
                        return Column(
                          children: costData.map((costs) {
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Text(costs.service ?? "Invalid"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Service: ${costs.service ?? "-"}"),
                                    Text(
                                        "Cost: Rp${costs.cost![0].value ?? 0}"),
                                    Text(
                                        "Estimated day: ${costs.cost![0].etd ?? ""}"),
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
                      return Container();
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
