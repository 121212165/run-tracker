import { UIAbility, AbilityConstant, Want } from '@kit.AbilityKit'
import { window } from '@kit.ArkUI'

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.info('[RunTracker] EntryAbility onCreate')
  }

  onDestroy(): void {
    console.info('[RunTracker] EntryAbility onDestroy')
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    console.info('[RunTracker] EntryAbility onWindowStageCreate')
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        console.error(`[RunTracker] Failed to load content: ${JSON.stringify(err)}`)
        return
      }
      console.info('[RunTracker] Succeeded in loading content')
    })
  }

  onWindowStageDestroy(): void {
    console.info('[RunTracker] EntryAbility onWindowStageDestroy')
  }

  onForeground(): void {
    console.info('[RunTracker] EntryAbility onForeground')
  }

  onBackground(): void {
    console.info('[RunTracker] EntryAbility onBackground')
  }
}
