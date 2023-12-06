import { infoDicModel, selectBookKnowledgeListBySourceIdRows } from '../../../model/indexDetail'
import { tabContentInfo } from './tabContentInfo'

@Component
export struct tabMain {
  @Link tabName: string[]
  @Link tabIndexNumber: number

  build() {
    Tabs({ barPosition: BarPosition.Start }) {
      ForEach(this.tabName, (item: infoDicModel, index) => {
        TabContent() {
          tabContentInfo({ tabIndexNumber: this.tabIndexNumber })
        }.tabBar(this.TabBuilder(item.value, index))
        .align(Alignment.Top)
      })
    }.layoutWeight(1)
    .vertical(false)
    .onChange(async (index) => {
      this.tabIndexNumber = index
    })
  }

  @Builder TabBuilder(title: string, targetIndex: number) {
    Column() {
      Text(title) {
      }.fontColor(targetIndex === this.tabIndexNumber ? "#0099ff" : Color.Black).fontSize(16)
    }.height(50)
    .justifyContent(FlexAlign.Center)
  }
}