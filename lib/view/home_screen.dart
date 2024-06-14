import 'package:flutter/material.dart';
import 'package:hive_crud/controller/hive_boxess.dart';
import 'package:hive_crud/model/person.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /* List<Person> sortedPersonList = [];
  void LoadAndSort() {
    final persons = boxPersons.values.toList().cast<Person>();
    persons.sort((a, b) => a.age.compareTo(b.age)); // Sort by age
    setState(() {
      sortedPersonList = persons;
    });
  }

  @override
  void initState() {
    super.initState();
    LoadAndSort();
  } */

  //
  final nameContoller = TextEditingController();
  final ageContoller = TextEditingController();
  //
  final nameEditContoller = TextEditingController();
  final ageEditContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Hive Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              // height: 300,
              width: double.infinity,
              //color: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameContoller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Name",
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: ageContoller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Name",
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        setState(() {
                          boxPersons.put(
                            'key)_${nameContoller.text} ',
                            Person(
                              name: nameContoller.text,
                              age: int.parse(ageContoller.text),
                            ),
                          );
                        });
                        nameContoller.clear();
                        ageContoller.clear();
                      },
                      child: Text("save"),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  // LoadAndSort();
                });
                //
              },
              icon: Icon(Icons.sort),
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              child: ListView.builder(
                  itemCount: boxPersons.length,
                  itemBuilder: (context, index) {
                    // Person person = sortedPersonList[index];
                    Person person = boxPersons.getAt(index);
                    return ListTile(
                      title: Text(person.name),
                      subtitle: Text(person.age.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              nameEditContoller.text = person.name;
                              ageEditContoller.text = person.age.toString();
                              Scaffold.of(context).showBottomSheet(
                                (context) => Container(
                                  // height: 200,
                                  color: Colors.amber.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          controller: nameEditContoller,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),

                                            // hintText: "Name",
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        TextFormField(
                                          controller: ageEditContoller,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 40),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              style: ButtonStyle(),
                                              onPressed: () {
                                                setState(() {
                                                  boxPersons.putAt(
                                                      index,
                                                      Person(
                                                        name: nameEditContoller
                                                            .text,
                                                        age: int.parse(
                                                            ageEditContoller
                                                                .text),
                                                      ));
                                                });
                                                /* nameEditContoller.clear();
                                                ageEditContoller.clear(); */
                                                Navigator.pop(context);
                                              },
                                              child: Text("save"),
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("cancel"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                boxPersons.deleteAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            ))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        notchMargin: BorderSide.strokeAlignCenter,
        shadowColor: Colors.amber.shade900,
        color: Colors.transparent,
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                boxPersons.clear();
              });
            },
            child: Text("clear all(${boxPersons.length})")),
      ),
    );
  }
}
