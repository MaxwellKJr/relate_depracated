import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:relate/constants/colors.dart';
import 'package:relate/constants/image_strings.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentCard extends StatefulWidget {
  final String userName, commentBody;
  final Timestamp timestamp;

  const CommentCard(
      {super.key,
      required this.userName,
      required this.commentBody,
      required this.timestamp});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    /// Format date
    final dateTime = widget.timestamp.toDate();

    final daysAgo = timeago.format(dateTime, locale: 'en_short');
    final formattedDate = DateFormat.yMMMMEEEEd().format(dateTime);
    final formattedTime = DateFormat.Hm().format(dateTime);

    final formattedDateTime = "$formattedDate $formattedTime";

    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!, // Set the color of the border
            width: 1.0, // Set the width of the border
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Colors.pink, // Customize the background color
                        child: Text(
                          widget.userName.substring(
                              0, 1), // Get the first character of the userName
                          style: const TextStyle(
                              color: Colors.white), // Customize the text color
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            widget.commentBody,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isClicked = !isClicked;
                              });
                            },
                            child: isClicked
                                ? const Icon(
                                    Icons.favorite,
                                    size: 18,
                                    color: primaryColor,
                                  )
                                : const Icon(
                                    Icons.favorite_outline,
                                    size: 18,
                                  ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      )
                    ],
                  ),
                  Text(
                    daysAgo,
                    style: const TextStyle(fontSize: 13, color: primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
