// DoctorLocationData.dart file
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:csv/csv.dart';

class Doctor {
  final String doctorId;
  final double latitude;
  final double longitude;
  final String government;
  final double rate;
  final String phone; // Add this line

  Doctor({
    required this.doctorId,
    required this.latitude,
    required this.longitude,
    required this.government,
    required this.rate,
    required this.phone, // Add this line
  });
}

class LocationData {
  static List<Marker> getMarkersFromDoctors(
      List<Doctor> doctors, Function showCustomInfoWindow) {
    List<Marker> markers = [];

    for (Doctor doctor in doctors) {
      markers.add(
        Marker(
          markerId: MarkerId(doctor.doctorId),
          position: LatLng(doctor.latitude, doctor.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () {
            showCustomInfoWindow(
                doctor.doctorId, doctor.government, doctor.rate);
          },
        ),
      );
    }

    return markers;
  }

  static List<Doctor> getDoctorsFromCSV(String csvString) {
    List<List<dynamic>> csvTable =
        const CsvToListConverter().convert(csvString);

    List<Doctor> doctors = [];

    for (List<dynamic> row in csvTable) {
      try {
        double latitude = parseDouble(row[0]);
        double longitude = parseDouble(row[1]);
        String doctorName = row[2].toString();
        String phone = row[3].toString();
        String government = row[4].toString();
        double rate = parseDouble(row[5]);

        doctors.add(Doctor(
          doctorId: doctorName,
          latitude: latitude,
          longitude: longitude,
          government: government,
          rate: rate,
          phone: phone,
        ));
      } catch (e) {
        print('Error parsing row: $row');
      }
    }

    return doctors;
  }

  static double parseDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0;
    }
  }
}
