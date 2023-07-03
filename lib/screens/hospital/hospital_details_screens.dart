import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_meddi_yosidey/blocs/blocs_export.dart';
import 'package:technical_test_meddi_yosidey/libraries/components/widgets_generic.dart';

import 'package:technical_test_meddi_yosidey/models/hospital/hospital_model.dart';
import 'package:technical_test_meddi_yosidey/screens/global/global_export.dart';
import 'package:technical_test_meddi_yosidey/screens/hospital/hospital_export.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalDetailsPage extends StatelessWidget {
  const HospitalDetailsPage({super.key, required this.hospital});

  final Hospital hospital;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HospitalBloc(globalBloc: BlocProvider.of<GlobalBloc>(context));
      },
      child: HospitalDetailsFrom(hospital: hospital),
    );
  }
}

class HospitalDetailsFrom extends StatefulWidget {
  const HospitalDetailsFrom({super.key, required this.hospital});

  final Hospital hospital;

  @override
  State<HospitalDetailsFrom> createState() => _HospitalDetailsFromState();
}

class _HospitalDetailsFromState extends State<HospitalDetailsFrom> {
  late bool isLoading = false;

  onPressRequest() {
    BlocProvider.of<HospitalBloc>(context)
        .add(HospitalRequestEvent(hospital: RequestHospital(hospitalId: widget.hospital.id)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void launchMap() async {
    final Uri uri = Uri.parse(widget.hospital.urlGoogleMaps);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Error";
    }
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
            if (state is HospitalSuccessState) {
              isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Solicitud exitosa"),
                  action: SnackBarAction(label: "Entiendo", onPressed: () {}),
                ),
              );

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
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  height: 5,
                  width: 64,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(30)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                heroImage(context: context, image: widget.hospital.logo, enabled: widget.hospital.enabled),
                          ),
                          ExpansionTile(
                            title: const Text("Información basica"),
                            initiallyExpanded: true,
                            children: [
                              ListTile(
                                title: const Text("Nombre de Hospital", softWrap: true),
                                subtitle: Text(widget.hospital.name, softWrap: true),
                              ),
                              ListTile(
                                title: const Text("Teléfono"),
                                subtitle: Text(widget.hospital.telefono),
                              ),
                              ListTile(
                                title: const Text("Horario"),
                                subtitle: Text(widget.hospital.horario),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: const Text("Ubicación"),
                            initiallyExpanded: true,
                            children: [
                              ListTile(
                                title: const Text("Dirección"),
                                subtitle: Text(widget.hospital.direccion),
                                trailing: TextButton(onPressed: launchMap, child: const Text("Localizar")),
                              ),
                              ListTile(title: const Text("Municipio"), subtitle: Text(widget.hospital.municipio)),
                              ListTile(title: const Text("Código de Estado"), subtitle: Text(widget.hospital.estadoCode)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: 64,
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (isLoading) ? null : onPressRequest, child: const Text("Solicitar")))
              ],
            );
          },
        ),
      ),
    );
  }
}
