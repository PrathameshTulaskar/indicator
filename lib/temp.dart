// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   TextEditingController rowController = TextEditingController();
//   TextEditingController columnController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text("indicator"),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextFormField(
//                 controller: rowController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue),
//                   ),
//                   hintText: 'Enter Number Of Rows',
//                   labelText: 'Number Of Rows',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextFormField(
//                 controller: columnController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue),
//                   ),
//                   hintText: 'Enter Number Of Columns',
//                   labelText: 'Number Of Columns',
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//
//         // onPressed: _incrementCounter,
//         onPressed: (){
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) =>
//             //     MyFormGrid(
//             //   columns: int.parse(columnController.text),
//             //   rows: int.parse(rowController.text),
//             // )
//             WordSearchGame(
//               numberColumn: int.parse(columnController.text),
//               numberRows: int.parse(rowController.text),
//             )
//             ),
//           );
//         },
//         tooltip: 'Generate',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
//
//
//
//
// class WordSearchGame extends StatefulWidget {
//   final int numberRows;
//   final int numberColumn;
//   const WordSearchGame({super.key,required this.numberRows,required this.numberColumn});
//
//   @override
//   _WordSearchGameState createState() => _WordSearchGameState();
// }
//
// class _WordSearchGameState extends State<WordSearchGame> {
//   List<List<String>> puzzleGrid = [];
//   String searchedWord = '';
//   List<Offset> highlightedTiles = [];
//
//   @override
//   void initState(){
//
//     _generateGrid(widget.numberRows, widget.numberColumn);
//     super.initState();
//
//
//   }
//
//   void _generateGrid(int numRows, int numCols) {
//     setState(() {
//       puzzleGrid.clear();
//       for (int row = 0; row < numRows; row++) {
//         puzzleGrid.add(List.generate(numCols, (col) => ''));
//       }
//       highlightedTiles.clear(); // Clear highlighted tiles when generating a new grid
//     });
//   }
//
//   void _searchWord(String word) {
//     setState(() {
//       searchedWord = word;
//       highlightedTiles = _findWordInGrid(word);
//     });
//   }
//
//   List<Offset> _findWordInGrid(String word) {
//     List<Offset> tiles = [];
//
//     for (int row = 0; row < puzzleGrid.length; row++) {
//       for (int col = 0; col < puzzleGrid[row].length; col++) {
//         if (_checkWordAtPosition(word, row, col, 1, 0)) {
//           for (int i = 0; i < word.length; i++) {
//             tiles.add(Offset(row.toDouble() + i, col.toDouble()));
//           }
//           return tiles;
//         }
//         if (_checkWordAtPosition(word, row, col, 0, 1)) {
//           for (int i = 0; i < word.length; i++) {
//             tiles.add(Offset(row.toDouble(), col.toDouble() + i));
//           }
//           return tiles;
//         }
//         if (_checkWordAtPosition(word, row, col, 1, 1)) {
//           for (int i = 0; i < word.length; i++) {
//             tiles.add(Offset(row.toDouble() + i, col.toDouble() + i));
//           }
//           return tiles;
//         }
//       }
//     }
//
//     return [];
//   }
//
//   bool _checkWordAtPosition(
//       String word, int row, int col, int rowIncrement, int colIncrement) {
//     if (row + rowIncrement * (word.length - 1) >= puzzleGrid.length ||
//         col + colIncrement * (word.length - 1) >= puzzleGrid[row].length) {
//       return false;
//     }
//
//     for (int i = 0; i < word.length; i++) {
//       if (puzzleGrid[row + i * rowIncrement][col + i * colIncrement] != word[i]) {
//         return false;
//       }
//     }
//
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Word'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     onChanged: (value) {
//                       _searchWord(value);
//                       if (value.isEmpty) {
//                         highlightedTiles.clear();
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Search for a word',
//                     ),
//                   ),
//                 ),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     showDialog(
//                 //       context: context,
//                 //       builder: (context) {
//                 //         int numRows = 0;
//                 //         int numCols = 0;
//                 //
//                 //         return AlertDialog(
//                 //           title: Text('Generate Grid'),
//                 //           content: Column(
//                 //             mainAxisSize: MainAxisSize.min,
//                 //             children: [
//                 //               TextField(
//                 //                 onChanged: (value) {
//                 //                   numRows = int.tryParse(value) ?? 0;
//                 //                 },
//                 //                 decoration: InputDecoration(labelText: 'Rows'),
//                 //                 keyboardType: TextInputType.number,
//                 //               ),
//                 //               TextField(
//                 //                 onChanged: (value) {
//                 //                   numCols = int.tryParse(value) ?? 0;
//                 //                 },
//                 //                 decoration: InputDecoration(labelText: 'Columns'),
//                 //                 keyboardType: TextInputType.number,
//                 //               ),
//                 //             ],
//                 //           ),
//                 //           actions: [
//                 //             TextButton(
//                 //               onPressed: () {
//                 //                 _generateGrid(numRows, numCols);
//                 //                 Navigator.pop(context);
//                 //               },
//                 //               child: Text('Generate'),
//                 //             ),
//                 //           ],
//                 //         );
//                 //       },
//                 //     );
//                 //   },
//                 //   child: Text('Generate Grid'),
//                 // ),
//               ],
//             ),
//             puzzleGrid.isNotEmpty
//                 ? GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: puzzleGrid.isNotEmpty ? puzzleGrid[0].length : 0,
//               ),
//               itemCount: puzzleGrid.length * (puzzleGrid.isNotEmpty ? puzzleGrid[0].length : 0),
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 int row = index ~/ (puzzleGrid.isNotEmpty ? puzzleGrid[0].length : 1);
//                 int col = index % (puzzleGrid.isNotEmpty ? puzzleGrid[0].length : 1);
//                 return GestureDetector(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: Text('Edit Cell'),
//                           content: TextField(
//                             onChanged: (value) {
//                               setState(() {
//                                 puzzleGrid[row][col] = value;
//                               });
//                             },
//                             controller: TextEditingController(text: puzzleGrid[row][col]),
//                             decoration: InputDecoration(labelText: 'Enter a letter'),
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text('Done'),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     margin: EdgeInsets.all(8),
//                     color: highlightedTiles.contains(Offset(row.toDouble(), col.toDouble()))
//                         ? Colors.green
//                         : Colors.grey.withOpacity(0.3),
//                     child: Center(
//                         child:
//                         TextField(
//                           onChanged: (value) {
//                             setState(() {
//                               puzzleGrid[row][col] = value;
//                             });
//                           },
//                           controller: TextEditingController(text: puzzleGrid[row][col]),
//                           // decoration: InputDecoration(labelText: 'Enter a letter'),
//                           textAlign: TextAlign.center,
//                           decoration: const InputDecoration(
//                             // labelText: 'Search for a word',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                               borderSide: BorderSide.none,
//                             ),
//                             contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12), // Adjust padding
//                           ),
//                         )
//
//                       // Text(
//                       //   puzzleGrid.isNotEmpty ? puzzleGrid[row][col] : '',
//                       //   style: TextStyle(fontSize: 24, color: Colors.white),
//                       // ),
//                     ),
//                   ),
//                 );
//               },
//             )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }