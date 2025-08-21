import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
    @EnviedField(varName: 'API_KEY', obfuscate: true)
    static String key = _Env.key;

    @EnviedField(varName: 'BASE_URL', obfuscate: true)
    static String baseUrl = _Env.baseUrl;
}