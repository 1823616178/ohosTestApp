import router from '@ohos.router'
import document from '@ohos.document'
import { getBookNavList, selectBookContentFileInfo } from '../../../api/read'
import { resultType } from '../../../model/common'
import { bookListModel, bookNavList } from '../../../model/read'
import { articleContent } from './composent/articleContent'
import { navList } from './composent/navList'
import { HtmlToObj } from './composent/xmlAnalysis'

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
  @State bookContent: bookListModel = {}
  @State navListLoading: boolean = false
  @State contentLoading: boolean = false
  @State contentText: string = ""
  /**
   * 初始化
   */
  async onPageShow() {
    await this.getReadNav()
    await this.getBookContent()
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
    this.navListLoading = true
    await getBookNavList(query).then((res: resultType<bookNavList[]>) => {
      this.navList = res.data
    }).finally(() => {
      this.contentLoading = false
    })
  }
  /**
   * 获取图书内容
   */
  private getBookContent = async () => {
    let query = {
      sourceId: this.sourceId,
      identifier: this.identifier || "",
      volume: this.volume || ""
    }
    this.contentLoading = true
    await selectBookContentFileInfo(query).then(async (res: resultType<bookListModel>) => {
      this.bookContent = res.data
      await this.onContentChange()
      if (this.contentText.length>0){
        await HtmlToObj(this.contentText)
      }
    }).finally(() => {
      this.contentLoading = false
    })
  }
  /***
   * 请求导航对应内容
   */
  private getNavToContent = async (item: bookNavList) => {
    this.sourceId = item.sourceId
    this.identifier = item.identifier
    await this.getBookContent()
  }
  /***
   * 过滤文章内容
   */
  private async onContentChange() {
    let cont = ""
    this.contentText = ""
    if (this.bookContent.filePathArray) {
      for (let i of this.bookContent.filePathArray) {
        cont += i.content
      }
    }
    this.contentText = cont
  }

  build() {
    SideBarContainer(SideBarContainerType.Embed) {
      Column() {
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
                  navList({ childrenList: item.children, getNavToContent: this.getNavToContent })
                }
              }
              .padding({ left: 5, right: 5 })
              .width("100%")
              .margin({ top: 5 })
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .onClick(async () => {
                this.current = item.rid
                if (item.children) {
                    this.ridList.indexOf(item.rid) > -1 ? this.ridList.splice(this.ridList.indexOf(item.rid, 1)) : this.ridList.push(item.rid)
                } else {
                  await this.getNavToContent(item)
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
      }

      Column() {
        if (this.contentLoading) {
          Column() {
            LoadingProgress().color(Color.Green).width(40).height(40)
          }.height("100%").width("100%").alignItems(HorizontalAlign.Center).justifyContent(FlexAlign.Center)
        } else {
          articleContent({
            contentText: this.contentText,
            bookContent: $bookContent
          })
        }
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