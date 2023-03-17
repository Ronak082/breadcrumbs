import 'package:breadcrumbs/hprange.dart';
import 'package:breadcrumbs/make.dart';
import 'package:breadcrumbs/meter_reading.dart';
import 'package:breadcrumbs/model.dart';
import 'package:go_router/go_router.dart';

enum AppRoute { home, model,make,hpRange, meterReading }

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const Make(makeName: ''),
      routes: [
        GoRoute(
          path: 'make/:makeName',
          name: AppRoute.make.name,
          builder: ((context, state) {
            print(state.params.toString());
            final make = state.params["makeName"]!;
            return Make(makeName: make);
          }),
        ),
        GoRoute(
          path: 'model/:makeName/:makeId',
          name: AppRoute.model.name,
          builder: ((context, state) {
            print(state.params.toString());
            final make = state.params["makeName"]!;
            final makeId = state.params["makeId"]!;
            return Model(makeName: make, makeId: makeId);
          }),
        ),
        GoRoute(
          path: 'hpRange/:makeName/:makeId/:modelName',
          name: AppRoute.hpRange.name,
          builder: ((context, state) {
            print(state.params.toString());
            final make = state.params["makeName"]!;
            final makeId = state.params["makeId"]!;
            final modelName = state.params["modelName"]!;
            return HPRange(makeName: make, modelName: modelName, makeId: makeId);
          }),
        ),
        GoRoute(
          path: 'meterReading/:makeName/:makeId/:modelName/:hpRange',
          name: AppRoute.meterReading.name,
          builder: ((context, state) {
            print(state.params.toString());
            final make = state.params["makeName"]!;
            final makeId = state.params["makeId"]!;
            final modelName = state.params["modelName"]!;
            final hpRange = state.params["hpRange"]!;
            return MeterReading(makeName: make, makeId: makeId, modelName: modelName, hpRange: hpRange);
          }),
        ),
      ],
    )
  ],
);
