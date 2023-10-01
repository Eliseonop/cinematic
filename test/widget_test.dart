// import 'package:cinematic/velocimetro/velocimetro_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:geolocator/geolocator.dart';

// import 'package:permission_handler/permission_handler.dart';

// import 'package:my_app/velocimetro_widget.dart';

// class MockGeolocator extends Mock implements Geolocator {}

// class MockPositionStream extends Mock implements Stream<Position> {}

// class MockPermissionHandler extends Mock implements PermissionHandler {}

// void main() {
//   group('VelocimetroWidget', () {
//     late MockGeolocator mockGeolocator;
//     late MockPositionStream mockPositionStream;
//     late MockPermissionHandler mockPermissionHandler;

//     setUp(() {
//       mockGeolocator = MockGeolocator();
//       mockPositionStream = MockPositionStream();
//       mockPermissionHandler = MockPermissionHandler();
//     });

//     testWidgets('renders correctly', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: VelocimetroWidget(),
//         ),
//       );

//       expect(find.text('Pedir permiso de ubicación'), findsOneWidget);
//     });

//     testWidgets('requests location permission when button is tapped',
//         (WidgetTester tester) async {
//       when(mockPermissionHandler.request).thenAnswer((_) async {
//         return PermissionStatus.granted;
//       });

//       await tester.pumpWidget(
//         MaterialApp(
//           home: VelocimetroWidget(),
//         ),
//       );

//       await tester.tap(find.text('Pedir permiso de ubicación'));
//       await tester.pumpAndSettle();

//       verify(mockPermissionHandler.request(PermissionGroup.location)).called(1);
//     });

//     testWidgets('starts tracking location when button is tapped',
//         (WidgetTester tester) async {
//       when(mockPermissionHandler.request).thenAnswer((_) async {
//         return PermissionStatus.granted;
//       });

//       when(mockGeolocator.getPositionStream(
//         desiredAccuracy: anyNamed('desiredAccuracy'),
//         distanceFilter: anyNamed('distanceFilter'),
//       )).thenReturn(mockPositionStream);

//       await tester.pumpWidget(
//         MaterialApp(
//           home: VelocimetroWidget(),
//         ),
//       );

//       await tester.tap(find.text('Pedir permiso de ubicación'));
//       await tester.pumpAndSettle();

//       await tester.tap(find.text('Empezar a seguir'));
//       await tester.pumpAndSettle();

//       verify(mockGeolocator.getPositionStream(
//         desiredAccuracy: LocationAccuracy.high,
//         distanceFilter: 10,
//       )).called(1);
//     });

//     testWidgets('stops tracking location when button is tapped',
//         (WidgetTester tester) async {
//       when(mockPermissionHandler.request).thenAnswer((_) async {
//         return PermissionStatus.granted;
//       });

//       when(mockGeolocator.getPositionStream(
//         desiredAccuracy: anyNamed('desiredAccuracy'),
//         distanceFilter: anyNamed('distanceFilter'),
//       )).thenReturn(mockPositionStream);

//       await tester.pumpWidget(
//         MaterialApp(
//           home: VelocimetroWidget(),
//         ),
//       );

//       await tester.tap(find.text('Pedir permiso de ubicación'));
//       await tester.pumpAndSettle();

//       await tester.tap(find.text('Empezar a seguir'));
//       await tester.pumpAndSettle();

//       await tester.tap(find.text('Detener seguimiento'));
//       await tester.pumpAndSettle();

//       verify(mockPositionStream.cancel()).called(1);
//     });
//   });
// }
