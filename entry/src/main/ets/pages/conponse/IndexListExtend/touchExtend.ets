import { touchModel } from '../../../model/touchModel'

export function listenTouchEvent(model: touchModel, event: TouchEvent, isRefresh: boolean) {
  switch (event.type) {
    case TouchType.Down:
      model.downY = event.touches[0].y
      model.lastMoveY = event.touches[0].y
      break;
    case TouchType.Move:
      let isDownPull = event.touches[0].y - model.lastMoveY > 0
      if (((isDownPull === true) || (isRefresh === true)) && (model.isCanLoadMore === false)) {
        console.log(model.downY.toString())
      } else {
        console.log(model.downY.toString())
      }
  }
}