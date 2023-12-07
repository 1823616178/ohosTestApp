import { bookNavList } from '../../../../model/read'

@Component
export struct navList {
  childrenList: bookNavList[]
  @Consume current: string

  build() {
    Column() {
      ForEach(this.childrenList, (item: bookNavList, index) => {
        Column() {
          Text(item.partName || "暂无")
            .fontSize(16)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontColor(this.current === item.parentRid ? '#0A59F7' : '#999')
            .maxLines(1)
            .textAlign(TextAlign.Start)
            .width("100%")
            .fontColor("#999")
            .onClick(() => {
              this.current = item.parentRid
            })
          if (item.children) {
            navList({ childrenList: item.children })
          }
        }
        .padding({ left: 10, right: 0 })
        .width("100%")
        .margin({ top: 5 })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      })
    }
  }
}