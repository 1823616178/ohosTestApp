import router from '@ohos.router'
import { selectBookDbo } from '../../model/Index'
import { PullToRefresh } from '@ohos/pulltorefresh'

@Component
export struct IndexListCompose {
  @Prop baseURL: string
  @Link ListModel: selectBookDbo[]
  private scroller: Scroller = new Scroller()

  private toDetailPage() {
    router.pushUrl({ url: "pages/IndexDetail" })
  }

  @Builder pullItem() {
    Column() {
      ForEach(this.ListModel, (item: selectBookDbo, index) => {
        Column() {
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
  }

  build() {
    Column() {
      PullToRefresh({
        data: $ListModel,
        scroller: this.scroller,
        customList: () => {
          this.pullItem
        } }) {
      }
      .height("100%")
      .layoutWeight(1)
    }
  }
}