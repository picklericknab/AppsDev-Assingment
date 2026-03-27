import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _staggerController;
  late AnimationController _absorbController;

  late Animation<double> _imgFade;
  late Animation<Offset> _imgSlide;
  late Animation<double> _rectFade;

  late Animation<double> _rectOpacity;

  bool _absorbed = false;

  @override
  void initState() {
    super.initState();

    _staggerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );

    _absorbController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _imgFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _imgSlide = Tween<Offset>(begin: Offset(1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _rectFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _rectOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _absorbController, curve: Curves.easeInOut),
    );

    _staggerController.forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    _absorbController.dispose();
    super.dispose();
  }

  void _onImageTap() {
    if (!_absorbed) {
      _absorbController.forward();
    } else {
      _absorbController.reverse();
    }
    setState(() {
      _absorbed = !_absorbed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 206, 59, 74),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _rectFade,
                  child: AnimatedBuilder(
                    animation: _absorbController,
                    builder: (context, child) {
                      return ClipRect(
                        child: Align(
                          alignment: Alignment.centerRight,
                          widthFactor: 1 - _absorbController.value,
                          child: Opacity(
                            opacity: _rectOpacity.value,
                            child: Container(
                              width: 300,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'Home',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 12),
                FadeTransition(
                  opacity: _imgFade,
                  child: SlideTransition(
                    position: _imgSlide,
                    child: GestureDetector(
                      onTap: _onImageTap,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/baki.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
