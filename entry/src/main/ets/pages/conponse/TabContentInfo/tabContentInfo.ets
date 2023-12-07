import common from '@ohos.app.ability.common'
import hilog from '@ohos.hilog'
import router from '@ohos.router'
import { selectBookKnowledgeListBySourceIdRows } from '../../../model/indexDetail'

@Component
export struct tabContentInfo {
  @Consume knowList: Object[]
  @Consume pageNum: number
  @Prop tabIndexNumber: number

  @Styles TextStyle(){
    .width("100%")
    .height(40)
    .padding({ left: 10, right: 10 })
  }
  /**
   * 跳转阅读ability
   */
  private async toReadAbility(data) {
    router.pushUrl({
      url: "pages/Read/book/readBook",
      params: {
        sourceId: data['sourceId'],
        identifier: data['identifier'],
        volume: data['volume']
      }
    })
  }

  build() {
    List({ space: 1 }) {
      ForEach(this.knowList, (item: Object, index) => {
        ListItem() {
          Column() {
            Column() {
              Row() {
                if (this.tabIndexNumber === 0) {
                  Text(item['personalName'] || "不详") {
                  }.fontSize(20).width("100%").TextStyle()
                }
                if (this.tabIndexNumber === 1) {
                  Text(item['chiOrganizationName'] || "不详") {
                  }.fontSize(20).width("100%").TextStyle()
                }
                if (this.tabIndexNumber === 2) {
                  Text(item['chiEventName'] || "不详") {
                  }.fontSize(20).width("100%").TextStyle()
                }
                if (this.tabIndexNumber === 3) {
                  Text(item['geographicalName'] || "不详") {
                  }.fontSize(20).width("100%").TextStyle()
                }
                if (this.tabIndexNumber === 4) {
                  Text(item['productName'] || "不详") {
                  }.fontSize(20).width("100%").TextStyle()
                }
                if (this.tabIndexNumber === 5) {
                  Text(item['sourceName'] || "不详") {
                  }.fontSize(20).width("100%").TextStyle()
                }
                if (this.tabIndexNumber === 6) {
                  Text(item['sourceName'] || "不详") {
                  }.fontSize(20).width("100%").TextStyle()
                }
              }

              Row() {
                Text("知识出处").textAlign(TextAlign.Start)
                Text(item['sourceName'] || "不详")
                  .textAlign(TextAlign.End)
                  .fontColor("#0099ff")
                  .decoration({ type: TextDecorationType.Underline, color: "#0099ff" })
                  .onClick(() => {
                    this.toReadAbility(item)
                  })
              }
              .TextStyle()
              .justifyContent(FlexAlign.SpaceBetween)

              Row() {
                Text("传略").textAlign(TextAlign.Start)
                Scroll() {
                  if (this.tabIndexNumber === 0) {
                    Text(item['biography'] || "暂无").width("50%").textAlign(TextAlign.End).lineHeight(16)
                  }
                  if (this.tabIndexNumber === 1) {
                    Text(item['description'] || "暂无").width("50%").textAlign(TextAlign.End).lineHeight(16)
                  }
                  if (this.tabIndexNumber === 2) {
                    Text(item['description'] || "暂无").width("50%").textAlign(TextAlign.End).lineHeight(16)
                  }
                  if (this.tabIndexNumber === 3) {
                    Text(item['azimuth'] || "暂无").width("50%").textAlign(TextAlign.End).lineHeight(16)
                  }
                  if (this.tabIndexNumber === 4) {
                    Text(item['description'] || "暂无").width("50%").textAlign(TextAlign.End).lineHeight(16)
                  }
                  if (this.tabIndexNumber === 5) {
                    Text(item['description'] || "暂无").width("50%").textAlign(TextAlign.End).lineHeight(16)
                  }
                  if (this.tabIndexNumber === 6) {
                    Text(item['description'] || "暂无").width("50%").textAlign(TextAlign.End).lineHeight(16)
                  }
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
      })
    }
    .lanes(1)
    .onReachEnd(() => {
      this.pageNum = this.pageNum + 1
    })
    .width("100%")
    .listDirection(Axis.Vertical)
    .edgeEffect(EdgeEffect.Spring)
  }
}