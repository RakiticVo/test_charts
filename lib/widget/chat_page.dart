import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_charts/constant/app_colors.dart';
import 'package:test_charts/constant/edge_insets_custom.dart';
import 'package:test_charts/constant/svg_picture_custom.dart';
import 'package:test_charts/constant/txt_style.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  final Function callbackExpand;
  const ChatPage({super.key, required this.callbackExpand,});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final txtEdtCtrl = TextEditingController();
  bool isExpand = false;

  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  String preUserID = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMessages(false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Chat(
          messages: _messages,
          onMessageTap: (context, p1) {
            _handleMessageTap(context, p1);
          },
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          avatarBuilder: (userId) {
            return getAvatarUser(userId);
          },
          /* TODO: custom status or avatar for user */
          customStatusBuilder: (message, {required context}) {
            return Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.transparent
              ),
              child: Padding(
                padding: EdgeInsetsCustom().only(context: context, bottom: 4.0),
                child: Image.asset('assets/user.png', fit: BoxFit.fill, width: 50.0, height: 50.0,),
              ),
            );
          },
          /* TODO: custom some question or button to navigate */
          systemMessageBuilder: (p0) {
            if(p0.author.lastName == 'Bot'){
              return GestureDetector(
                onTap: (){
                  txtEdtCtrl.text = p0.text.toString();
                  setState(() {
                    types.PartialText result = types.PartialText(text: txtEdtCtrl.text.toString());
                    _handleSendPressed(result);
                    txtEdtCtrl.clear();
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsetsCustom().symmetric(context: context, horizontal: 40.0, vertical: 12.0),
                  child: Row(
                    children: [
                      Container(
                        width: 2.5,
                        height: 50.0,
                        color: AppColors.primaryBlue,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsCustom().only(context: context, left: 8.0),
                          child: Text(
                            p0.text,
                            style: TxtStyle().font14(
                              buildContext: context,
                              color: AppColors.neutral06,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }else if(p0.author.lastName == 'System'){
              return GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: 175.0,
                  height: 45.0,
                  padding: EdgeInsetsCustom().symmetric(context: context, horizontal: 8.0),
                  margin: EdgeInsetsCustom().only(context: context, left: 75.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: AppColors.primaryBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.book, color: AppColors.neutral00,),
                      Text(
                        p0.text,
                        style: TxtStyle().font14(
                          buildContext: context,
                          color: AppColors.neutral00,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_rounded, color: AppColors.neutral00,),
                    ],
                  ),
                )
              );
            }else {
              return Container();
            }
          },
          /* TODO: custom text message */
          textMessageBuilder: (p0, {required messageWidth, required showName}) {
            return Padding(
              padding: EdgeInsetsCustom().only(context: context, left: p0.author.id != _user.id ? 4.0 : 0.0, top: 12.0, ),
              child: Container(
                padding: EdgeInsetsCustom().symmetric(context: context, horizontal: 12.0, vertical: 10.0),
                decoration: BoxDecoration(
                  gradient: p0.author.id == _user.id
                    ? LinearGradient(
                      colors: [
                        AppColors.primaryBlue,
                        AppColors.secondaryBlue
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                    : null,
                  color: p0.author.id == _user.id ? null : AppColors.neutral03,
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: Text(
                  p0.text,
                  style: TxtStyle().font14(
                    buildContext: context,
                    color: p0.author.id == _user.id ? AppColors.neutral00 : AppColors.neutral07,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ),
            );
          },
          /* TODO: custom new customBottomWidget after */
          customBottomWidget: Container(),
          useTopSafeAreaInset: true,
          listBottomWidget: const SizedBox(height: 12.0,),
          theme: const DefaultChatTheme(
            primaryColor: AppColors.transparent,
            secondaryColor: AppColors.transparent,
          ),
          user: _user,
        ),
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  // void _handleFileSelection() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.any,
  //   );
  //
  //   if (result != null && result.files.single.path != null) {
  //     final message = types.FileMessage(
  //       author: _user,
  //       createdAt: DateTime.now().millisecondsSinceEpoch,
  //       id: const Uuid().v4(),
  //       mimeType: lookupMimeType(result.files.single.path!),
  //       name: result.files.single.name,
  //       size: result.files.single.size,
  //       uri: result.files.single.path!,
  //     );
  //     _addMessage(message);
  //   }
  // }

  // void _handleImageSelection() async {
  //   final result = await ImagePicker().pickImage(
  //     imageQuality: 70,
  //     maxWidth: 1440,
  //     source: ImageSource.gallery,
  //   );
  //
  //   if (result != null) {
  //     final bytes = await result.readAsBytes();
  //     final image = await decodeImageFromList(bytes);
  //
  //     final message = types.ImageMessage(
  //       author: _user,
  //       createdAt: DateTime.now().millisecondsSinceEpoch,
  //       height: image.height.toDouble(),
  //       id: const Uuid().v4(),
  //       name: result.name,
  //       size: bytes.length,
  //       uri: result.path,
  //       width: image.width.toDouble(),
  //     );
  //
  //     _addMessage(message);
  //   }
  // }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
          _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
          _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }
      await OpenFilex.open(localPath);
    }

    // if (message is types.TextMessage){
    //   if(message.text.startsWith('http')){
    //     await _launchUrl(Uri.parse(message.text));
    //   }
    // }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
    if(textMessage.text == 'Where can I find energy-efficient retailers?'){
      _messages.clear();
      _loadMessages(true);
    }
  }

  void _loadMessages(bool isAnswer) async {
    if(!isAnswer){
      final response = await rootBundle.loadString('assets/messages_bot.json');
      final messagesAnswer = (jsonDecode(response) as List)
          .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
          .toList();

      setState(() {
        _messages = messagesAnswer;
      });
    }else{
      final response = await rootBundle.loadString('assets/messages.json');
      final messagesAnswer = (jsonDecode(response) as List)
          .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
          .toList();
      _messages.addAll(messagesAnswer);
    }
  }

  // Future<void> _launchUrl(Uri uri) async {
  //   if (!await launchUrl(uri)) {
  //     throw Exception('Could not launch $uri');
  //   }
  // }

  getAvatarUser(String userID){
    for(types.Message data in _messages){
      if(data.author.id == userID){
        if(data.author.lastName == 'EBot'){
          return Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.transparent
            ),
            child: Padding(
              padding: EdgeInsetsCustom().only(context: context, bottom: 4.0),
              child: const SvgPictureCustom(width: 50.0, height: 50.0, path: 'assets/bot.svg'),
            ),
          );
        }else {
          return Container();
        }
      }
    }
  }
}