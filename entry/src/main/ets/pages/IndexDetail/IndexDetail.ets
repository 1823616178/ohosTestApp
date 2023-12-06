import router from '@ohos.router'
import hilog from '@ohos.hilog'
import { getBookDetail, selectBookKnowledgeListBySourceId } from '../../api/Index'
import { advancedRetrievalParamsInf, commonQueryType, commonResultRows, resultType } from '../../model/common'
import {
  bookDetailModel,
  detailResultType,
  infoDicModel,
  selectBookKnowledgeListBySourceIdRows
} from '../../model/indexDetail'
import { tabMain } from '../conponse/TabContentInfo/tabMain'

@Entry
@Component
struct IndexDetail {
  @State baseURL: string = getContext(this).resourceManager.getStringSync($r('app.string.baseImageURL').id)
  params = router.getParams()
  @State sourceId: string = this.params['sourceId']
  @State bookDetail: bookDetailModel = {}
  @State infoDic: infoDicModel[] = []
  @State tabType: string = ""
  @State tabName: infoDicModel[] = [
    { key: "person", value: '人物', type: 300 },
    { key: "organization", value: '机构', type: 310 },
    { key: "event", value: '事件', type: 320 },
    { key: "geographical", value: '地名', type: 330 },
    { key: "product", value: '物产', type: 340 },
    { key: "object", value: '实物', type: 360 },
    { key: "work", value: '作品', type: 350 },
  ]
  @State @Watch("changListNumber") tabIndexNumber: number = 0
  @State advancedRetrievalParams: advancedRetrievalParamsInf = {
    field: "sourceId",
    keyword: "12jh003691",
    match: "term",
    relation: "must"
  }
  @Provide @Watch("changePageNum") pageNum: number = 1
  @State knowListQuery: commonQueryType = {
    advancedRetrievalParams: [this.advancedRetrievalParams],
    component: this.tabName[this.tabIndexNumber].key,
    label: this.tabName[this.tabIndexNumber].value,
    order: "asc",
    page: this.pageNum,
    rows: 5,
    type: this.tabName[this.tabIndexNumber].type,
    value: this.tabName[this.tabIndexNumber].key,
  }
  @Provide knowList: Object[] = []
  /**
   * 初始化
   */
  async onPageShow() {
    await this.getBookDetailInit()
    await this.getTabsList()
  }
  /**
   * 当改变tab时
   */
  async changListNumber() {
    this.knowList = []
    this.pageNum = 1
    await this.getTabsList()
  }
  /**
   * 当改变pageNum时
   */
  async changePageNum() {
    if (this.pageNum > 1) {
      await this.getTabsList()
    }
  }

  async getBookDetailInit() {
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
  /**
   * 整合信息类型
   * @param data
   */
  async pushKeyToInfoDic(data: bookDetailModel) {
    this.infoDic.push({ key: "著者", value: data.author || "" })
    this.infoDic.push({ key: "创作时间", value: data.publishDate || "" })
    this.infoDic.push({ key: "创作地点", value: data.publishPlace || "" })
    this.infoDic.push({ key: "语种", value: data.languageType || "" })
    this.infoDic.push({ key: "分类号", value: data.classificationCode || "" })
  }
  /**
   * 请求知识数据
   * @param index
   */
  async getTabsList() {
    this.knowListQuery.component = this.tabName[this.tabIndexNumber].key
    this.knowListQuery.label = this.tabName[this.tabIndexNumber].value
    this.knowListQuery.value = this.tabName[this.tabIndexNumber].key
    this.knowListQuery.type = this.tabName[this.tabIndexNumber].type
    this.knowListQuery.page = this.pageNum
    await selectBookKnowledgeListBySourceId(this.knowListQuery)
      .then((res: resultType<commonResultRows<Object[]>>) => {
        if (this.knowList.length < res.data.total) {
          this.knowList.push(...res.data.rows)
        }
      })
  }

  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Start }) {
      Row() {
        Text(this.bookDetail.title || "暂无标题")
          .height(60)
          .lineHeight(30)
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
        Text("摘要").fontSize(24).fontColor(Color.Black).fontWeight(FontWeight.Bold).margin({ top: 10 })
        Text("内分澳门之开埠、地理环境、人口、交通、经济活动、都市形态、澳门之将来等7章。书前有梁寒操等4人作序及著者序")
          .margin({ top: 20 })
          .padding({ left: 10, right: 10 })
      }

      Column() {
        Text("相关知识")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .height(30)
          .lineHeight(30)
        tabMain({
          tabName: $tabName,
          tabIndexNumber: $tabIndexNumber
        }).layoutWeight(1)
      }
      .justifyContent(FlexAlign.Center)
      .height(500)
      .margin({ top: 20 })

    }.width('100%')
  }
}

