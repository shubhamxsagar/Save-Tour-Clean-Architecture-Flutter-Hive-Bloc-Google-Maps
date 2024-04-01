import 'package:arpan/core/router/router_constants.dart';
import 'package:arpan/features/home/screens/home_screen.dart';
import 'package:arpan/features/login/presentation/screens/login_screen.dart';
import 'package:arpan/features/login/presentation/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class MyAppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
          name: RouterConstants.login,
          path: '/',
          pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
          routes: [
            GoRoute(
              name: RouterConstants.otp,
              path: 'otp/:phoneNo',
              pageBuilder: (context, state) => MaterialPage(
                  child: OtpScreen(
                phoneNo: state.pathParameters['phoneNo']!,
              )),
            ),
          ]),
      GoRoute(
        name: RouterConstants.home,
        path: '/home',
        pageBuilder: (context, state) => MaterialPage(
          child: HomeScreen(),
        ),
      ),
    ],
    redirect: (context, state) async {
      // MapmyIndiaAccountManager.setMapSDKKey('c6876b5d49ea97ff0366db60c1a29101');
      // MapmyIndiaAccountManager.setRestAPIKey(
      //     '5b2e3184-e88f-461f-822b-5815916beb86');
      // MapmyIndiaAccountManager.setAtlasClientId(
      //     '33OkryzDZsKEFnf9yRf7eRIFb2Gs2lN8IGYGFbqi1XIQtnEZRV8ikcAp8EMDLl4FE4YZT2emB-OUPy_Dg22YrA==');
      // MapmyIndiaAccountManager.setAtlasClientSecret(
      //     'lrFxI-iSEg9ZYTcs35Vdtc0VMG_0jXwFFGMcxjJfcmcDcoJTbi-5cN5HhLHFyqJeLwfkhEzllG4xKPvmVZc-oosGOq9NaCns');
    },
  );
}
