import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';
import hilog from '@ohos.hilog';

export default class HomeAbility extends UIAbility {
  onCreate(want, launchParam) {
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    windowStage.loadContent("pages/IndexDetail", (err, data) => {
      if (err.code) {
        hilog.error(0x000, "log", err.code.toString())
        return
      }
    })

  }
}