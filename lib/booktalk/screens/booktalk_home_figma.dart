import 'package:flutter/material.dart';

class FigmaHomePage extends StatelessWidget {
  final String title;

  const FigmaHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          "assets/Cover.png",
                                          width: 150,
                                          height: 225,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Book Title",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    Text("Book Author",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/Cover.png",
                                      width: 150,
                                      height: 225,
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("Book Title",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    )),
                                Text("Book Author",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/Cover.png",
                                      width: 150,
                                      height: 225,
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("Book Title",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    )),
                                Text("Book Author",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text("Load More",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ))
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 16,
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Text("BookTalk",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            )),
                        Row(
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 20.31399917602539,
                                          height: 20.31399917602539,
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 21,
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text("Review a Book",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                )),
                            Column(
                              children: [],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
