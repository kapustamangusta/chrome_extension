import 'package:dio/dio.dart';
import 'package:extension_chrome/base_card.dart';
import 'package:extension_chrome/chat_form_field.dart';
import 'package:flutter/material.dart';


class ChromePopup extends StatefulWidget {
  const ChromePopup({super.key});

  @override
  State<ChromePopup> createState() => _ChromePopupState();
}

class _ChromePopupState extends State<ChromePopup> {
  final TextEditingController _chatController = TextEditingController();

  List<String> chat = [];
  bool loading = false;
  @override
  void initState() {
    // isLoading = false;
    // summaryApiClient = SummaryApiClient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: BaseCard(
        height: 700,
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8).copyWith(bottom: 0),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: chat.length,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: index % 2 == 0
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 300,
                                  ),
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? Colors.lightBlue
                                        : Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    chat[index],
                                    style: TextStyle(
                                      color: theme.primaryTextTheme
                                          .displayMedium!.color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            loading
                ? const CircularProgressIndicator()
                : Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        side: BorderSide(
                          width: 2,
                          color: Colors.white
                        )
                      ),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                          chat.add('У кого сегодня ДР?');
                        });
                        

                        var dio = Dio();

                        final responce = await dio.get(
                          'http://localhost:5253/birthdays',
                        );
                        setState(() {
                          loading = false;
                          chat.add(responce.data.toString());
                        });
                      },
                      child: Text(
                        "Дни рождения",
                        style: TextStyle(color: theme.primaryTextTheme.bodyMedium!.color),
                      ),
                    ),
                  ),
            Container(
              padding: const EdgeInsets.all(8),
              child: ChatFormField(
                controller: _chatController,
                onClick: () {
                  setState(() {
                    chat.add(_chatController.text);
                    _chatController.clear();
                    chat.add("Cам ищи инфу");
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
