import { Theme, RunningViewModel, RunStatus, formatPace, formatDistance, formatDuration } from 'common/Index'
import { RunStatCompact } from '../components/RunStatCard'
import router from '@ohos.router'

@Entry
@Component
struct RunningPage {
  @State viewModel: RunningViewModel = new RunningViewModel()
  @State displayDuration: string = '00:00'
  @State displayDistance: string = '0.0'
  @State displayPace: string = "--'--\""
  @State displayCalories: string = '0'
  @State displayHr: string = '--'
  @State isPaused: boolean = false
  private tickInterval: number = -1

  aboutToAppear() {
    this.viewModel.start()
    this.startDisplayTick()
  }

  aboutToDisappear() {
    this.stopDisplayTick()
  }

  build() {
    Column() {
      // Timer
      Text(this.displayDuration)
        .fontSize(40)
        .fontColor(Theme.TEXT_PRIMARY)
        .fontWeight(Theme.FONT_BOLD)
        .margin({ top: Theme.SPACE_48 })

      // Stats row
      Row() {
        RunStatCompact({ label: '距离', value: this.displayDistance, unit: 'km' })
        RunStatCompact({ label: '配速', value: this.displayPace, unit: '/km' })
        RunStatCompact({ label: '卡路里', value: this.displayCalories, unit: 'kcal' })
      }
      .width('100%')
      .margin({ top: Theme.SPACE_32 })
      .justifyContent(FlexAlign.SpaceEvenly)

      // Heart rate
      Row() {
        Text('心率')
          .fontSize(Theme.FONT_BODY)
          .fontColor(Theme.TEXT_SECONDARY)
          .fontWeight(Theme.FONT_REGULAR)
        Blank()
        Text(this.displayHr)
          .fontSize(Theme.FONT_TITLE)
          .fontColor(Theme.BRAND)
          .fontWeight(Theme.FONT_BOLD)
        Text(' bpm')
          .fontSize(Theme.FONT_CAPTION)
          .fontColor(Theme.TEXT_SECONDARY)
          .fontWeight(Theme.FONT_REGULAR)
      }
      .width('100%')
      .padding(Theme.SPACE_16)
      .borderRadius(Theme.RADIUS_LG)
      .backgroundColor(Theme.BG)
      .border({ width: 1, color: Theme.BORDER })
      .margin({ top: Theme.SPACE_24 })

      Blank()

      // Controls
      Row() {
        Button(this.isPaused ? '继续' : '暂停')
          .width('45%')
          .height(48)
          .backgroundColor(Theme.TEXT_PRIMARY)
          .fontColor('#FFFFFF')
          .fontSize(Theme.FONT_BODY)
          .fontWeight(Theme.FONT_BOLD)
          .borderRadius(Theme.RADIUS_SM)
          .onClick(() => {
            this.togglePause()
          })

        Button('结束')
          .width('45%')
          .height(48)
          .backgroundColor(Theme.BG)
          .fontColor(Theme.TEXT_PRIMARY)
          .fontSize(Theme.FONT_BODY)
          .fontWeight(Theme.FONT_BOLD)
          .borderRadius(Theme.RADIUS_SM)
          .border({ width: 1, color: Theme.BORDER })
          .onClick(() => {
            this.finishRun()
          })
      }
      .width('100%')
      .padding({ left: Theme.SPACE_16, right: Theme.SPACE_16, bottom: Theme.SPACE_32 })
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Theme.BG)
    .padding({ left: Theme.SPACE_16, right: Theme.SPACE_16, top: Theme.SPACE_16 })
  }

  private startDisplayTick(): void {
    this.tickInterval = setInterval(() => {
      this.updateDisplay()
    }, 1000)
  }

  private stopDisplayTick(): void {
    if (this.tickInterval !== -1) {
      clearInterval(this.tickInterval)
      this.tickInterval = -1
    }
  }

  private updateDisplay(): void {
    const state = this.viewModel.runningState
    this.displayDuration = formatDuration(state.duration)
    this.displayDistance = formatDistance(state.distance)
    this.displayPace = formatPace(state.currentPace)
    this.displayCalories = state.calories.toString()
    this.displayHr = state.currentHr > 0 ? state.currentHr.toString() : '--'
  }

  private togglePause(): void {
    if (this.isPaused) {
      this.viewModel.resume()
      this.isPaused = false
    } else {
      this.viewModel.pause()
      this.isPaused = true
    }
  }

  private finishRun(): void {
    this.stopDisplayTick()
    const record = this.viewModel.stop()
    router.replaceUrl({
      url: 'pages/RunResultPage',
      params: { record: JSON.stringify(record) }
    })
  }
}
