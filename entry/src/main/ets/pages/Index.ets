import hilog from '@ohos.hilog'
import { getBookList } from '../api/Index'
import { resultType, selectBookDbo, selectBookQuery, swiperModel } from '../model/Index'
import { IndexListCompose } from './conponse/IndexListCompose'

@Entry
@Component
struct Index {
  @State homeData: selectBookDbo[] = []
  @State query: selectBookQuery = {
    advancedRetrievalParams: [],
    order: "",
    page: 1,
    rows: 10,
    sort: ""
  }
  @State baseURL: string = getContext(this).resourceManager.getStringSync($r('app.string.baseImageURL').id)
  @State swiperData: swiperModel[] = [
    {
      url: $r('app.media.home_tushu'),
    },
    {
      url: $r('app.media.home_newpaper'),
    },
    {
      url: $r('app.media.home_guji'),
    }
  ]
  @State offsetHeight: number = 0
  @State swiperHeight: number = 260
  @State isRefresh: boolean = false

  async onPageShow() {
    await getBookList(this.query).then((res: resultType) => {
      let data = res.data
      this.homeData = data.rows
    })
  }

  build() {
    Column() {
      Swiper() {
        ForEach(this.swiperData, (item: swiperModel, index) => {
          Row() {
            Image(item.url).width("100%").objectFit(ImageFit.Contain).width("50%").height("50%")
          }.width("100%").alignItems(VerticalAlign.Center).justifyContent(FlexAlign.Center)
        })
      }.height(this.swiperHeight)

      Column() {
        Refresh({ refreshing: this.isRefresh }) {
          IndexListCompose({
            isRefresh: $isRefresh,
            homeData: $homeData,
            baseURL: this.baseURL,
          })
        }
      }
    }
  }
}



