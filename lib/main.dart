import 'package:flutter/material.dart';

import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Tinder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class CatInfo {
  final String imageSource;

  final String breedName;

  final String description;

  bool get isNotEmpty =>
      imageSource.trim().isNotEmpty && breedName.trim().isNotEmpty;

  const CatInfo(this.imageSource, this.breedName, {this.description = ''});
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  int _likeCount = 0;

  final Random _random = Random();

  final List<CatInfo> _catList = [
    CatInfo(
      'lib/assets/image1.jpg',
      'Bengal Cat',
      description: '''
        The Bengal cat is a breed of hybrid cat created from crossing of an Asian leopard cat (Prionailurus bengalensis) with domestic cats, especially the spotted Egyptian Mau. 
        It is then usually bred with a breed that demonstrates a friendlier personality, because after breeding a domesticated cat with a wildcat, its friendly personality may not manifest in the kitten. The breed's name derives from the leopard cat's taxonomic name.
        Bengals have varying appearances. Their coats range from spots, rosettes, arrowhead markings, to marbling.
      ''',
    ),
    CatInfo(
      'lib/assets/image2.jpg',
      'Chocolate York',
      description: '''
        The York Chocolate (or simply York) is an uncommon American breed of show cat, with a long, fluffy coat and a tapered tail and most of them were mostly or entirely chocolate-brown or the dilute form of brown, known as lavender. The breed was named after New York state, where it was established in 1983.
      ''',
    ),
    CatInfo('', ' '),
    CatInfo(
      'lib/assets/image3.jpg',
      'Siamese Cat',
      description: ''' 
        The Siamese cat (Thai: แมวไทย, Maeo Thai; แมวสยาม, Maeo Sayam) is one of the first distinctly recognised breeds of Asian cat. It derives from the Wichianmat landrace. The Siamese cat is one of several varieties of cats native to Thailand (known as Siam before 1939). The original Siamese became one of the most popular breeds in Europe and North America in the 19th century.
      ''',
    ),
    CatInfo(' ', ''),
    CatInfo(' ', 'Yorkshire'),
    CatInfo(
      'lib/assets/image4.jpg',
      'Sphynx',
      description: ''' 
        The Sphynx cat (pronounced SFINKS, /ˈsfɪŋks/) also known as the Canadian Sphynx, is a breed of cat known for its lack of fur. Hairlessness in cats is a naturally occurring genetic mutation, and the Sphynx was developed through selective breeding of these animals, starting in the 1960s
      ''',
    ),
    CatInfo(
      'lib/assets/image5.jpg',
      'Maine Coon',
      description: ''' 
        The Maine Coon is a large domesticated cat breed. One of the oldest natural breeds in North America, the breed originated in the U.S. state of Maine,[3][4] where it is the official state cat.
      ''',
    ),
    CatInfo(' ', ''),
    CatInfo(
      'lib/assets/image6.jpg',
      'Persian Cat',
      description: ''' 
        The Persian cat, also known as the Persian Longhair, is a long-haired breed of cat characterised by a round face and short muzzle. The first documented ancestors of Persian cats might have been imported into Italy from Khorasan as early as around 1620, but this has not been proven. Instead, there is stronger evidence for a longhaired cat breed being exported from Afghanistan and Iran/Persia from the 19th century onwards
      ''',
    ),
    CatInfo(
      'lib/assets/image7.jpg',
      'Ragdoll',
      description: ''' 
        The Ragdoll is a breed of cat with a distinct colorpoint coat and blue eyes. Its morphology is large and weighty, and it has a semi-long and silky soft coat. American breeder Ann Baker developed Ragdolls in the 1960s. They are best known for their docile, placid temperament and affectionate nature. The name Ragdoll is derived from the tendency of individuals from the original breeding stock to go limp and relaxed when picked up. The breed is particularly popular in both the United Kingdom and the United States.
      ''',
    ),
  ];

  void _like() {
    setState(() {
      _index = _random.nextInt(_catList.length);
      _likeCount += 1;
    });
  }

  void _swipe() {
    setState(() {
      _index = _random.nextInt(_catList.length);
    });
  }

  void _onImageTap(CatInfo catInfo) {
    if (catInfo.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatDetailScreen(catInfo: catInfo),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cat Tinder')),
      body: GestureDetector(
        onTap: () {
          _onImageTap(_catList[_index]);
        },
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            _like(); // swipe right
          } else if (details.primaryVelocity! > 0) {
            _swipe(); // swipe left
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Лайк $_likeCount раз',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Image.asset(
                (_catList[_index].isNotEmpty
                    ? _catList[_index].imageSource
                    : 'lib/assets/default_cat.jpg'),
                width: 200,
                height: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ReactionButton(
                    onTap: _like,
                    imageSource: 'lib/assets/thumb_up.jpg',
                  ), // like reaction button
                  ReactionButton(
                    onTap: _swipe,
                    imageSource: 'lib/assets/thumb_down.jpg',
                  ), // dislike reaction button
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReactionButton extends StatelessWidget {
  // like or dislike button
  final VoidCallback onTap;

  final String imageSource;

  const ReactionButton({
    super.key,
    required this.onTap,
    required this.imageSource,
  });

  @override
  Widget build(Object context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(imageSource, width: 50, height: 50),
    );
  }
}

class CatDetailScreen extends StatelessWidget {
  final CatInfo catInfo;

  const CatDetailScreen({super.key, required this.catInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset(
              catInfo.imageSource,
              width: double.infinity,
              height: 300,
            ),
            const SizedBox(height: 20),
            Text(
              catInfo.breedName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(catInfo.description, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
