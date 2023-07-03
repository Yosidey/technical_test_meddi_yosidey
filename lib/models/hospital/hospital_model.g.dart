part of 'hospital_model.dart';

///ResponseHospital
ResponseHospital _$ResponseHospitalFromJson(Map<String, dynamic> json) => ResponseHospital(
      ok: json['ok'] as bool,
      status: json['status'] as int,
      data: DataHospital.fromJson(json["data"]),
    );

Map<String, dynamic> _$ResponseHospitalToJson(ResponseHospital instance) => <String, dynamic>{
      "ok": instance.ok,
      "status": instance.status,
      "data": instance.data,
    };

///DataHospital
DataHospital _$DataHospitalFromJson(Map<String, dynamic> json) => DataHospital(
      total: json['total'] as int,
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      data: (json['data'] as List<dynamic>?)!.map((e) => Hospital.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$DataHospitalToJson(DataHospital instance) => <String, dynamic>{
      "total": instance.total,
      "currentPage": instance.total,
      "totalPages": instance.total,
      "data": instance.total,
    };

///Hospital
Hospital _$HospitalFromJson(Map<String, dynamic> json) => Hospital(
      id: json['_id'] as String,
      name: json['name'] as String,
      foto: json['foto'] as String,
      logo: json['logo'] as String,
      direccion: json['direccion'] as String,
      urlGoogleMaps: json['urlGoogleMaps'] as String,
      enabled: json['enabled'] as bool,
      telefono: json['telefono'] as String,
      horario: json['horario'] as String,
      estadoCode: json['estadoCode'] as String,
      municipio: json['municipio'] as String,
      observaciones: json['observaciones'] as String,
      location: Location.fromJson(json["location"]),
      aseguradora: List<int>.from(json["aseguradora"].map((x) => x)),
      v: json['__v'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      dist: Dist.fromJson(json["dist"]),
    );

Map<String, dynamic> _$HospitalToJson(Hospital instance) => <String, dynamic>{
      "_id": instance.id,
      "name": instance.name,
      "foto": instance.foto,
      "logo": instance.logo,
      "direccion": instance.direccion,
      "urlGoogleMaps": instance.urlGoogleMaps,
      "enabled": instance.enabled,
      "telefono": instance.telefono,
      "horario": instance.horario,
      "estadoCode": instance.estadoCode,
      "municipio": instance.municipio,
      "observaciones": instance.observaciones,
      "location": instance.location,
      "aseguradora": instance.aseguradora,
      "__v": instance.v,
      "createdAt": instance.createdAt,
      "updatedAt": instance.updatedAt,
      "dist": instance.dist,
    };

///Location
Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      type: json['type'] as String,
      coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
    );

Map<String, dynamic> _$LocationToJson(Location instance) =>
    <String, dynamic>{"type": instance.type, "coordinates": instance.coordinates};

///Dist
Dist _$DistFromJson(Map<String, dynamic> json) => Dist(
      calculated: json['calculated'] as double,
      location: Location.fromJson(json["location"]),
    );

Map<String, dynamic> _$DistToJson(Dist instance) => <String, dynamic>{
      "calculated": instance.calculated,
      "calculated": instance.location,
    };

///HospitalRequest
RequestHospital _$HospitalRequestFromJson(Map<String, dynamic> json) => RequestHospital(
      hospitalId: json['hospitalId'] as String,
    );

Map<String, dynamic> _$HospitalRequestToJson(RequestHospital instance) => <String, dynamic>{
      "hospitalId": instance.hospitalId,
    };
