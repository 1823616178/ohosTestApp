import router from '@ohos.router'
import { getBookDetail } from '../api/Index'
import { bookDetailModel, detailResultType } from '../model/indexDetail'

@Entry
@Component
struct IndexDetail {
  @State baseURL: string = getContext(this).resourceManager.getStringSync($r('app.string.baseImageURL').id)
  params = router.getParams()

  @Styles Title() {

  }

  @State sourceId: string = this.params['sourceId']
  @State bookDetail: bookDetailModel = {}

  /**
   * 初始化
   */
  async onPageShow() {
    let query = {
      sourceId: this.sourceId
    }
    await getBookDetail(query).then((res: detailResultType<bookDetailModel>) => {
      if (res) {
        this.bookDetail = res.data
      }
    })
  }

  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Start }) {
      Row() {
        Text(this.bookDetail.title || "暂无标题")
          .fontSize(24)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.Center)
      .width("100%")

      Column() {
        Row() {
          Text("著者")
          Text("何大章,缪鸿基合著")
        }

        Row() {
          Text("著者")
          Text("何大章,缪鸿基合著")
        }

        Row() {
          Text("著者")
          Text("何大章,缪鸿基合著")
        }

        Row() {
          Text("著者")
          Text("何大章,缪鸿基合著")
        }

        Row() {
          Text("著者")
          Text("何大章,缪鸿基合著")
        }
      }.justifyContent(FlexAlign.SpaceBetween)
      .width("100%")

      Column() {
        Text("摘要")
        Text("内分澳门之开埠、地理环境、人口、交通、经济活动、都市形态、澳门之将来等7章。书前有梁寒操等4人作序及著者序")
      }
    }.width('100%')
  }
}

