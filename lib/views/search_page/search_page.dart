import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/views/homepage/homepage.dart';

import '../../provider/whether_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WhetherProvider weatherController = Provider.of(context);
    WhetherProvider weatherControllerFalse =
        Provider.of(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45, left: 15),
            child: Container(
              height: 45,
              width: 330,
              decoration: BoxDecoration(
                  color: const Color(0xff54556c),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(color: Color(0xff54556c), blurRadius: 10)
                  ]),
              child: Container(
                child: TextField(
                  controller: weatherController.textEditingController,
                  onChanged: (value) {
                    weatherControllerFalse.searchApi(value);
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: Colors.white),
                    suffixIcon: IconButton(
                        onPressed: () {
                          weatherController.fetchData();
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const Homepage(),
                          ));
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
