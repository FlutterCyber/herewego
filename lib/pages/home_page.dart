import 'package:flutter/material.dart';
import 'package:herewego/model/post_model.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/services/auth_service.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/rtdb_service.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiGetPosts();
  }

  Future openDetail() async {
    Map results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return DetailPage();
    }));
    if (results != null && results.containsKey('data')) {
      print(results['data']);
      _apiGetPosts();
    }
  }

  _apiGetPosts() async {
    var id = await Prefs.loadUserId();
    RTDBService.getPosts(id).then((posts) => {
          _respPosts(posts),
        });
  }

  _respPosts(List<Post> posts) {
    setState(() {
      items = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("All Posts"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              AuthService.signOutUser(context);
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          return itemOfList(items[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDetail();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget itemOfList(Post post) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            post.content,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
