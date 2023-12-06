@Component
export struct tabContentInfo {
  @Styles TextStyle(){
    .width("100%")
    .height(40)
    .padding({ left: 10, right: 10 })
  }

  build() {
    List({ space: 1 }) {
      ListItem() {
        Column() {
          Column() {
            Row() {
              Text("沈米") {
              }.fontSize(20).width("100%")
              .TextStyle()
            }

            Row() {
              Text("知识出处")
              Text("澳门地理")
            }
            .TextStyle()
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              Text("传略")
              Scroll() {
                Text("是年澳督Ferrcira do Amarai領兵入攻望廈引起士人之憤激，有沈米者，聚衆抗拒，計撒豆于路上，使葡兵馬蹄翻跌，事果，以鐮刀砍F.do Amaral下領，F.do Amaral帶馬負傷奔至蓮峰廟左側與蓮花莖路間大石墮馬而死，當時，沈米進斬其首級，献于廣州。其後葡人與我提出交涉，我積弱畏事，寧治沈米死罪，後葬於前山。")
                  .width("50%")
              }.scrollable(ScrollDirection.Vertical)
              .scrollBar(BarState.On)
              .scrollBarWidth(1)
            }.justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Top)
            .TextStyle()
          }
          .border({ color: Color.Gray, width: 1, style: BorderStyle.Solid })
          .padding(10)
        }.padding(10)
      }
    }.lanes(1)
    .width("100%")
    .listDirection(Axis.Vertical)
    .divider({ color: Color.Gray, strokeWidth: 1 })
  }
}