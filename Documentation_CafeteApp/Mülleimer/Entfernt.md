 Center(  
  child: Column(  
    mainAxisAlignment: MainAxisAlignment.center,  
    children: <Widget>[  
      OpeningHoursBox(),  
      SizedBox(  
        width: double.infinity,  
        child: OpeningHourDisplayWidget(  
          boxWidth: 600,  
          openTitle: "Open",  
          closeTitle: "Closed",  
          openDescription: "Opening time : 9:45",  
          closeDescription: "Closing at 16:15",  
          textSize: 30,  
          openHour: 10,  
          closeHour: 16,  
          iconSize: 30,  
          openColor: Colors.green,  
          closeColor: Colors.red,  
        )  
      )  
      ]  
  )  
)