import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  final List<Map<String, String>> myList = [];
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  //save
  void saveButton() {
    setState(() {
      myList.add({
        'name': nameController.text,
        'age': ageController.text,
      });
    });
    ageController.clear();
    nameController.clear();
    print(myList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              height: 250,
              width: double.maxFinite,
              //  color: Colors.amber,
              child: ListView(
                children: [
                  ListTile(
                    title: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        hintText: "Name",
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    title: TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        hintText: "Age",
                        border: UnderlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: saveButton,
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue[100]),
                      child: Center(
                          child: Text(
                        " Save to Hive",
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: myList.length,
              addAutomaticKeepAlives: true,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Colors.blue[50],
                  leading: InkWell(onTap: () {}, child: Icon(Icons.edit)),
                  title: Text(myList[index]['name'].toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                  subtitle: Text(myList[index]['age'].toString(),
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                  trailing: InkWell(
                    onTap: () {
                      setState(() {
                        print(myList.toString());
                        myList.removeAt(index);
                        print(myList.toString());
                      });
                    },
                    child: Icon(
                      Icons.delete,
                      // color: Colors.black,
                      size: 30,
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
