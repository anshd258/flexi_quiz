import 'package:dio/dio.dart';
import 'package:flexi_quiz/core/constants/apiendpoints.dart';
import 'package:flexi_quiz/core/log/logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

final dio = Dio(
  BaseOptions(baseUrl: Apiendpoints.baseurl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  }),
)..interceptors.add(TalkerDioLogger(
    talker: talker,
    settings: const TalkerDioLoggerSettings(
      printErrorMessage: true,
      printRequestData: true,
      printResponseMessage: true,
      printResponseData: false,
    )));
