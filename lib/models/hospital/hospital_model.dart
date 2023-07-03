import 'package:json_annotation/json_annotation.dart';

part 'hospital_model.g.dart';

class ResponseHospital {
  final bool ok;
  final int status;
  final DataHospital data;

  ResponseHospital({required this.ok, required this.status, required this.data});

  factory ResponseHospital.fromJson(Map<String, dynamic> json) => _$ResponseHospitalFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseHospitalToJson(this);
}

class DataHospital {
  final int total;
  final int currentPage;
  final int totalPages;
  final List<Hospital> data;

  DataHospital({required this.total, required this.currentPage, required this.totalPages, required this.data});

  factory DataHospital.fromJson(Map<String, dynamic> json) => _$DataHospitalFromJson(json);

  Map<String, dynamic> toJson() => _$DataHospitalToJson(this);
}

class Hospital {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String foto;
  final String logo;
  final String direccion;
  final String urlGoogleMaps;
  final bool enabled;
  final String telefono;
  final String horario;
  final String estadoCode;
  final String municipio;
  final String observaciones;
  final Location location;
  final List<int> aseguradora;
  @JsonKey(name: '__v')
  final int v;
  final String createdAt;
  final String updatedAt;
  final Dist dist;

  Hospital({
    required this.id,
    required this.name,
    required this.foto,
    required this.logo,
    required this.direccion,
    required this.urlGoogleMaps,
    required this.enabled,
    required this.telefono,
    required this.horario,
    required this.estadoCode,
    required this.municipio,
    required this.observaciones,
    required this.location,
    required this.aseguradora,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
    required this.dist,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) => _$HospitalFromJson(json);

  Map<String, dynamic> toJson() => _$HospitalToJson(this);
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({required this.type, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

class Dist {
  final double calculated;
  final Location location;

  Dist({required this.calculated, required this.location});

  factory Dist.fromJson(Map<String, dynamic> json) => _$DistFromJson(json);

  Map<String, dynamic> toJson() => _$DistToJson(this);
}

class RequestHospital {
  final String hospitalId;

  RequestHospital({required this.hospitalId});

  factory RequestHospital.fromJson(Map<String, dynamic> json) => _$HospitalRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HospitalRequestToJson(this);
}
