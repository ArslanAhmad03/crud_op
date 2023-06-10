import 'package:flutter/material.dart';
import 'package:flutter_app/contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts List'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 5.0),
              Container(
                child: Text('Create New Contact'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: 'Contact Name',
                    labelText: 'Contact',
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ))),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: contactController,
                keyboardType: TextInputType.number,
                maxLength: 11,
                decoration: const InputDecoration(
                    hintText: 'Contact Number',
                    labelText: 'Number',
                    icon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ))),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        //
                        String name = nameController.text.trim();
                        String contact = contactController.text.trim();
                        if (name.isNotEmpty && contact.isNotEmpty) {
                          setState(() {
                            nameController.text = '';
                            contactController.text = '';
                            contacts.add(Contact(name: name, contact: contact));
                          });
                        }
                        //
                      },
                      child: const Text('Save')),
                  ElevatedButton(
                      onPressed: () {
                        String name = nameController.text.trim();
                        String contact = contactController.text.trim();
                        if (name.isNotEmpty && contact.isNotEmpty) {
                          setState(() {
                            nameController.text = '';
                            contactController.text = '';
                            contacts[selectedIndex].name = name;
                            contacts[selectedIndex].contact = contact;
                            selectedIndex = -1;
                          });
                        }
                        //
                      },
                      child: const Text('Update')),
                ],
              ),
              const SizedBox(height: 10),
              contacts.isEmpty
                  ? const Text(
                      'No Contact Found',
                      style: TextStyle(fontSize: 22),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) => getRow(index),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    nameController.text = contacts[index].name;
                    contactController.text = contacts[index].contact;
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    setState(() {
                      contacts.removeAt(index);
                    });
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
