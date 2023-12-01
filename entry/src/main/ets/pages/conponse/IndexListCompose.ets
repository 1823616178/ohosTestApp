import router from '@ohos.router'
import { selectBookDbo } from '../../model/Index'
import { touchModel } from '../../model/touchModel'
import { listenTouchEvent } from './IndexListExtend/touchExtend'

@Component
export struct IndexListCompose {
  @Link homeData: selectBookDbo[]
  @Prop baseURL: string
  private touch: touchModel = new touchModel();
  @Link isRefresh: boolean

  private calcHeight() {
    let AllHeight: number = globalThis.AllHeight
    return px2vp(AllHeight) - 300
  }

  private toDetailPage() {
    router.pushUrl({ url: "pages/IndexDetail" })
  }

  build() {
    List() {
      ForEach(this.homeData, (item: selectBookDbo, index) => {
        ListItem() {
          Button() {
            Column() {
              Image(this.baseURL + item.filePath)
                .width("100%").height(200).objectFit(ImageFit.Contain)
              Text(item.title)
                .fontSize(16)
                .width("100%")
                .lineHeight(20)
                .textAlign(TextAlign.Center)
                .height(20)
                .fontWeight(FontWeight.Bold)
            }
          }.type(ButtonType.Normal).backgroundColor(Color.White)
          .onClick(() => {
            this.toDetailPage()
          })
        }
        .margin({ bottom: 5 })
        .borderColor($r('app.color.home_card'))
        .border({ width: 1 })
        .borderRadius(5)
        .width("98%")
      })
    }
    .onTouch((event: TouchEvent) => {
      listenTouchEvent(this.touch, event, this.isRefresh)
    })
    .height(this.calcHeight())
    .lanes(2)
    .alignListItem(ListItemAlign.Center)
    .listDirection(Axis.Vertical)
    .scrollBar(BarState.Auto)
  }
}