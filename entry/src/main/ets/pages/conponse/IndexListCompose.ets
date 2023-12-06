import router from '@ohos.router'
import { selectBookDbo, selectBookQuery } from '../../model/Index'
import { PullToRefresh, PullToRefreshConfigurator } from '@ohos/pulltorefresh'
import hilog from '@ohos.hilog'
import { loadMoreData, pullTopData } from './IndexListExtend/touchExtend'

@Component
export struct IndexListCompose {
  @Prop baseURL: string
  @Link ListModel: selectBookDbo[]
  @Link query: selectBookQuery
  private scroller: Scroller = new Scroller()
  private refreshConfigurator: PullToRefreshConfigurator = new PullToRefreshConfigurator();

  aboutToAppear() {
    // 设置属性
    this.refreshConfigurator
      .setHasRefresh(true) // 是否具有下拉刷新功能
      .setHasLoadMore(true) // 是否具有上拉加载功能
      .setMaxTranslate(150) // 可下拉上拉的最大距离
      .setSensitivity(1) // 下拉上拉灵敏度
      .setListIsPlacement(false) // 滑动结束后列表是否归位
      .setAnimDuration(300) // 滑动结束后，回弹动画执行时间
      .setRefreshHeight(80) // 下拉动画高度
      .setRefreshColor(Color.Black.toString()) // 下拉动画颜色
      .setRefreshBackgroundColor(Color.Gray.toString()) // 下拉动画区域背景色
      .setRefreshTextColor('red') // 下拉加载完毕后提示文本的字体颜色
      .setRefreshTextSize(16) // 下拉加载完毕后提示文本的字体大小
      .setRefreshAnimDuration(1000) // 下拉动画执行一次的时间
      .setLoadImgHeight(50) // 上拉图片高度
      .setLoadBackgroundColor(Color.Gray.toString()) // 上拉动画区域背景色
      .setLoadTextColor(Color.Black.toString()) // 上拉文本的字体颜色
      .setLoadTextSize(16) // 上拉文本的字体大小
      .setLoadTextPullUp1('请继续上拉...') // 上拉1阶段文本
      .setLoadTextPullUp2('释放即可刷新')
      .setLoadTextLoading('加载中...')
  }

  private toDetailPage(item: selectBookDbo) {
    router.pushUrl({ url: "pages/IndexDetail/IndexDetail", params: { sourceId: item.sourceId } })
  }

  @Builder
  private pullItem() {
    List({ scroller: this.scroller }) {
      ForEach(this.ListModel, (item: selectBookDbo, index) => {
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
            this.toDetailPage(item)
          })
        }
        .margin({ bottom: 5 })
        .borderColor($r('app.color.home_card'))
        .border({ width: 1 })
        .borderRadius(5)
        .width("98%")
      })
    }
    .edgeEffect(EdgeEffect.None)
    .lanes(2)
    .layoutWeight(1)
    .alignListItem(ListItemAlign.Center)
    .listDirection(Axis.Vertical)
  }

  build() {
    Column() {
      PullToRefresh({
        data: $ListModel,
        scroller: this.scroller,
        refreshConfigurator: this.refreshConfigurator,
        customList: () => {
          this.pullItem()
        },
        onRefresh: () => {
          return new Promise<string>(async (resolve, reject) => {
            try {
              await pullTopData(this.ListModel, this.query)
              resolve("刷新成功")
            } catch (e) {
              reject('')
            }
          })
        },
        onLoadMore: () => {
          return new Promise<string>(async (resolve, reject) => {
            try {
              await loadMoreData(this.ListModel, this.query)
              resolve("刷新成功")
            } catch (e) {
              reject(e)
            }
          })
        },
        customRefresh: null,
        customLoad: null
      })
    }
    .height("100%")
    .layoutWeight(1)
  }
}