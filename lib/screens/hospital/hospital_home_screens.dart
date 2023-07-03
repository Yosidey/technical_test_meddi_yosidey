import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_meddi_yosidey/blocs/blocs_export.dart';
import 'package:technical_test_meddi_yosidey/libraries/components/widgets_generic.dart';
import 'package:technical_test_meddi_yosidey/models/hospital/hospital_model.dart';
import 'package:technical_test_meddi_yosidey/screens/global/global_export.dart';
import 'package:technical_test_meddi_yosidey/screens/hospital/hospital_export.dart';

class HospitalPage extends StatelessWidget {
  const HospitalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HospitalBloc(globalBloc: BlocProvider.of<GlobalBloc>(context))..add(const HospitalGetDataEvent(page: 1));
      },
      child: const HospitalFrom(),
    );
  }
}

class HospitalFrom extends StatefulWidget {
  const HospitalFrom({super.key});

  @override
  State<HospitalFrom> createState() => _HospitalFromState();
}

class _HospitalFromState extends State<HospitalFrom> {
  late List<Hospital> data = [];
  late bool isLoading = false;
  late int currentPage = 0;
  late int totalPages = 0;

  onPressGetProduct(int page) {
    BlocProvider.of<HospitalBloc>(context).add(HospitalGetDataEvent(page: page));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalBloc, GlobalState>(
      listener: (context, state) {
        if (state is GlobalUnauthenticatedState) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(title: Text("Aviso importante"), content: Text("Sesion expiro"));
            },
          );
        }
      },
      child: BlocListener<HospitalBloc, HospitalState>(
        listener: (context, state) {
          setState(() {
            if (state is HospitalLoadingState) {
              isLoading = true;
            }
            if (state is HospitalReceivedState) {
              data.clear();
              data = state.responseHospital.data.data;
              currentPage = state.responseHospital.data.currentPage;
              totalPages = state.responseHospital.data.totalPages;
            }
            if (state is HospitalSuccessState) {
              isLoading = false;
            }
            if (state is HospitalFailedState) {
              isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.toString()),
                  action: SnackBarAction(label: "Entiendo", onPressed: () {}),
                ),
              );
            }
          });
        },
        child: BlocBuilder<HospitalBloc, HospitalState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Scaffold(
                appBar: AppBar(title: const Text("Hospitales")),
                body: Stack(
                  children: [
                    (data.isNotEmpty)
                        ? Column(
                            children: [
                              Expanded(
                                flex: 10,
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    onPressGetProduct(currentPage);
                                  },
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(data[index].name),
                                        subtitle: Text(data[index].direccion),
                                        leading: fadeImage(context: context, image: data[index].logo, size: 64),
                                        // leading: Icon(Icons.circle, color: data[index].enabled ? Colors.green : Colors.grey),
                                        onTap: () {
                                          showBottomSheet(
                                            context: context,
                                            builder: (context) => HospitalDetailsPage(hospital: data[index]),
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) => const Divider(),
                                    itemCount: data.length,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 64,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: totalPages,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: (currentPage == index + 1)
                                          ? null
                                          : () {
                                              onPressGetProduct(index + 1);
                                            },
                                      child: Text((index + 1).toString(), textScaleFactor: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(child: Text("Lista vacia")),
                              if (!isLoading)
                                ElevatedButton(
                                  onPressed: () {
                                    onPressGetProduct(1);
                                  },
                                  child: const Text("Refrescar"),
                                )
                            ],
                          ),
                    if (isLoading) loadingIndicator(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
