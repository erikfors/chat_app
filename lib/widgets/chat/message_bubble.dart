import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _message;
  final bool _isMe;
  final Key? key;
  final String _userName;
  final String _userImage;

  MessageBubble(this._message, this._isMe, this._userImage, this._userName,
      {this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: _isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !_isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight:
                      !_isMe ? Radius.circular(12) : Radius.circular(0),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    _userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline1!
                                .color),
                  ),
                  Text(
                    _message,
                    textAlign: _isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                        color: _isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline1!
                                .color),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: _isMe ? null : 120,
          right: _isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(_userImage),
          ),
        ),
      ],
    );
  }
}
