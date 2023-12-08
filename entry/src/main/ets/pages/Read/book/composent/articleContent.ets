import { bookListModel } from '../../../../model/read'

@Component
export struct articleContent {
  @Link  bookContent: bookListModel
  @Prop  contentText: string
  /**
   * 监听变量修改，并赋值
   */


  build() {
    Column() {
      Text(this.contentText || "暂无内容") {
      }
    }.width("100%")
  }
}