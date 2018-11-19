import 'package:flutter/material.dart';

class ItemHiddenMenu extends StatelessWidget {

  final String name;
  Function onTap;
  final Color colorLineSelected;
  final Color colorTextSelected;
  final Color colorTextUnSelected;

  ItemHiddenMenu(
      {Key key,
      this.name,
      this.selected = false,
      this.onTap,
      this.colorLineSelected = Colors.blue,
      this.colorTextSelected = Colors.white,
      this.colorTextUnSelected = Colors.grey})
      : super(key: key);

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(4.0),bottomRight: Radius.circular(4.0)),
              child: Container(
                height: 40.0,
                color: selected ? colorLineSelected : Colors.transparent,
                width: 5.0,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  name,
                  style: TextStyle(
                      color: selected ? colorTextSelected : colorTextUnSelected,
                      fontSize: 25.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HiddenMenu extends StatefulWidget {

  final DecorationImage background;
  final bool enableShadowItensMenu;
  final Color backgroundColorMenu;
  final List<ItemHiddenMenu> itens;
  final Function(int) selectedListern;
  final int initPositionSelected;

  HiddenMenu(
      {Key key,
      this.background,
      this.itens,
      this.selectedListern,
      this.initPositionSelected,
      this.backgroundColorMenu,
        this.enableShadowItensMenu = false})
      : super(key: key);

  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  int indexSelected;

  @override
  void initState() {
    indexSelected = widget.initPositionSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: widget.background,
          color: widget.backgroundColorMenu,
        ),
        child: Center(
            child: Container(
              padding: EdgeInsets.only(top: 40.0,bottom: 40.0),
              decoration: BoxDecoration(
                  boxShadow: widget.enableShadowItensMenu ? [
                    new BoxShadow(
                      color: const Color(0x44000000),
                      offset: const Offset(0.0, 5.0),
                      blurRadius: 50.0,
                      spreadRadius: 30.0,
                    ),
                  ]: []
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0.0),
                  itemCount: widget.itens.length,
                  itemBuilder: (context, index) {

                    return new ItemHiddenMenu(
                      name: widget.itens[index].name,
                      selected: index == indexSelected,
                      colorLineSelected: widget.itens[index].colorLineSelected,
                      colorTextSelected: widget.itens[index].colorTextSelected,
                      colorTextUnSelected: widget.itens[index].colorTextUnSelected,
                      onTap: () {
                        if (index != indexSelected) {
                          setState(() {
                            indexSelected = index;
                            widget.selectedListern(index);
                          });
                        }
                      },
                    );

                  }),
            ),
          ),
        ),
    );
  }
}
