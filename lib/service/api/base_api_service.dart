import 'package:get_it/get_it.dart';
import '../network/dio_client.dart';

class BaseApiService {
  DioClient dio = GetIt.instance.get<DioClient>();
}
