// dart async library we will refer to when setting up real time updates
import 'dart:async';
// flutter and ui libraries
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
// amplify packages we will need to use
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:shared_preferences/shared_preferences.dart';
// amplify configuration and models that should have been generated for you
import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';
import 'models/History.dart';
import 'models/OfficeQueue.dart';
import 'models/Queuer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Office Hours',
      home: OfficeHoursPage(),
    );
  }
}

class OfficeHoursPage extends StatefulWidget {
  const OfficeHoursPage({Key? key}) : super(key: key);

  @override
  _OfficeHoursPageState createState() => _OfficeHoursPageState();
}

class _OfficeHoursPageState extends State<OfficeHoursPage> {
  // subscription of Todo QuerySnapshots - to be initialized at runtime
  late StreamSubscription<QuerySnapshot<Queuer>> _queuerSubscription;
  late StreamSubscription<QuerySnapshot<OfficeQueue>> _officeQueueSubscription;

  final AmplifyDataStore _dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);

  // loading ui state - initially set to a loading state
  bool _isLoading = true;

  // list of offices
  List<OfficeQueue> _officeQueues = [];
  // list of queuers in queue
  List<Queuer> _queuers = [];

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
      await Amplify.addPlugin(_dataStorePlugin);
      await Amplify.addPlugin(AmplifyAPI());
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
        title: const Text('Office Hours'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : OfficeHoursBody(officeQueues: _officeQueues, queuers: _queuers),
    );
  }
}

class OfficeHoursBody extends StatelessWidget {
  final List<OfficeQueue> officeQueues;
  final List<Queuer> queuers;

  const OfficeHoursBody(
      {Key? key, required this.officeQueues, required this.queuers})
      : super(key: key);

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
      DequeueButton(),
      const ClearAllStateButtonForTesting()
    ]);
  }
}

class OfficeQueueList extends StatelessWidget {
  final List<OfficeQueue> officeQueues;

  const OfficeQueueList({Key? key, required this.officeQueues})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return officeQueues.isNotEmpty
        ? ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: officeQueues
                .map((officeQueue) => OfficeQueueItem(officeQueue: officeQueue))
                .toList())
        : const Center(child: Text('No OfficeQueues'));
  }
}

class OfficeQueueItem extends StatelessWidget {
  final OfficeQueue officeQueue;

  const OfficeQueueItem({Key? key, required this.officeQueue})
      : super(key: key);

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
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
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

  const QueuerList({Key? key, required this.queuers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return queuers.isNotEmpty
        ? ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children:
                queuers.map((queuer) => QueuerItem(queuer: queuer)).toList())
        : const Center(child: Text('No Queuers'));
  }
}

class QueuerItem extends StatelessWidget {
  final Queuer queuer;
  const QueuerItem({Key? key, required this.queuer}) : super(key: key);

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
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
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
  String? _userId;

  EnqueueButton({Key? key}) : super(key: key);

  Future<String> promptAndCreateQueuer(context, localData) async {
    return await showDialog(
      context: context,
      barrierDismissible:
          false, // prevent user from closing the dialog by pressing outside the dialog
      builder: (_) {
        String userName = "defaultName";
        return AlertDialog(
          title: const Text("Enter your name"),
          content: TextField(
            onChanged: (value) {
              userName = value;
            },
          ),
          actions: [
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: () async {
                var queuerModel = Queuer(name: userName);
                _userId = queuerModel.getId();
                localData.setString("userId", _userId);
                await Amplify.DataStore.save(queuerModel);
                Navigator.of(context).pop(_userId);
              },
            )
          ],
        );
      },
    );
  }

  onPressed(context) async {
    final localData = await SharedPreferences.getInstance();
    _userId ??= localData.getString("userId") ??
        await promptAndCreateQueuer(context, localData);
    var officeQueues = await Amplify.DataStore.query(OfficeQueue.classType);
    if (officeQueues.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => const Center(child: Text("No office queues")));
    } else {
      var officeQueue = officeQueues.first;
      var queuers = await Amplify.DataStore.query(Queuer.classType,
          where: Queuer.ID.eq(_userId));
      var queuer = queuers.first;
      await Amplify.DataStore.save(
          QueuerOfficeQueue(officequeue: officeQueue, queuer: queuer));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressed(context), child: const Text("Enqueue"));
  }
}

class DequeueButton extends StatelessWidget {
  String? _officeQueueId;

  DequeueButton({Key? key}) : super(key: key);

  Future<String> promptAndCreateOfficeQueue(context, localData) async {
    return await showDialog(
      context: context,
      barrierDismissible:
          false, // prevent user from closing the dialog by pressing outside the dialog
      builder: (_) {
        String officeName = "defaultName";
        return AlertDialog(
          title: const Text("Enter your office name"),
          content: TextField(
            onChanged: (value) {
              officeName = value;
            },
          ),
          actions: [
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: () async {
                var officeQueueModel = OfficeQueue(name: officeName);
                _officeQueueId = officeQueueModel.getId();
                localData.setString("officeQueueId", _officeQueueId);
                await Amplify.DataStore.save(officeQueueModel);
                Navigator.of(context).pop(_officeQueueId);
              },
            )
          ],
        );
      },
    );
  }

  onPressed(context) async {
    final localData = await SharedPreferences.getInstance();
    _officeQueueId ??= localData.getString("officeQueueId") ??
        await promptAndCreateOfficeQueue(context, localData);
    List<OfficeQueue> officeQueues = await Amplify.DataStore.query(
        OfficeQueue.classType,
        where: OfficeQueue.ID.eq(_officeQueueId));
    List<QueuerOfficeQueue> queuerOfficeQueues = await Amplify.DataStore.query(
        QueuerOfficeQueue.classType,
        where: QueuerOfficeQueue.OFFICEQUEUE.eq(_officeQueueId));
    //queuers is null, but I would expect it to be populated after a QueuerOfficeQueue relationship item is added
    print(officeQueues);
    //The QueuerOfficeQueue relationship item has the right info
    print(queuerOfficeQueues);

    if (officeQueues.isEmpty) {
      throw Exception("office queue $_officeQueueId doesn't exist");
    } else if (officeQueues.first.queuers == null ||
        officeQueues.first.queuers!.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => Center(
              child: Text("No queuer coders in office queue $_officeQueueId")));
    } else {
      var officeQueueQueuerModel = officeQueues.first.queuers!.first;
      var queuer = officeQueueQueuerModel.queuer;
      showDialog(
          context: context,
          builder: (context) =>
              Text("The next queuer coder is ${queuer.name}"));
      await Amplify.DataStore.delete(officeQueueQueuerModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressed(context), child: const Text("Dequeue"));
  }
}

class ClearAllStateButtonForTesting extends StatelessWidget {
  const ClearAllStateButtonForTesting({Key? key}) : super(key: key);

  onPressed(context) async {
    final localData = await SharedPreferences.getInstance();
    await localData.clear();
    for (var element
        in (await Amplify.DataStore.query(OfficeQueue.classType))) {
      await Amplify.DataStore.delete(element);
    }
    for (var element in (await Amplify.DataStore.query(Queuer.classType))) {
      await Amplify.DataStore.delete(element);
    }
    await Amplify.DataStore.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressed(context),
        child: const Text("Clear State For Testing"));
  }
}
