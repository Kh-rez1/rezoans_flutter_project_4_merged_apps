import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'public Blog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BlogHomePage(),
    );
  }
}

class BlogHomePage extends StatefulWidget {
  const BlogHomePage({super.key});

  @override
  _BlogHomePageState createState() => _BlogHomePageState();
}

class _BlogHomePageState extends State<BlogHomePage> {
  // Dummy list of articles
  List<Article> articles = [
    Article(
      title: 'Comment 1',
      content: 'hello world',
      author: 'zahid',
    ),
    Article(
      title: 'Scomment 2',
      content: 'hi every one',
      author: 'ismail',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Blog'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(articles[index].title),
            subtitle: Text('By ${articles[index].author}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailPage(article: articles[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to article submission page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ArticleSubmissionPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'By ${article.author}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            Text(article.content),
          ],
        ),
      ),
    );
  }
}

class ArticleSubmissionPage extends StatefulWidget {
  const ArticleSubmissionPage({Key? key}) : super(key: key);

  @override
  _ArticleSubmissionPageState createState() => _ArticleSubmissionPageState();
}

class _ArticleSubmissionPageState extends State<ArticleSubmissionPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Article'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
              maxLines: null, // Allow multiple lines for content
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save the article when the button is pressed
                _saveArticle();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

 void _saveArticle() async {
    // Retrieve input data
    String title = _titleController.text;
    String content = _contentController.text;

    // Save the article locally using shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('article_title', title);
    await prefs.setString('article_content', content);

    // Show a snackbar to indicate that the article is saved
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Article saved')),
    );

    // Navigate back to the previous page
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

class Article {
  final String title;
  final String content;
  final String author;

  Article({required this.title, required this.content, required this.author});
}
