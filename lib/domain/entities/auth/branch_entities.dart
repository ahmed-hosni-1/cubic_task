class BranchEntities {
  final String branchId;
  final String branchCode;
  final String branchName;
  final String? branchNameAr;
  final String? branchCity;
  final String? branchLat;
  final String? branchLng;
  final String? branchAddress;
  final String? branchCountryCode;
  final int branchStatus;

  BranchEntities(
      {required this.branchId,
      required this.branchCode,
      required this.branchName,
      this.branchNameAr,
      this.branchCity,
      this.branchLat,
      this.branchLng,
      this.branchAddress,
      this.branchCountryCode,
      required this.branchStatus});
}

// "branchid": "a1ccbeec-80d7-ec11-b80e-000c292f8ca0",
// "branchcode": "1",
// "branchname": "Cairo",
// "branchnamear": null,
// "branchcity": null,
// "branchlat": null,
// "branchlng": null,
// "branchaddress": null,
// "branchcountrycode": null,
// "branchstatus": 1
