import 'package:flutter/material.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("kljlkjlkj"),
          actions: [
            Icon(Icons.search_rounded),
            SizedBox(width: 15),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.brightness_4_outlined)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Text("data"),
            Container(
              height: 3,
              width: double.infinity,
            ),
            Icon(Icons.access_time),
            SizedBox(height: 30),
            const Image(
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2dVbLMzlaeJnL5C6RpZ8HLRECJhH6ILEGKg&s"),
            ),
            SizedBox(height: 30),
            const Row(
              children: [
                Text("data"),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            Text("data"),
            Container(
              height: 3,
              width: double.infinity,
            ),
            Icon(Icons.access_time),
            SizedBox(height: 30),
            Image(
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2dVbLMzlaeJnL5C6RpZ8HLRECJhH6ILEGKg&s"),
            ),
            SizedBox(height: 30),
            const Row(
              children: [
                Text("data"),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            Text("data"),
            Container(
              height: 3,
              width: double.infinity,
            ),
            Icon(Icons.access_time),
            SizedBox(height: 30),
            Image(
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2dVbLMzlaeJnL5C6RpZ8HLRECJhH6ILEGKg&s"),
            ),
            SizedBox(height: 30),
            const Row(
              children: [
                Text("data"),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            Text("data"),
            Container(
              height: 3,
              width: double.infinity,
            ),
            Icon(Icons.access_time),
            SizedBox(height: 30),
            Image(
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2dVbLMzlaeJnL5C6RpZ8HLRECJhH6ILEGKg&s"),
            ),
            SizedBox(height: 30),
            const Row(
              children: [
                Text("data"),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded),
                SizedBox(
                  width: 15,
                )
              ],
            )
          ]),
        ));
  }
}
