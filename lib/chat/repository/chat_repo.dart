import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:kite/chat/model/chat_model.dart';
import 'package:kite/chat/model/send_message_model.dart';
import 'package:kite/shared/constants/url_constants.dart';

class ChatRepo {
  final parser = EmojiParser();
  final String _chatApi = '$baseUrl/Kiteapi_controller';

  Future<List<ChatModel>> fetchChatBySenderId(String senderId) async {
    List<ChatModel> list = [];
    String url = '$_chatApi/show_msg_senderid';

    try {
      Response response = await Dio().post(url, data: {"sender_id": senderId});
      if (response.data['status'] == 1) {
        for (Map<String, dynamic> map in response.data['txt_msg']) {
          ChatModel chat = ChatModel.fromMap(map);
          list.add(chat);
        }
      }
      return list;
    } on DioError {
      rethrow;
    }
  }

  Future<List<ChatModel>> fetchChatByReceiverId(String receiverId) async {
    List<ChatModel> list = [];
    String url = '$_chatApi/show_msg_receiverid';

    try {
      Response response =
          await Dio().post(url, data: {"receiver_id": receiverId});
      if (response.data['status'] == 1) {
        for (Map<String, dynamic> map in response.data['txt_msg']) {
          ChatModel chat = ChatModel.fromMap(map);
          list.add(chat);
        }
      }
      return list;
    } on DioError {
      rethrow;
    }
  }

  Future<List<ChatModel>> fetchChatBySenderAndReceiver(
      String senderId, String receiverId) async {
    List<ChatModel> list = [];
    String url = '$_chatApi/show_msg_by_sr';
    try {
      Response response = await Dio()
          .post(url, data: {"sender_id": senderId, "receiver_id": receiverId});
      if (response.data['status'] == 1) {
        for (Map<String, dynamic> map in response.data['txt_msg']) {
          print('contacts - ${map['contacts']}');
          ChatModel chat = ChatModel.fromMap(map);
          // bool hasEmoji = parser.hasEmoji(chat.textMasseg);
          // print("hasEmoji - $hasEmoji");
          print(chat.emojiMessage);
          list.add(chat);
        }
      }
      return list;
    } on DioError {
      rethrow;
    }
  }

  Future<void> sendMessage(SendChatModel chatModel) async {
    String url = '$_chatApi/userone_reply_usertwo';
    try {
      Response response = await Dio().post(url, data: chatModel.toMap());
      log(response.toString());
    } on DioError {
      rethrow;
    }
  }

  Future<void> sendEmoji(SendChatModel chatModel) async {
    String url1 = '$_chatApi/send_mems_msg';
    bool hasEmoji = parser.hasEmoji(chatModel.textMasseg);
    Emoji emojis = parser.getEmoji(chatModel.textMasseg);
    print("emoji - ${chatModel.textMasseg}");
    try {
      Response response = await Dio().post(url1, data: chatModel.toMap());
      log(response.toString());
    } on DioError {
      rethrow;
    }
  }

  Future<bool> sendAudio(
    String userSenderId,
    String userSenderRegNo,
    String userSenderNumber,
    String userSenderrName,
    String userReceiverId,
    String userReceiverRegNo,
    String userReceiverNumber,
    String userReceiverName,
    String audio,
  ) async {
    String url = '$_chatApi/send_audio_msg';
    print("audio");
    print(audio);
    // if (audio == "") {
    //   return false;
    // }
    String audioName = audio.split('/').last;

    try {
      FormData formData = FormData.fromMap({
        // 'firebase_id': user.firebaseId,
        'user_sender_id': userSenderId,
        'user_sender_reg_no': userSenderRegNo,
        'user_sender_number': userReceiverNumber,
        'user_sender_name': userSenderrName,
        'user_receiver_id': userReceiverId,
        'user_receiver_reg_no': userSenderRegNo,
        'user_receiver_number': userReceiverNumber,
        'user_receiver_name': userReceiverName,
        'audio': await MultipartFile.fromFile(audio, filename: audioName)
      });
      Response response = await Dio().post(url,
          data: formData,
          options: Options(
              followRedirects: false,
              // will not throw errors
              validateStatus: (status) => true,
              headers: {'Connection': 'keep-alive'}));
      // String res = response.toString();
      print(response.statusCode);
      // print(response.data['status']);

      return response.statusCode == 200;
    } on DioError {
      rethrow;
    }
  }

  Future<bool> sendLocation(
    String userSenderId,
    String userSenderRegNo,
    String userSenderNumber,
    String userSenderrName,
    String userReceiverId,
    String userReceiverRegNo,
    String userReceiverNumber,
    String userReceiverName,
    String audio,
  ) async {
    String url = '$_chatApi/send_location';
    print("audio");
    print(audio);
    // if (audio == "") {
    //   return false;
    // }
    String audioName = audio.split('/').last;

    try {
      FormData formData = FormData.fromMap({
        // 'firebase_id': user.firebaseId,
        'user_sender_id': userSenderId,
        'user_sender_reg_no': userSenderRegNo,
        'user_sender_number': userReceiverNumber,
        'user_sender_name': userSenderrName,
        'user_receiver_id': userReceiverId,
        'user_receiver_reg_no': userSenderRegNo,
        'user_receiver_number': userReceiverNumber,
        'user_receiver_name': userReceiverName,
        'location': await MultipartFile.fromFile(audio, filename: audioName)
      });
      Response response = await Dio().post(url,
          data: formData,
          options: Options(
              followRedirects: false,
              // will not throw errors
              validateStatus: (status) => true,
              headers: {'Connection': 'keep-alive'}));
      // String res = response.toString();
      print(response.statusCode);
      // print(response.data['status']);

      return response.statusCode == 200;
    } on DioError {
      rethrow;
    }
  }

  Future<bool> sendContact(
    String userSenderId,
    String userSenderRegNo,
    String userSenderNumber,
    String userSenderrName,
    String userReceiverId,
    String userReceiverRegNo,
    String userReceiverNumber,
    String userReceiverName,
    String contact,
  ) async {
    String url = 'http://44.209.72.97/kite/Kiteapi_controller/send_contacts';
    print("contact - $contact");
    // if (audio == "") {
    //   return false;
    // }

    try {
      FormData formData = FormData.fromMap({
        // 'firebase_id': user.firebaseId,
        'user_sender_id': userSenderId,
        'user_sender_reg_no': userSenderRegNo,
        'user_sender_number': userReceiverNumber,
        'user_sender_name': userSenderrName,
        'user_receiver_id': userReceiverId,
        'user_receiver_reg_no': userSenderRegNo,
        'user_receiver_number': userReceiverNumber,
        'user_receiver_name': userReceiverName,
        'contacts': contact
      });
      Response response = await Dio().post(url,
          data: formData,
          options: Options(
              followRedirects: false,
              // will not throw errors
              validateStatus: (status) => true,
              headers: {'Connection': 'keep-alive'}));
      // String res = response.toString();
      print(response.statusCode);
      // print(response.data['status']);

      return response.statusCode == 200;
    } on DioError {
      rethrow;
    }
  }

  Future<bool> sendImage(
    String userSenderId,
    String userSenderRegNo,
    String userSenderNumber,
    String userSenderrName,
    String userReceiverId,
    String userReceiverRegNo,
    String userReceiverNumber,
    String userReceiverName,
    String image,
  ) async {
    String url = '$_chatApi/send_image_msg';
    print("Image");
    print(image);
    // if (audio == "") {
    //   return false;
    // }
    String imageName = image.split('/').last;

    try {
      FormData formData = FormData.fromMap({
        // 'firebase_id': user.firebaseId,
        'user_sender_id': userSenderId,
        'user_sender_reg_no': userSenderRegNo,
        'user_sender_number': userReceiverNumber,
        'user_sender_name': userSenderrName,
        'user_receiver_id': userReceiverId,
        'user_receiver_reg_no': userSenderRegNo,
        'user_receiver_number': userReceiverNumber,
        'user_receiver_name': userReceiverName,
        'files': await MultipartFile.fromFile(image, filename: imageName)
      });
      Response response = await Dio().post(url,
          data: formData,
          options: Options(
              followRedirects: false,
              // will not throw errors
              validateStatus: (status) => true,
              headers: {'Connection': 'keep-alive'}));
      print("Response");
      print(response.data);

      return response.statusCode == 200;
    } on DioError {
      rethrow;
    }
  }

  Future<bool> sendDoc(
    String userSenderId,
    String userSenderRegNo,
    String userSenderNumber,
    String userSenderrName,
    String userReceiverId,
    String userReceiverRegNo,
    String userReceiverNumber,
    String userReceiverName,
    String file,
  ) async {
    String url = '$_chatApi/send_documents_files';
    print(file);
    // if (audio == "") {
    //   return false;
    // }
    String fileName = file.split('/').last;

    try {
      FormData formData = FormData.fromMap({
        // 'firebase_id': user.firebaseId,
        'user_sender_id': userSenderId,
        'user_sender_reg_no': userSenderRegNo,
        'user_sender_number': userReceiverNumber,
        'user_sender_name': userSenderrName,
        'user_receiver_id': userReceiverId,
        'user_receiver_reg_no': userSenderRegNo,
        'user_receiver_number': userReceiverNumber,
        'user_receiver_name': userReceiverName,
        'documents': await MultipartFile.fromFile(file, filename: fileName)
      });
      Response response = await Dio().post(url,
          data: formData,
          options: Options(
              followRedirects: false,
              // will not throw errors
              validateStatus: (status) => true,
              headers: {'Connection': 'keep-alive'}));
      print("Response");
      print(response.data);

      return response.statusCode == 200;
    } on DioError {
      rethrow;
    }
  }
}
