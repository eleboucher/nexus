import "dart:io";

Future<String> getXCodeTool({String? sdkType, String? findTool}) async {
  final result = await Process.run("xcrun", [
    if (sdkType != null) ...["--sdk", sdkType],
    if (findTool != null) ...["-f", findTool] else "--show-sdk-path",
  ]);

  if (result.exitCode != 0) {
    throw Exception("Failed to run xcrun\n${result.stderr}");
  }

  return result.stdout.toString().trim();
}
