import 'package:flutter/material.dart';
import 'package:myapp/Screens/home.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width - 40,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    hintText: 'Search City',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Container(
                height: 50,
                margin: EdgeInsets.all(20),
                width: MediaQuery.sizeOf(context).width - 40,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage(CityName: _controller.text);
                        },
                      ));
                     
                    },
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    )))
          ],
        ),
      ),
    );
  }
}
