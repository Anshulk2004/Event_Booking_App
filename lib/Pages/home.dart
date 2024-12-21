import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 25.0,left:15.0,right:15.0),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: LinearGradient(colors:[Color(0xffe3e6ff),Color(0xfff1f3ff),Colors.white], begin: Alignment.topLeft, end:Alignment.bottomRight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.location_on_outlined), 
                Text("Pune, Maharashtra",style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0
                ),),
              ],
            ),
            const SizedBox(height: 15.0,),
            const Text("Hello, Anshul",style: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
            ),),
            const SizedBox(height: 5.0,),
            const Text("There are 8 events happening \naround your location",style: TextStyle(
              color: Colors.blue,
              fontSize: 20.0,
              fontWeight: FontWeight.w500
            ),),
            const SizedBox(height: 10.0,),
            Container(
              padding: const EdgeInsets.only(left:15.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.circular(15)),
              child: const TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search_outlined),
                  border: InputBorder.none,hintText: "Search for your location"
                ),
              ),
            ),
            ListView(
              children: [
                Container(
                  child: const Column(
                    children: [

                    ],
                  ),
                )
              ],
            )

         
          
        ],),
      ),
    );
  }
}
