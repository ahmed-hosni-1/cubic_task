import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class WebService {

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://demo03.cubicsystems.com:8443/CVM/CVMAPIs/',
    ),
  );
}
