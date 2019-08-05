import './AwesomeBottomNavBarShadowPainter.dart';
import 'package:flutter/material.dart';
import 'AwesomeBottomNavigationClipper.dart';
import 'Utils.dart';

class AwesomeBottomNavigationBar extends StatefulWidget {
  final List<IconData> icons;
  final Color bodyBackgroundColor;
  final int selectedIndex;

  final Function tapCallback;

  AwesomeBottomNavigationBar(
      {this.icons = const [],
      this.bodyBackgroundColor,
      this.selectedIndex = 0,
      @required this.tapCallback});

  @override
  _AwesomeBottomNavigationBarState createState() =>
      _AwesomeBottomNavigationBarState(selectedIndex);
}

class _AwesomeBottomNavigationBarState extends State<AwesomeBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  int newIndex = 0;
  final _circleBottomPosition = 50 + kBottomNavigationBarHeight * 0.4;
  final double kCircleSize = Utils.getIndependentDimen(62);

  Animation<double> _notchPosAnimation;
  AnimationController _animationController;

  Animation<double> _sinkAnimation;
  Animation<double> _riseAnimation;

  Size _size;

  _AwesomeBottomNavigationBarState(this.selectedIndex);

  @override
  void didUpdateWidget(AwesomeBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex == widget.selectedIndex) {
      return;
    }
    tapped(widget.selectedIndex, false);
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _notchPosAnimation = Tween<double>(
            begin: selectedIndex * 1.0, end: (selectedIndex + 1) * 1.0)
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutSine,
    ));

    _sinkAnimation = Tween<double>(
      begin: 0,
      end: _circleBottomPosition,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.15, curve: Curves.ease),
    ));

    _riseAnimation = Tween<double>(
      begin: _circleBottomPosition,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.5, 1.0, curve: Curves.ease),
    ));

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        selectedIndex = newIndex;
        _animationController.reset();
      }
    });
  }

  List<Widget> getSmallIcons() {
    List<Widget> icons = [];
    for (int i = 0; i < widget.icons.length; i++) {
      var a = Expanded(
        child: Container(
          child: InkResponse(
            onTap: () {
              tapped(i, true);
            },
            child: Opacity(
              opacity: getOpacityForIndex(i),
              child: Container(
                height: kBottomNavigationBarHeight * 1.6,
                width: _size.width / 5,
                child: Icon(
                  widget.icons[i],
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      );
      icons.add(a);
    }
    return icons;
  }

  double getOpacityForIndex(int index) {
    if (_animationController.isAnimating) {
      var dist = (index - _notchPosAnimation.value).abs();
      if (dist >= 1) {
        return 1;
      } else {
        return dist;
      }
    } else {
      return selectedIndex == index ? 0 : 1;
    }
  }

  void tapped(int index, bool userInteraction) {
    if (userInteraction) {
      widget.tapCallback(index);
    }
    newIndex = index;
    _notchPosAnimation =
        Tween<double>(begin: selectedIndex * 1.0, end: index * 1.0)
            .animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ));

    _animationController.forward();
  }

  double getCircleYPosition() {
    if (!_animationController.isAnimating) {
      return 0;
    }

    if (_animationController.value < 0.5) {
      return _sinkAnimation.value;
    } else {
      return _riseAnimation.value;
    }
  }

  Icon getMainIcon() {
    IconData icon;
    if (_animationController.value < 0.5) {
      icon = widget.icons[selectedIndex];
    } else {
      icon = widget.icons[newIndex];
    }
    return Icon(
      icon,
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    final sectionWidth = _size.width / widget.icons.length;
    final circleLeftPadding = (sectionWidth - kCircleSize) / 2;
    return Container(
      color: widget.bodyBackgroundColor,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: (_animationController.isAnimating
                    ? _notchPosAnimation.value
                    : selectedIndex) *
                (_size.width / widget.icons.length),
            top: getCircleYPosition(),
            child: Container(
              margin: EdgeInsets.only(left: circleLeftPadding),
              child: SizedBox(
                height: kCircleSize,
                width: kCircleSize,
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  type: MaterialType.circle,
                  color: Colors.white,
                  elevation: 2,
                  child: getMainIcon(),
                ),
              ),
            ),
          ),
          CustomPaint(
            painter: AwesomeBottomNavBarShadowPainter(
              _animationController.isAnimating
                  ? _notchPosAnimation.value
                  : selectedIndex * 1.0,
              widget.icons.length,
            ),
            child: ClipPath(
              clipBehavior: Clip.antiAlias,
              clipper: AwesomeBottomNavigationClipper(
                _animationController.isAnimating
                    ? _notchPosAnimation.value
                    : selectedIndex * 1.0,
                widget.icons.length,
              ),
              child: Container(
                height: kBottomNavigationBarHeight * 1.6,
                width: _size.width,
                child: Material(
                  elevation: 4,
                  child: Container(
                    margin:
                        EdgeInsets.only(top: kBottomNavigationBarHeight * 0.4),
                    height: kBottomNavigationBarHeight * 1.2,
                    width: _size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getSmallIcons(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
