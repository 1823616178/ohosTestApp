import { infoDicModel } from '../../../model/indexDetail'
import { tabContentInfo } from './tabContentInfo'

@Component
export struct tabMain {
  @Link tabName: string[]
  @Link tabIndexNumber: number

  build() {
    Tabs({ barPosition: BarPosition.Start }) {
      ForEach(this.tabName, (item: infoDicModel, index) => {
        TabContent() {
          tabContentInfo()
        }.tabBar(item.value)
        .align(Alignment.Top)
      })
    }
    .barHeight(500)
    .onChange((index) => {
      this.tabIndexNumber = index
    })
  }
}