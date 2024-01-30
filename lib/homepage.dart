import 'package:flutter/material.dart';
import 'package:universitydatamvvm/viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ViewModel viewModel = ViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('University Data'),
      ),
      body: Center(
        child:

        FutureBuilder(
          future: viewModel.getData(),
          builder: (context, AsyncSnapshot<List<Model>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  _launchURL() async {
                    Uri _url = Uri.parse("https://www.google.com/");
                    if (await launchUrl(_url)) {
                      await launchUrl(_url);
                    } else {
                      throw 'Could not launch $_url';
                    }
                  }
                  return Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 2,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("University Name - ${snapshot.data![index].name!}"),
                          Text("Alpha Two Code - ${snapshot.data![index]..alphaTwoCode!}"),
                          Text("Domains - ${snapshot.data![index]..domains![0]}"),
                          // Text("Webpage - ${data.webPages![0]}"),
                          Text("Country - ${snapshot.data![index]..country!}"),
                          InkWell(
                            onTap: _launchURL,
                            child:  Text(
                              " ${snapshot.data![index].webPages![0]}",
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),


      ),
    );
  }
}

