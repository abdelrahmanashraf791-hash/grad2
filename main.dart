import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Note: We will import Firebase here in the next step!

void main() async {
  // 1. Ensure Flutter bindings are initialized before doing backend stuff
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. We will initialize Firebase right here in the next step
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp(); 

  // 3. Run the app wrapped in Provider
 runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => "DummyProviderForNow"), 
      ],
      child: const AASTApp(),
    ),
  );
}

class AASTApp extends StatelessWidget {
  const AASTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AAST Student Activities',
      debugShowCheckedModeBanner: false, // Removes the ugly debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // We can add official AAST colors here later!
      ),
      // For now, we just show a simple loading screen
      home: Scaffold(
        appBar: AppBar(title: const Text('Firebase Test')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // ⬇️ THIS is the code that talks to Firebase!
              await FirebaseFirestore.instance.collection('activities').add({
                'title': 'Test Event from VS Code!',
                'location': 'AAST Campus',
                'capacity': 100,
                'timestamp': FieldValue.serverTimestamp(),
              });
              print("Data sent to Firebase!");
            },
            child: const Text('Send Test Data to Database'),
          ),
        ),
      ),
          );
        
      
    
  }
}