// To parse this JSON data, do
//
//     final responseError = responseErrorFromJson(jsonString);

import 'dart:convert';

class ResponseError {
    String timestamp;
    int status;
    String error;
    String message;
    String trace;
    String path;

    ResponseError({
        this.timestamp,
        this.status,
        this.error,
        this.message,
        this.trace,
        this.path,
    });

    factory ResponseError.fromRawJson(String str) => ResponseError.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
        timestamp: json["timestamp"],
        status: json["status"],
        error: json["error"],
        message: json["message"],
        trace: json["trace"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "status": status,
        "error": error,
        "message": message,
        "trace": trace,
        "path": path,
    };
}
