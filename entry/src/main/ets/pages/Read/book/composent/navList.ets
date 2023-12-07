import { bookNavList } from '../../../../model/read'

@Component
export struct navList {
  childrenList: bookNavList[]
  @Consume current: string
  @Consume ridList: string[]

  build() {
    Column() {
      ForEach(this.childrenList, (item: bookNavList, index) => {
        Column() {
          Text(item.partName || "暂无")
            .fontSize(16)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontColor(this.current === item.rid ? '#0099ff' : '#999')
            .maxLines(1)
            .textAlign(TextAlign.Start)
            .width("100%")
            .onClick(() => {
              this.current = item.rid
              if (item.children && this.ridList.indexOf(item.rid) > -1) {
                  this.ridList.indexOf(item.rid) > -1 ? this.ridList.splice(this.ridList.indexOf(item.rid, 1)) : this.ridList.push(item.rid)
              }
            })
          if (item.children) {
            navList({ childrenList: item.children })
          }
        }
        .padding({ left: 10, right: 0 })
        .width("100%")
        .constraintSize({ minHeight: 20 })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      })
    }
  }
}