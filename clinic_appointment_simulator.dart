import 'dart:io';

/// Logs operational activities with system-level formatting
mixin LoggerMixin {
  void log(String message) {
    print('[CLINIC LOG] $message');
  }
}

/// Abstract base class representing a generic healthcare service/appointment
abstract class HealthService {
  final int id;
  final String patientName;
  bool isConfirmed;

  HealthService({
    required this.id,
    required this.patientName,
    this.isConfirmed = false,
  });

  void displaySummary();
}

/// Represents a specific medical appointment entry
class Appointment extends HealthService with LoggerMixin {
  final String doctorName;
  final String appointmentTime;

  Appointment({
    required super.id,
    required super.patientName,
    required this.doctorName,
    required this.appointmentTime,
  });

  @override
  void displaySummary() {
    final status = isConfirmed ? 'Confirmed' : 'Pending';
    print('#$id | Patient: $patientName | Doctor: $doctorName | Time: $appointmentTime [$status]');
  }
}

class Receptionist {
  final int staffId;
  final String name;

  const Receptionist({
    required this.staffId,
    required this.name,
  });
}

class ClinicService with LoggerMixin {
  final List<Appointment> _schedule = [];

  List<Appointment> get schedule => List.unmodifiable(_schedule);

  void bookAppointment(Appointment appointment) {
    _schedule.add(appointment);
    log('New appointment booked for ${appointment.patientName}.');
  }

  void displaySchedule() {
    print('\n===== CLINIC SCHEDULE =====');
    if (_schedule.isEmpty) {
      print('No appointments currently scheduled.');
      return;
    }
    for (final appointment in _schedule) {
      appointment.displaySummary();
    }
  }

  Future<void> confirmAppointment(int appointmentId, Receptionist receptionist) async {
    print('\n[+] Processing appointment confirmation...');
    await Future.delayed(const Duration(seconds: 2));

    try {
      final index = _schedule.indexWhere((a) => a.id == appointmentId);
      if (index == -1) {
        throw Exception('Appointment ID #$appointmentId was not found.');
      }

      final appointment = _schedule[index];
      if (appointment.isConfirmed) {
        throw Exception('Appointment for ${appointment.patientName} is already confirmed.');
      }

      appointment.isConfirmed = true;
      log('${receptionist.name} confirmed appointment #${appointment.id}.');
      print('Success: Appointment for "${appointment.patientName}" is now confirmed!');
    } catch (e) {
      print('Confirmation Error: ${e.toString().replaceAll('Exception: ', '')}');
    }
  }

  Future<void> cancelAppointment(int appointmentId, Receptionist receptionist) async {
    print('\n[-] Processing cancellation request...');
    await Future.delayed(const Duration(seconds: 2));

    try {
      final index = _schedule.indexWhere((a) => a.id == appointmentId);
      if (index == -1) {
        throw Exception('Appointment ID #$appointmentId was not found.');
      }

      final appointment = _schedule[index];
      _schedule.removeAt(index);

      log('${receptionist.name} cancelled appointment #${appointment.id}.');
      print('Success: Cancelled appointment for "${appointment.patientName}".');
    } catch (e) {
      print('Cancellation Error: ${e.toString().replaceAll('Exception: ', '')}');
    }
  }
}

Future<void> main() async {
  final clinic = ClinicService();
  const receptionist = Receptionist(staffId: 201, name: 'Admin Staff');

  // Pre-load default clinic appointments
  clinic.bookAppointment(Appointment(
    id: 1,
    patientName: 'Alice Johnson',
    doctorName: 'Dr. Smith',
    appointmentTime: '10:00 AM',
  ));

  clinic.bookAppointment(Appointment(
    id: 2,
    patientName: 'Bob Martinez',
    doctorName: 'Dr. Cruz',
    appointmentTime: '02:30 PM',
  ));

  print('====================================');
  print('     CLINIC APPOINTMENT TRACKER');
  print('====================================');
  print('Logged in as: ${receptionist.name}');

  var running = true;

  while (running) {
    print('\n--------------- MENU ---------------');
    print('1. Book New Appointment');
    print('2. View Schedule');
    print('3. Confirm Appointment');
    print('4. Cancel Appointment');
    print('5. Exit');

    stdout.write('Select an option (1-5): ');
    final choice = stdin.readLineSync()?.trim();

    switch (choice) {
      case '1':
        stdout.write('Enter Patient Name: ');
        final patientName = stdin.readLineSync()?.trim() ?? '';

        stdout.write('Enter Doctor Name: ');
        final doctorName = stdin.readLineSync()?.trim() ?? '';

        stdout.write('Enter Time Slot (e.g., 03:00 PM): ');
        final time = stdin.readLineSync()?.trim() ?? '';

        if (patientName.isEmpty || doctorName.isEmpty || time.isEmpty) {
          print('Error: All fields are required.');
          break;
        }

        final nextId = clinic.schedule.isEmpty
            ? 1
            : clinic.schedule.map((a) => a.id).fold(0, (max, id) => id > max ? id : max) + 1;

        clinic.bookAppointment(Appointment(
          id: nextId,
          patientName: patientName,
          doctorName: doctorName,
          appointmentTime: time,
        ));
        print('Appointment booked successfully!');
        break;

      case '2':
        clinic.displaySchedule();
        break;

      case '3':
        stdout.write('Enter Appointment ID to confirm: ');
        final input = stdin.readLineSync();
        final appId = int.tryParse(input ?? '');

        if (appId == null) {
          print('Error: Please enter a valid numerical ID.');
          break;
        }

        await clinic.confirmAppointment(appId, receptionist);
        break;

      case '4':
        stdout.write('Enter Appointment ID to cancel: ');
        final input = stdin.readLineSync();
        final appId = int.tryParse(input ?? '');

        if (appId == null) {
          print('Error: Please enter a valid numerical ID.');
          break;
        }

        await clinic.cancelAppointment(appId, receptionist);
        break;

      case '5':
        running = false;
        print('\nExiting system. Have a healthy day!');
        break;

      default:
        print('Invalid option. Please choose between 1 and 5.');
    }
  }
}