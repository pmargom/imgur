import 'package:flutter/foundation.dart';
import 'package:imgur/core/logging_to_console.dart';
import 'package:logging/logging.dart';

void setupLogger() {
  Logger.root.level = Level.ALL;
  LoggingToConsoleListener().listen(Logger.root);

  if (!kDebugMode) {
    Logger.root.level = Level.INFO;
  }

  final flutterErrorLogger = Logger('FlutterError');
  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);

    flutterErrorLogger.warning(
      details.summary.name,
      details.exception,
      details.stack,
    );
  };
}
