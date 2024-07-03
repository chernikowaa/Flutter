import 'package:flutter/material.dart';
import 'widgets/button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофейня',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentCategory = "Кофе"; 
  final ScrollController _scrollController = ScrollController();
  ScrollController _horizontalScrollController = ScrollController();

  final List<String> categories = ["Кофе", "Не Кофе", "Наше зерно и чай", "Десерты", "Плотный перекус"];

@override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _horizontalScrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  int _calculateCategoryIndex(double offset) {
    return (offset / 500).floor();
  }


  void _scrollListener() {
    setState(() {
      int index = _calculateCategoryIndex(_scrollController.offset);
      if (index != -1 && index < categories.length) {
        currentCategory = categories[index];
        double screenWidth = MediaQuery.of(context).size.width;
        double categoryWidth = categories.length * 200;

        double scrollTo = index * 120.0 - (screenWidth - 120.0) / 2.0;
        scrollTo = scrollTo.clamp(0, categoryWidth - screenWidth);

        if (index == categories.length - 1) {
          scrollTo = categoryWidth - screenWidth;
        }

        _horizontalScrollController.animateTo(
          scrollTo,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }


  void _selectCategory(String category) {
  setState(() {
    currentCategory = category;
  });

  int index = categories.indexOf(category);
  if (index != -1) {
    _scrollController.jumpTo(
      index * 610,
    );
  }
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _horizontalScrollController,
            child: Row(
              children: categories.map((category) => _buildCategoryButton(category)).toList(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategorySection("Кофе", [
                    Row(
                      children: [
                        _buildItem("Латте Зефир", "assets/латте2.png", 250),
                        _buildItem("Капучино", "assets/Капучино.png", 240),
                      ],
                    ),
                    Row(
                      children: [
                        _buildItem("Флет Уайт", "assets/Флэт.png", 250),
                        _buildItem("Латте Карамель", "assets/карамельный.png", 310),
                      ],
                    ),
                  ]),
                  _buildCategorySection("Не Кофе", [
                    Row(
                      children: [
                        _buildItem("Какао", "assets/какао.png", 270),
                        _buildItem("Молочный коктейль", "assets/мк.png", 350),
                      ],
                    ),
                    Row(
                      children: [
                        _buildItem("Чай Зеленый Мятный", "assets/чай2.png", 200),
                        _buildItem("Матча", "assets/матча.png", 330),
                      ],
                    ),
                  ]),
                  _buildCategorySection("Наше зерно и чай", [
                    Row(
                      children: [
                        _buildItem("Coffoax", "assets/coffoax.png", 630),
                        _buildItem("Codefees", "assets/codefees.png", 650),
                      ],
                    ),
                    Row(
                      children: [
                        _buildItem("Cofeeei", "assets/cofeeei.png", 600),
                        _buildItem("Чай Листовой", "assets/чайлист.png", 450),
                      ],
                    )
                  ]),
                  _buildCategorySection("Десерты", [
                    Row(
                      children: [
                        _buildItem("Шоколадный Кекс", "assets/кекс.png", 120),
                        _buildItem("Круассан с ягодами", "assets/круассан.png", 260),
                      ],
                    ),
                    Row(
                      children: [
                        _buildItem("Булочка с корицей", "assets/синнабон.png", 200),
                        _buildItem("Эклер с Нутеллой", "assets/эклер.png", 180),
                      ],
                    )
                  ]),
                  _buildCategorySection("Плотный перекус", [
                    Row(
                      children: [
                        _buildItem("Рулет с курицей", "assets/ролл.png", 300),
                        _buildItem("Диетический Ролл с курицей", "assets/диетролл.png", 300),
                      ],
                    ),
                    Row(
                      children: [
                        _buildItem("Сендвич с ветчиной", "assets/сендвич.png", 250),
                        _buildItem("Киш с мясом", "assets/киш.png", 350),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildCategoryButton(String category) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          _selectCategory(category);
        },
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: currentCategory == category ? const Color.fromRGBO(255, 200, 221, 1) : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              category,
              style: TextStyle(
                color: currentCategory == category ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 4.0, 
            runSpacing: 2.0, 
            children: items,
          ),
        ],
      ),
    );
  }

    Widget _buildItem(String itemName, String imageUrl, int cost) {
  return GestureDetector(
    onTap: () {
    },
    child: Container(
      width: 160,
      height: 260,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 115,  
            height: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.contain, 
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 160,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(            
                  itemName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            )
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProductButton(
                    price: cost
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}
}