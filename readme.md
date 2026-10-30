# 🩺 Clinic Appointment Tracker (Dart)

A simple console-based Clinic Appointment Tracker developed using **Dart**. This project demonstrates Object-Oriented Programming (OOP) concepts and asynchronous programming through basic medical clinic operations such as booking, viewing schedule, confirming, and cancelling patient appointments.

## 📌 Project Overview

The Clinic Appointment Tracker simulates a medical clinic booking system where administrative staff can manage doctor appointments and process confirmation or cancellation transactions.

The application uses Dart classes, inheritance, abstraction, mixins, constructors, encapsulation, and asynchronous functions to demonstrate key course programming concepts.

## ✨ Features

- **Book Appointments** – Schedule new patient appointments with details for patient name, assigned doctor, and time slot.
- **View Schedule** – Display all scheduled appointments along with their confirmation status.
- **Confirm Appointments** – Confirm pending patient appointments by unique Appointment ID.
- **Cancel Appointments** – Cancel and remove appointments from the system schedule.
- **Status Updates** – Automatically updates appointment confirmation status.
- **System Logging** – Displays real-time activity and operational logs using mixins.
- **Asynchronous Operations** – Simulates operational processing delays during confirmation and cancellation actions.
- **Error Handling** – Safely handles invalid IDs and non-existent appointments.

## 🛠️ Technologies Used

- **Programming Language:** Dart (SDK 2.17+)
- **Application Type:** Console-Based Application
- **Standard Library:** `dart:io`

## 📖 OOP Concepts Implemented

| Concept | Implementation |
|---|---|
| Classes and Objects | `Appointment`, `ClinicService`, and `Receptionist` |
| Inheritance | `Appointment` extends `HealthService` |
| Abstraction | `HealthService` abstract base class |
| Mixins | `LoggerMixin` |
| Constructors | Super parameter constructors (`super.id`, `super.patientName`) |
| Encapsulation | Private schedule management via `List.unmodifiable` |

## ⚡ Asynchronous Programming

This project demonstrates asynchronous programming using:

- `Future<void>` – Defines asynchronous return types.
- `async` / `await` – Suspends execution until pending asynchronous operations complete.
- `Future.delayed()` – Simulates a 2-second processing delay for transactions.
- `try-catch` – Handles operational errors gracefully without crashing.

## 🚀 How to Run

### Option 1: Using Dart SDK

1. Install the [Dart SDK](https://dart.dev/get-dart).
2. Save `clinic_appointment_simulator.dart` to your workspace directory.
3. Open terminal and run:

   ```bash
   dart run clinic_appointment_simulator.dart
   ```

### Option 2: Using an Online Dart Compiler

1. Visit [DartPad](https://dartpad.dev/).
2. Copy the source code from `clinic_appointment_simulator.dart`.
3. Paste it into the editor and run.

*(Note: Online compilers must support standard input via `stdin` for interactive console input.)*

## 🖥️ Application Menu

```text
====================================
     CLINIC APPOINTMENT TRACKER
====================================
Logged in as: Admin Staff

--------------- MENU ---------------
1. Book New Appointment
2. View Schedule
3. Confirm Appointment
4. Cancel Appointment
5. Exit

Select an option (1-5):
```

## 📂 Project Structure

```text
Clinic-Appointment-Tracker/
│
├── clinic_appointment_simulator.dart
└── README.md
```

## 🎯 Project Objectives

- Apply Object-Oriented Programming concepts using Dart.
- Demonstrate understanding of abstraction, inheritance, encapsulation, and mixins.
- Implement asynchronous operations using `Future`, `async`, and `await`.
- Practice robust input validation and error handling using `try-catch`.
- Build an interactive console application for academic evaluation.

## 🎓 Project Information

**Project Title:** Clinic Appointment Tracker (Dart App Simulator)  
**Project Type:** Individual Final Midterm Project  
**Programming Language:** Dart  
**Course Coverage:** Weeks 7–11  

---
