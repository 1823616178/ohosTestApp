import router from '@ohos.router'
import { getBookDetail } from '../api/Index'
import { resultType } from '../model/common'
import { bookDetailModel, detailResultType, infoDicModel } from '../model/indexDetail'

@Entry
@Component
struct IndexDetail {
  @State baseURL: string = getContext(this).resourceManager.getStringSync($r('app.string.baseImageURL').id)
  params = router.getParams()
  @State sourceId: string = this.params['sourceId']
  @State bookDetail: bookDetailModel = {}
  @State infoDic: infoDicModel[] = []

  /**
   * 初始化
   */
  async onPageShow() {
    let query = {
      sourceId: this.sourceId
    }
    await getBookDetail(query).then(async (res: resultType<bookDetailModel>) => {
      if (res) {
        this.bookDetail = res.data
        await this.pushKeyToInfoDic(res.data)
      }
    })
  }

  async pushKeyToInfoDic(data: bookDetailModel) {
    this.infoDic.push({ key: "著者", value: data.author || "" })
    this.infoDic.push({ key: "创作时间", value: data.publishDate || "" })
    this.infoDic.push({ key: "创作地点", value: data.publishPlace || "" })
    this.infoDic.push({ key: "语种", value: data.languageType || "" })
    this.infoDic.push({ key: "分类号", value: data.classificationCode || "" })
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
        ForEach(this.infoDic, (item: infoDicModel, index) => {
          Row() {
            Text(item.key)
            Text(item.value)
          }
          .width("100%")
          .height(30)
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({ left: 5, right: 5 })
          .margin({ top: 10 })
        })
      }.justifyContent(FlexAlign.SpaceBetween)
      .width("100%")

      Column() {
        Text("摘要")
        Text("内分澳门之开埠、地理环境、人口、交通、经济活动、都市形态、澳门之将来等7章。书前有梁寒操等4人作序及著者序")
      }
    }.width('100%')
  }
}

