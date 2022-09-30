import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:kite/authentication/model/auth_user_model.dart';
import 'package:kite/chat/provider/chat_provider.dart';
import 'package:kite/chat/ui/screens/chat_screen.dart';
import 'package:kite/contact/provider/contact_provider.dart';
import 'package:kite/contact/ui/screens/contacts.dart';
import 'package:kite/shared/constants/textstyle.dart';
import 'package:kite/shared/constants/url_constants.dart';
import 'package:kite/shared/ui/widgets/custom_app_bar.dart';
import 'package:kite/util/custom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ContactListPage extends StatefulWidget {
  ContactListPage({Key? key}) : super(key: key);

  List<AuthUserModel> matchedContacts = [];
  List<Contact> phoneContacts = [];
  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final matchContact = widget.matchedContacts;
    final phoneContact = widget.phoneContacts;
    return Scaffold(
      appBar: customAppBar('Contacts', actionIcons: [Icons.search]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                // boxShadow: const [
                //   BoxShadow(
                //       offset: Offset(2, 5), color: Colors.grey, blurRadius: 20)
                // ]
              ),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.group,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 44.0),
                            child: Text("New group"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.person_add_alt,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 44.0),
                            child: Text("New contact"),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: matchContact.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 0,
                      child: Card(
                        child: GestureDetector(
                          onTap: () {
                            // value.selectUser(index, context);
                            context.read<ChatProvider>().fetchChat(context);
                            customNavigator(
                              context,
                              ChatScreen(
                                isGroupChat: false,
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      matchContact[index].userImage),
                                ),
                              ),
                              SizedBox(
                                width: 180,
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Text(
                                    style: const TextStyle(color: Colors.black),
                                    matchContact[index].userName,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.phone),
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.video_call,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhoneContacts(
                            phoneContacts: phoneContact,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 44.0),
                              child: Text("Invite"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.help,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 44.0),
                            child: Text("Contact us"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    color: Colors.grey.shade300,
                    padding: EdgeInsets.only(left: 2.w, top: 2.w, bottom: 2.w),
                    child: Text(
                      'People on kite',
                      style: text2,
                    ),
                  )
                ],
              ),
            ),
            Consumer<ContactProvider>(builder: (context, value, widget) {
              value.finalContacts.sort(
                (a, b) => a.userName.compareTo(b.userName),
              );
              return Column(
                children: [
                  // AzListView(data: ['wd','asdas'], itemCount: value.finalContacts.length, itemBuilder: ((context, index) {
                  //       AuthUserModel userModel =
                  //           value.finalContacts.elementAt(index);
                  //       return Padding(
                  //         padding: EdgeInsets.only(top: 0.5.h),
                  //         child: ListTile(
                  //           // shape: const UnderlineInputBorder(
                  //           //     borderSide: BorderSide(color: Colors.grey)),
                  //           leading: CircleAvatar(
                  //             child:
                  //                 // userModel.userImage != null
                  //                 //     ? Image.asset(userModel.userImage)
                  //                 // :
                  //                 Icon(Icons.person),
                  //           ),
                  //           title: Text(userModel.userName),
                  //           trailing: SizedBox(
                  //             width: 35.w,
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Material(
                  //                   shape: const CircleBorder(),
                  //                   elevation: 10,
                  //                   child: CircleAvatar(
                  //                     child: IconButton(
                  //                         onPressed: () {},
                  //                         icon: const Icon(Icons.edit)),
                  //                   ),
                  //                 ),
                  //                 Material(
                  //                   shape: const CircleBorder(),
                  //                   elevation: 10,
                  //                   child: CircleAvatar(
                  //                     child: IconButton(
                  //                         onPressed: () {},
                  //                         icon: const Icon(Icons.call)),
                  //                   ),
                  //                 ),
                  //                 Material(
                  //                   shape: const CircleBorder(),
                  //                   elevation: 10,
                  //                   child: CircleAvatar(
                  //                     child: IconButton(
                  //                         onPressed: () {},
                  //                         icon: const Icon(Icons.video_call)),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     })),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.finalContacts.length,
                      itemBuilder: ((context, index) {
                        AuthUserModel userModel =
                            value.finalContacts.elementAt(index);
                        return Padding(
                          padding: EdgeInsets.only(top: 0.5.h),
                          child: ListTile(
                            onTap: () {
                              context
                                  .read<ChatProvider>()
                                  .selectUser(index, context, true, userModel);
                              customNavigator(
                                  context, ChatScreen(isGroupChat: false));
                            },
                            // shape: const UnderlineInputBorder(
                            //     borderSide: BorderSide(color: Colors.grey)),
                            leading: userModel.userImage != null
                                ? CircleAvatar(
                                    child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      '$imgUrl/${userModel.userImage}',
                                      fit: BoxFit.contain,
                                    ),
                                  ))
                                : const CircleAvatar(
                                    child: Icon(Icons.person),
                                  ),
                            title: Text(userModel.userName),
                            trailing: SizedBox(
                              width: 35.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Material(
                                    shape: const CircleBorder(),
                                    elevation: 10,
                                    child: CircleAvatar(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.edit)),
                                    ),
                                  ),
                                  Material(
                                    shape: const CircleBorder(),
                                    elevation: 10,
                                    child: CircleAvatar(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.call)),
                                    ),
                                  ),
                                  Material(
                                    shape: const CircleBorder(),
                                    elevation: 10,
                                    child: CircleAvatar(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.video_call)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
