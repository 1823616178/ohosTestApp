@Entry
@Component
struct IndexDetail {
  @State baseURL: string = getContext(this).resourceManager.getStringSync($r('app.string.baseImageURL').id)

  build() {
    Text("还没写").fontSize(50).fontColor(Color.Grey)
  }
}

