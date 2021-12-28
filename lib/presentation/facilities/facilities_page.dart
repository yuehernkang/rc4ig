import 'package:flutter/material.dart';
import '../../data/models/interest_group.dart';
import '../../data/models/venue.dart';
import '../interest_groups_page/ig_item.dart';
import '../shared/reusable_grid_view.dart';

import '../../constants.dart';

class FacilitiesPage extends StatefulWidget {
  const FacilitiesPage({Key? key}) : super(key: key);

  @override
  State<FacilitiesPage> createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    widgets.add(IgItemCard(
        onTap: () {
          Navigator.pushNamed(context, facilitiesDetailPage,
              arguments:
                  Venue(venueName: VenueNames.MPSH, displayName: "MPSH"));
        },
        ig: InterestGroup(
            title: "MPSH",
            description: "MPSH",
            imageUrl:
                "https://www.myactivesg.com/-/media/SSC/Consumer/Images/Facilities/Pasir-Ris-Sports-Hall/Pasir-Ris-Sports-Hall.jpg",
            category: "MPSH"),
        index: 0));
    widgets.add(IgItemCard(
        onTap: () {
          Navigator.pushNamed(context, facilitiesDetailPage,
              arguments: Venue(
                  venueName: VenueNames.TR1,
                  displayName: "TR1 (Reading Room)"));
        },
        ig: InterestGroup(
            title: "TR1 (Reading Room)",
            description: "TR1 (Reading Room)",
            imageUrl:
                "https://media.wired.com/photos/5955c3573ff99d6b3a1d165c/master/pass/books.jpg",
            category: "TR1 (Reading Room)"),
        index: 0));
    widgets.add(IgItemCard(
        onTap: () {
          Navigator.pushNamed(context, facilitiesDetailPage,
              arguments: Venue(
                  venueName: VenueNames.TR2, displayName: "TR2 (Games Room)"));
        },
        ig: InterestGroup(
            title: "TR2 (Games Room)",
            description: "TR2 (Games Room)",
            imageUrl:
                "https://sm.ign.com/ign_ap/feature/t/the-best-g/the-best-games-of-2021-so-far_z9fq.jpg",
            category: "TR2 (Games Room)"),
        index: 0));
    widgets.add(IgItemCard(
        onTap: () {
          Navigator.pushNamed(context, facilitiesDetailPage,
              arguments: Venue(
                  venueName: VenueNames.TR3, displayName: "TR3 (RC4ME Only)"));
        },
        ig: InterestGroup(
            title: "TR3 (RC4ME Only)",
            description: "TR3 (RC4ME Only)",
            imageUrl:
                "https://homedesignlover.com/wp-content/uploads/2014/05/music-room.jpg",
            category: "TR3 (RC4ME Only) "),
        index: 0));
    widgets.add(IgItemCard(
        onTap: () {
          Navigator.pushNamed(context, facilitiesDetailPage,
              arguments: Venue(venueName: VenueNames.TR4, displayName: "TR4"));
        },
        ig: InterestGroup(
            title: "TR4",
            description: "TR4",
            imageUrl:
                "https://media.designcafe.com/wp-content/uploads/2020/12/17202014/study-room-vastu.jpg",
            category: "TR4"),
        index: 0));
    widgets.add(IgItemCard(
        onTap: () {
          Navigator.pushNamed(context, facilitiesDetailPage,
              arguments: Venue(
                  venueName: VenueNames.CommonLounge,
                  displayName: "Common Lounge"));
        },
        ig: InterestGroup(
            title: "Common Lounge",
            description: "Common Lounge",
            imageUrl:
                "https://res.klook.com/images/fl_lossy.progressive,q_65/c_fill,w_1077,h_717,f_auto/w_80,x_15,y_15,g_south_west,l_klook_water/activities/gdgfrumnemvdtskzeqmp/ChangiLoungeinJewelChangiAirport-KlookSingapore.jpg",
            category: "Common Lounge"),
        index: 0));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Facilities"),
      ),
      body: ReusableGridView(widget: widgets),
    );
  }
}
