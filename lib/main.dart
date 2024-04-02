import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('InAppWebView Example'),
        // ),
        body: WebViewExample(),
      ),
    );
  }
}

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late InAppWebViewController _webViewController;
  bool _isLoadingPage = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          
          initialUrlRequest: URLRequest(
            url: Uri.parse('https://pmstation.org/pm/index.php'),
            
          ),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true,
              useOnDownloadStart: true,
              useShouldOverrideUrlLoading: true,
              disableContextMenu: true,
              horizontalScrollBarEnabled: false,
              verticalScrollBarEnabled: false,
            ),
          ),
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
          onLoadStop: (controller, url) {
            setState(() {
              _isLoadingPage = false;
            });
            _delayedFunction();
          },
        ),
        if (_isLoadingPage)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  Future<void> _delayedFunction() async {
    await Future.delayed(Duration(seconds: 2));
    _webViewController.evaluateJavascript(
      source: 'console.log("Hello from InAppWebView");',
    );
  }
}
