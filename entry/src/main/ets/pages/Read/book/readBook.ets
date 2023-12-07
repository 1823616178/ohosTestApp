import router from '@ohos.router'
import { getBookNavList } from '../../../api/read'
import { resultType } from '../../../model/common'
import { bookNavList } from '../../../model/read'
import { navList } from './composent/navList'

@Entry
@Component
struct readBook {
  normalIcon: Resource = $r("app.media.icon")
  selectedIcon: Resource = $r("app.media.icon")
  @Provide current: string = ''
  params = router.getParams()
  @Provide sourceId: string = this.params['sourceId']
  @Provide identifier: string = this.params['identifier']
  @Provide volume: string = this.params['volume']
  @Provide navList: bookNavList[] = []
  @Provide ridList: string[] = []

  /**
   * 初始化
   */
  async onPageShow() {
    await this.getReadNav()
  }
  /**
   * 获取图书导航栏
   */
  private getReadNav = async () => {
    let query = {
      sourceId: "17jh000166",
      volume: "001",
      basicType: "图书"
    }
    await getBookNavList(query).then((res: resultType<bookNavList[]>) => {
      this.navList = res.data
    })
  }

  build() {
    SideBarContainer(SideBarContainerType.Embed) {
      Scroll() {
        Column() {
          ForEach(this.navList, (item: bookNavList, index) => {
            Column() {
              Text(item.partName || "暂无")
                .fontSize(16)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .maxLines(1)
                .fontColor(this.current === item.rid ? '#0A59F7' : '#999')
                .textAlign(TextAlign.Start)
                .width("100%")
              if (item.children && this.ridList.indexOf(item.rid) > -1) {
                navList({ childrenList: item.children })
              }
            }
            .padding({ left: 5, right: 5 })
            .width("100%")
            .margin({ top: 5 })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              this.current = item.rid
              if (item.children) {
                  this.ridList.indexOf(item.rid) > -1 ? this.ridList.splice(this.ridList.indexOf(item.rid, 1)) : this.ridList.push(item.rid)
              }
            })
          }, item => item)
        }
        .padding({ top: 40 })
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#19000000')
      }.scrollBar(BarState.Off)
      .scrollable(ScrollDirection.Vertical)

      Column() {

      }
      .margin({ top: 50, left: 20, right: 30 })
    }
    .controlButton({
      top: 10,
      left: 10,
      width: 25,
      height: 25
    })
    .sideBarWidth("50%")
    .minSideBarWidth(50)
    .maxSideBarWidth(300)
    .onChange((value: boolean) => {
      console.info('status:' + value)
    })
  }
}