class ApiConstants {
  //Define variable as static const var_name = value;
//   ///BASE URL.....
  static const baseURL = "https://dev.on-fire.com:5050/api/v1/app/";
//   static const statusCodeOk = 200;
//   static const statusCodeOk1 = 201;
//   static const statusCodeError = 401;
//   static const messageError = "jwt expired";

//   ///AUTHENTICATION URL...
  static const String beforeSignInUrl = baseURL + "auth/login";
  static const String apiConfigUrl = baseURL + "config";
  static const String logInUrl = baseURL + "auth/login/check";
  static const String logOutUrl = baseURL + "auth/logout";
  static const String treeListUrl = baseURL + "tree/list?t=5";
  static const String profileInfoUrl = baseURL + "user/profile";
  static const String getDateForCalendarUrl = baseURL + "meetings/dates";
  static const String getTimeSlotForCalendarUrl = baseURL + "meetings/slots";
  static const String createMettingUrl = baseURL + "meetings/";
  static const String deleteMettingUrl = baseURL + "meetings/";
  static const String deleteMettingImagesUrl = baseURL + "meetings/";
  static const String userQueueStatusUrl = baseURL + "queue/status";
  static const String userStatusUrl = baseURL + "user/status";
  static const String mettingDetailsUrl = baseURL + "meetings/";
}
