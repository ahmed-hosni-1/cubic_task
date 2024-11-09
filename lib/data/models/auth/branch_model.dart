import '../../../domain/entities/auth/branch_entities.dart';

class BranchModel {
  BranchModel({
    this.success,
    this.result,
    this.message,
  });

  BranchModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((element) {
        result?.add(Result.fromJson(element));
      });
    }
    message = json['message'];
  }
  bool? success;
  List<BranchEntities>? result;
  String? message;
}

class Result extends BranchEntities {
  Result({
    required super.branchId,
    required super.branchCode,
    required super.branchStatus,
    required super.branchName,
    super.branchNameAr,
    super.branchCity,
    super.branchLat,
    super.branchLng,
    super.branchAddress,
    super.branchCountryCode,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      branchId: json['branchid'],
      branchCode: json['branchcode'],
      branchStatus: json['branchstatus'],
      branchName: json['branchname'],
      branchNameAr: json['branchnamear'],
      branchCity: json['branchcity'],
      branchLat: json['branchlat'],
      branchLng: json['branchlng'],
      branchAddress: json['branchaddress'],
      branchCountryCode: json['branchcountrycode'],
    );
  }
}
