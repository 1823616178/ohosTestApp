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
          tabContentInfo({tabIndexNumber:this.tabIndexNumber})
        }.tabBar(item.value)
        .align(Alignment.Top)
      })
    }
    .barHeight(500)
    .onChange(async (index) => {
      this.tabIndexNumber = index
    })
  }
}