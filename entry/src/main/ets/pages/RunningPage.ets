// 跑步中页面
import { DesignTokens, RunningViewModel, RunStatus, formatPace, formatDistance, formatDuration } from '../viewmodel/RunningViewModel'
import { HrZoneBar } from '../components/HrZoneBar'
import { RunStatCardCompact } from '../components/RunStatCard'
import router from '@ohos.router'

@Entry
@Component
struct RunningPage {
  @State viewModel: RunningViewModel = new RunningViewModel()
  @State displayDuration: string = '00:00:00'
  @State displayDistance: string = '0.0'
  @State displayPace: string = "--'--\""
  @State displayCalories: string = '0'
  @State displayHr: string = '--'
  @State displayHrZone: number = 1
  @State isRunning: boolean = false
  @State isPaused: boolean = false
  private tickInterval: number = -1

  aboutToAppear() {
    this.viewModel.start()
    this.isRunning = true
    this.startDisplayTick()
  }

  aboutToDisappear() {
    this.stopDisplayTick()
  }

  build() {
    Column() {
      // 顶部：轨迹地图占位区
      Row()
        .width('100%')
        .height(200)
        .backgroundColor(DesignTokens.BG_SUB)
        .borderRadius(DesignTokens.RADIUS_LG)

      // 大号计时器
      Text(this.displayDuration)
        .fontSize(40)
        .fontColor(DesignTokens.TEXT_PRIMARY)
        .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
        .margin({ top: DesignTokens.SPACE_24 })

      // 3 列指标
      Row() {
        RunStatCardCompact({ label: '距离', value: this.displayDistance, unit: 'km' })
        RunStatCardCompact({ label: '配速', value: this.displayPace, unit: '/km' })
        RunStatCardCompact({ label: '卡路里', value: this.displayCalories, unit: 'kcal' })
      }
      .width('100%')
      .margin({ top: DesignTokens.SPACE_24 })
      .justifyContent(FlexAlign.SpaceEvenly)

      // 心率实时面板
      this.HeartRatePanel()

      Blank()

      // 底部按钮
      Row() {
        Button(this.isPaused ? '继续' : '暂停')
          .width('45%')
          .height(48)
          .backgroundColor(DesignTokens.TEXT_PRIMARY)
          .fontColor('#FFFFFF')
          .fontSize(DesignTokens.FONT_BODY)
          .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
          .borderRadius(DesignTokens.RADIUS_SM)
          .onClick(() => {
            this.togglePause()
          })

        Button('结束')
          .width('45%')
          .height(48)
          .backgroundColor(DesignTokens.BG)
          .fontColor(DesignTokens.TEXT_PRIMARY)
          .fontSize(DesignTokens.FONT_BODY)
          .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
          .borderRadius(DesignTokens.RADIUS_SM)
          .border({ width: 1, color: DesignTokens.BORDER })
          .onClick(() => {
            this.finishRun()
          })
      }
      .width('100%')
      .padding({ left: DesignTokens.SPACE_16, right: DesignTokens.SPACE_16, bottom: DesignTokens.SPACE_32 })
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.BG)
    .padding({ left: DesignTokens.SPACE_16, right: DesignTokens.SPACE_16, top: DesignTokens.SPACE_16 })
  }

  @Builder
  HeartRatePanel() {
    Column() {
      // 当前心率
      Row() {
        Text('心率')
          .fontSize(DesignTokens.FONT_BODY)
          .fontColor(DesignTokens.TEXT_SECONDARY)
          .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
        Blank()
        Text(this.displayHr)
          .fontSize(DesignTokens.FONT_TITLE)
          .fontColor(this.getHrZoneColor())
          .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
        Text(' bpm')
          .fontSize(DesignTokens.FONT_CAPTION)
          .fontColor(DesignTokens.TEXT_SECONDARY)
          .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
      }
      .width('100%')
      .margin({ bottom: DesignTokens.SPACE_8 })

      // 心率5区间横条
      HrZoneBar({ hrZones: this.viewModel.runningState.hrZones, showLabels: true })
    }
    .width('100%')
    .padding(DesignTokens.SPACE_16)
    .borderRadius(DesignTokens.RADIUS_LG)
    .backgroundColor(DesignTokens.BG)
    .border({ width: 1, color: DesignTokens.BORDER })
    .margin({ top: DesignTokens.SPACE_24 })
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
    this.displayHrZone = state.hrZone
  }

  private togglePause(): void {
    if (this.isPaused) {
      this.viewModel.resume()
      this.isPaused = false
      this.isRunning = true
    } else {
      this.viewModel.pause()
      this.isPaused = true
      this.isRunning = false
    }
  }

  private finishRun(): void {
    this.stopDisplayTick()
    const record = this.viewModel.stop()
    // 将结果传递到结果页
    router.replaceUrl({
      url: 'pages/RunResultPage',
      params: {
        record: JSON.stringify(record),
      }
    })
  }

  private getHrZoneColor(): string {
    const colors = [
      DesignTokens.HR_ZONE_1,
      DesignTokens.HR_ZONE_2,
      DesignTokens.HR_ZONE_3,
      DesignTokens.HR_ZONE_4,
      DesignTokens.HR_ZONE_5,
    ]
    const idx = Math.max(0, Math.min(this.displayHrZone - 1, 4))
    return colors[idx]
  }
}
