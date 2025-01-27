import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'package:fpdart/fpdart.dart';

import '../erorr/failure.dart';
import 'netowrk_exception.dart';

// Define a utility function to handle exceptions and return an Either type
Future<Either<Failure, T>> executeTryAndCatchForRepository<T>(
    Future<T> Function() action) async {
  try {
    final result = await action();
    return right(result);
  } on FormatException catch (e) {
    return left(Failure('Error parsing data: ${e.message}'));
  } on NoInternetException catch (e) {
    return left(Failure(e.message));
  } on DioException catch (e) {
    return left(Failure(_handleDioError(e)));
  } on TypeError catch (e) {
    return left(Failure(
        'Type error: ${e.toString()}. This might be due to incorrect data structure.'));
  } on NoSuchMethodError catch (e) {
    return left(Failure(
        'Method not found: ${e.toString()}. This might be due to missing fields in the data.'));
  } catch (e) {
    print('Caught exception: ${e.hashCode} - ${e.toString()}');
    if (e is TimeoutException) {
      return left(Failure('Operation timed out: ${e.message}'));
    } else if (e is SocketException) {
      return left(Failure('Network error: ${e.message}'));
    } else {
      return left(Failure('An unexpected error occurred: ${e.toString()}'));
    }
  }
}

Future<T> executeTryAndCatchForDataLayer<T>(Future<T> Function() action) async {
  try {
    var check = await Connectivity().checkConnectivity();

    if (check == ConnectivityResult.mobile ||
        check == ConnectivityResult.wifi) {
      return await action();
    } else {
      throw NoInternetException();
    }
  } on DioException catch (e) {
    throw Exception(_handleDioError(e));
  } on TimeoutException catch (e) {
    throw Exception('Operation timed out: ${e.message}');
  } on SocketException catch (e) {
    throw Exception('Network error: ${e.message}');
  } on FormatException catch (e) {
    throw FormatException('Error parsing data: ${e.message}');
  } catch (e) {
    throw Exception('An unexpected error occurred: ${e.toString()}');
  }
}

String _handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout';
    case DioExceptionType.sendTimeout:
      return 'Send timeout';
    case DioExceptionType.receiveTimeout:
      return 'Receive timeout';
    case DioExceptionType.badCertificate:
      return 'Bad certificate';
    case DioExceptionType.badResponse:
      return _handleBadResponse(error.response?.statusCode);
    case DioExceptionType.cancel:
      return 'Request cancelled';
    case DioExceptionType.connectionError:
      return 'Connection error';
    case DioExceptionType.unknown:
      if (error.error is SocketException) {
        return 'No internet connection';
      }
      return 'Unexpected error occurred';
  }
}

String _handleBadResponse(int? statusCode) {
  switch (statusCode) {
    case 400:
      return 'Bad request';
    case 401:
      return 'Unauthorized';
    case 403:
      return 'Forbidden';
    case 404:
      return 'Not found';
    case 422:
      return 'Validation error';
    case 500:
      return 'Internal server error';
    case 502:
      return 'Bad gateway';
    case 503:
      return 'Service unavailable';
    default:
      return 'Server error';
  }
}
