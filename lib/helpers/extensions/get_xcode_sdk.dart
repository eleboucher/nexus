import "dart:io";

Future<String> _runXcrun(List<String> args, String errorContext) async {
  final result = await Process.run("xcrun", args);

  if (result.exitCode != 0) {
    throw Exception("Failed to $errorContext\n${result.stderr}");
  }

  return result.stdout.toString().trim();
}

Future<String> getXCodeSDK({String? sdkType}) => _runXcrun([
  if (sdkType != null) ...["--sdk", sdkType],
  "--show-sdk-path",
], "get XCode SDK");

Future<String> getXCodeClang({String? sdkType}) => _runXcrun([
  if (sdkType != null) ...["--sdk", sdkType],
  "-f",
  "clang",
], "get XCode clang");
