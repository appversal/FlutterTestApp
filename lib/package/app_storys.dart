// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AppStorys {
//   Future<Map<String, dynamic>> verifyApp(String appId, String accountId) async {
//     final url = Uri.parse(
//         'https://backend.appstorys.com/api/v1/users/validate-account/');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "app_id": appId,
//         "account_id": accountId,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to verify app');
//     }
//   }

//   Future<Map<String, dynamic>> verifyScreen(
//       String token, String appId, String screenName) async {
//     final url =
//         Uri.parse('https://backend.appstorys.com/api/v1/users/track-screen/');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode({
//         "app_id": appId,
//         "screen_name": screenName,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to verify screen');
//     }
//   }

//   Future<Map<String, dynamic>> verifyUser(String token, String userId,
//       String appId, List<dynamic> campaignList) async {
//     final url =
//         Uri.parse('https://backend.appstorys.com/api/v1/users/track-user/');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode({
//         "user_id": userId,
//         "app_id": appId,
//         "campaign_list": campaignList,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to verify user');
//     }
//   }

//   Future<void> userActionTrack(String token, String campaignId, String userId,
//       String eventType, String storySlide) async {
//     final url =
//         Uri.parse('https://backend.appstorys.com/api/v1/users/track-action/');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode({
//         "campaign_id": campaignId,
//         "user_id": userId,
//         "event_type": eventType,
//         "story_slide": storySlide,
//       }),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to track user action');
//     }
//   }
// }
