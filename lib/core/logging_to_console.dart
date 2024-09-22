import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class LoggingToConsoleListener {
  StreamSubscription<LogRecord> listen(Logger logger) {
    return logger.onRecord.listen((record) {
      final fineLevel = Level.FINE.value;
      final warningLevel = Level.WARNING.value;

      var message = _recordToString(record);

      if (kDebugMode) {
        // Set colors for different messages
        if (record.level.value == fineLevel) {
          // Green
          message = '\x1B[32m$message\x1B[0m';
        } else if (record.level.value < warningLevel) {
          // White
          message = '\x1B[37m$message\x1B[0m';
        } else if (record.level.value == warningLevel) {
          // Yellow
          message = '\x1B[33m$message\x1B[0m';
        } else if (record.level.value > warningLevel) {
          // Red
          message = '\x1B[31m$message\x1B[0m';
        }

        log(message);
      } else {
        // ignore: avoid_print
        print(message);
      }
    });
  }

  String _recordToString(LogRecord record) {
    final log = StringBuffer()
      ..writeAll(
        <String>[
          '[${record.level.name}]',
          if (record.loggerName.isNotEmpty) '${record.loggerName}:',
          record.message,
        ],
        ' ',
      );

    if (record.error != null) {
      log.write('\n${record.error}');
    }
    if (record.stackTrace != null) {
      log.write('\n${record.stackTrace}');
    }

    return log.toString();
  }
}
