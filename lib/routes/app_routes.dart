// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:test_pkl/bottom_navbar.dart';
// import 'package:test_pkl/routes/route_names.dart';
// import 'package:test_pkl/screens/add_activity.dart';
// import 'package:test_pkl/screens/login_screen.dart';
//
// class AppRoutes {
//   static final router = GoRouter(
//
//     initialLocation: RouteNames.login,
//     errorPageBuilder: (context, state) {
//       return MaterialPage(
//         child: Text(
//           'Error!!!',
//         ),
//       );
//     },
//     routes: [
//       GoRoute(
//         path: '/login',
//         name: RouteNames.login,
//         builder: (context, state) => LoginScreen(),
//       ),
//       GoRoute(
//         path: '/',
//         name: RouteNames.home,
//         builder: (context, state) => BottomNavBar(),
//         routes: [
//           GoRoute(
//             path: 'addActivity',
//             name: RouteNames.addActivity,
//             builder: (context, state) => AddActivity(),
//           ),
//         ],
//       ),
//     ],
//   );
// }
