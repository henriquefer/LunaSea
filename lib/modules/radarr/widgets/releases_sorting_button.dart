import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrReleasesSortButton extends StatefulWidget {
    final ScrollController controller;

    RadarrReleasesSortButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<RadarrReleasesSortButton> createState() => _State();
}

class _State extends State<RadarrReleasesSortButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<RadarrModel>(
            builder: (context, model, widget) => PopupMenuButton<RadarrReleasesSorting>(
                shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                    ? LSRoundedShapeWithBorder()
                    : LSRoundedShape(),
                icon: LSIcon(icon: Icons.sort),
                onSelected: (result) {
                    if(model.sortReleasesType == result) {
                        model.sortReleasesAscending = !model.sortReleasesAscending;
                    } else {
                        model.sortReleasesAscending = true;
                        model.sortReleasesType = result;
                    }
                    _scrollBack();
                },
                itemBuilder: (context) => List<PopupMenuEntry<RadarrReleasesSorting>>.generate(
                    RadarrReleasesSorting.values.length,
                    (index) => PopupMenuItem<RadarrReleasesSorting>(
                        value: RadarrReleasesSorting.values[index],
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    RadarrReleasesSorting.values[index].readable,
                                    style: TextStyle(
                                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                    ),
                                ),
                                if(model.sortReleasesType == RadarrReleasesSorting.values[index]) Icon(
                                    model.sortReleasesAscending
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    size: Constants.UI_FONT_SIZE_SUBTITLE+2.0,
                                    color: LSColors.accent,
                                ),
                            ],
                        ),
                    ),
                ),
            ), 
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
        color: Theme.of(context).canvasColor,
    );

    void _scrollBack() {
        widget.controller.animateTo(
            1.00,
            duration: Duration(
                milliseconds: Constants.UI_NAVIGATION_SPEED*2,
            ),
            curve: Curves.easeOutSine,
        );
    }
}
