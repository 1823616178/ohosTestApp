import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';

export default class EntryAbility extends UIAbility {
  private AllHeight: number = 0

  async onCreate(want, launchParam) {
    this.AllHeight = await this.getWinScreenWidth()
    globalThis.AllHeight = this.AllHeight
  }

  /**
   * 获取屏幕宽度
   * @returns
   */
  private async getWinScreenWidth() {
    let obj = await window.getLastWindow(this.context).then((lastWindow) => {
      let {bottomRect,topRect,rightRect} = lastWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      return bottomRect.top
    })
    return obj
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    windowStage.loadContent('pages/Index/Index', (err, data) => {
      if (err.code) {
        return;
      }
    });
  }

  onWindowStageDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
