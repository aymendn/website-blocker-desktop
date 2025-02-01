import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';


abstract class RouteUtils {


  static String routeName(String? name, String path) {
    if (name != null) return name;
    final parts = path.split('/');
    if (parts.length == 1) return parts.last;
    if (parts.last.contains(':')) {
      // remove last part and call recursively
      parts.removeLast();
      return routeName(null, parts.join('/'));
    }
    return parts.last;
  }

  static FutureOr<String?> redirect({
    required String path,
    required String? name,
    required Ref ref,
  }) async {
    // final initialRoute = ref.read(initialRouteProvider);

    // final routeName = RouteUtils.routeName(name, path);

    return null;
  }
}
