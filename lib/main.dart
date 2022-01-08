// dart async library we will refer to when setting up real time updates
import 'dart:async';
// flutter and ui libraries
import 'package:flutter/material.dart';
// amplify packages we will need to use
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
// amplify configuration and models that should have been generated for you
import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';
import 'models/History.dart';
import 'models/OfficeQueue.dart';
import 'models/Queuer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Office Hours',
      home: OfficeHoursPage(),
    );
  }
}

class OfficeHoursPage extends StatefulWidget {
  @override
  _OfficeHoursPageState createState() => _OfficeHoursPageState();
}

class _OfficeHoursPageState extends State<OfficeHoursPage> {
  // subscription of Todo QuerySnapshots - to be initialized at runtime
  late StreamSubscription<QuerySnapshot<Queuer>> _queuerSubscription;
  late StreamSubscription<QuerySnapshot<OfficeQueue>> _officeQueueSubscription;

  // loading ui state - initially set to a loading state
  bool _isLoading = true;

  // list of offices
  List<OfficeQueue> _officeQueues = [];
  // list of queuers in queue
  List<Queuer> _queuers = [];

  // amplify plugins
  final AmplifyDataStore _dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  @override
  void initState() {
    // kick off app initialization
    _initializeApp();

    super.initState();
  }

  @override
  void dispose() {
    // to be filled in a later step
    super.dispose();
  }

  Future<void> _initializeApp() async {
    // configure Amplify
    await _configureAmplify();

    _queuerSubscription = Amplify.DataStore.observeQuery(Queuer.classType)
        .listen((QuerySnapshot<Queuer> snapshot) {
      setState(() {
        if (_isLoading) _isLoading = false;
        _queuers = snapshot.items;
      });
    });

    _officeQueueSubscription =
        Amplify.DataStore.observeQuery(OfficeQueue.classType)
            .listen((QuerySnapshot<OfficeQueue> snapshot) {
      setState(() {
        if (_isLoading) _isLoading = false;
        _officeQueues = snapshot.items;
      });
    });
  }

  Future<void> _configureAmplify() async {
    try {
      // add Amplify plugins
      await Amplify.addPlugins([_dataStorePlugin]);

      // configure Amplify
      //
      // note that Amplify cannot be configured more than once!
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      // error handling can be improved for sure!
      // but this will be sufficient for the purposes of this tutorial
      print('An error occurred while configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Office Hours'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : OfficeHoursBody(officeQueues: _officeQueues, queuers: _queuers),
    );
  }
}

class OfficeHoursBody extends StatelessWidget {
  final List<OfficeQueue> officeQueues;
  final List<Queuer> queuers;

  OfficeHoursBody({required this.officeQueues, required this.queuers});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      OfficeQueueList(
        officeQueues: officeQueues,
      ),
      QueuerList(
        queuers: queuers,
      ),
      EnqueueButton(),
      DequeueButton()
    ]);
  }
}

class OfficeQueueList extends StatelessWidget {
  final List<OfficeQueue> officeQueues;

  OfficeQueueList({required this.officeQueues});

  @override
  Widget build(BuildContext context) {
    return officeQueues.length > 0
        ? ListView(
            padding: EdgeInsets.all(8),
            children: officeQueues
                .map((officeQueue) => OfficeQueueItem(officeQueue: officeQueue))
                .toList())
        : Center(child: Text('No OfficeQueues'));
  }
}

class OfficeQueueItem extends StatelessWidget {
  final OfficeQueue officeQueue;

  OfficeQueueItem({required this.officeQueue});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(officeQueue.name ?? "null office name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class QueuerList extends StatelessWidget {
  final List<Queuer> queuers;

  QueuerList({required this.queuers});

  @override
  Widget build(BuildContext context) {
    return queuers.length > 0
        ? ListView(
            padding: EdgeInsets.all(8),
            children:
                queuers.map((queuer) => QueuerItem(queuer: queuer)).toList())
        : Center(child: Text('No Queuers'));
  }
}

class QueuerItem extends StatelessWidget {
  final Queuer queuer;

  QueuerItem({required this.queuer});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(queuer.name ?? "null queuer name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class EnqueueButton extends StatelessWidget {
  onPressed() {
    // Enqueue the user
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text("Enqueue"));
  }
}

class DequeueButton extends StatelessWidget {
  onPressed() {
    // Dequeue the user
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text("Dequeue"));
  }
}
