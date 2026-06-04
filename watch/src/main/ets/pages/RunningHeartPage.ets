import { router } from '@kit.ArkUI'

const COLORS = {
  BG: '#000000',
  TEXT: '#FFFFFF',
  TEXT_DIM: '#666666',
  BRAND: '#E8453C',
  SUCCESS: '#22C55E',
  HR_Z1: '#22C55E',
  HR_Z2: '#84CC16',
  HR_Z3: '#EAB308',
  HR_Z4: '#F97316',
  HR_Z5: '#E8453C'
}

interface HrZoneInfo {
  name: string
  color: string
  duration: string
  progress: number
}

@Entry
@Component
struct RunningHeartPage {
  @State heartRate: number = 156
  @State currentZone: number = 3
  @State isPaused: boolean = false

  private zones: HrZoneInfo[] = [
    { name: 'Z1 热身', color: COLORS.HR_Z1, duration: '2:30', progress: 0.4 },
    { name: 'Z2 燃脂', color: COLORS.HR_Z2, duration: '8:15', progress: 0.8 },
    { name: 'Z3 有氧', color: COLORS.HR_Z3, duration: '6:42', progress: 0.6 },
    { name: 'Z4 无氧', color: COLORS.HR_Z4, duration: '3:10', progress: 0.2 },
    { name: 'Z5 最大', color: COLORS.HR_Z5, duration: '0:00', progress: 0.0 }
  ]

  build() {
    Column() {
      // 大字心率
      Row() {
        Text(`${this.heartRate}`)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.BRAND)
        Text(' bpm')
          .fontSize(14)
          .fontColor(COLORS.TEXT_DIM)
          .margin({ left: 4 })
      }
      .margin({ top: 24, bottom: 20 })

      // 5个区间进度条
      Column() {
        ForEach(this.zones, (zone: HrZoneInfo, index: number) => {
          Row() {
            // 区间名
            Text(zone.name)
              .fontSize(12)
              .fontColor(index + 1 === this.currentZone ? COLORS.TEXT : COLORS.TEXT_DIM)
              .width(56)

            // 进度条
            Stack() {
              Row()
                .width('100%')
                .height(4)
                .backgroundColor(COLORS.TEXT_DIM)
                .borderRadius(2)
              Row()
                .width(`${zone.progress * 100}%`)
                .height(4)
                .backgroundColor(zone.color)
                .borderRadius(2)
                .alignSelf(ItemAlign.Start)
            }
            .layoutWeight(1)
            .height(4)
            .margin({ left: 8, right: 8 })

            // 时长
            Text(zone.duration)
              .fontSize(12)
              .fontColor(index + 1 === this.currentZone ? COLORS.TEXT : COLORS.TEXT_DIM)
              .width(36)
              .textAlign(TextAlign.End)
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .alignItems(VerticalAlign.Center)
        }, (index: number) => index.toString())
      }
      .layoutWeight(1)

      // 页码指示器 ○ ● ○
      Row() {
        Row()
          .width(8)
          .height(8)
          .borderRadius(4)
          .backgroundColor(COLORS.TEXT_DIM)
        Row()
          .width(8)
          .height(8)
          .borderRadius(4)
          .backgroundColor(COLORS.TEXT)
          .margin({ left: 8 })
        Row()
          .width(8)
          .height(8)
          .borderRadius(4)
          .backgroundColor(COLORS.TEXT_DIM)
          .margin({ left: 8 })
      }
      .margin({ bottom: 16 })

      // 暂停按钮
      Button(this.isPaused ? '继续' : '暂停')
        .width(80)
        .height(36)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.TEXT)
        .backgroundColor(this.isPaused ? COLORS.SUCCESS : COLORS.TEXT_DIM)
        .borderRadius(8)
        .margin({ bottom: 24 })
        .onClick(() => {
          this.isPaused = !this.isPaused
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.BG)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .swipeAction({ onSwipe: (direction: SwipeDirection) => {
      if (direction === SwipeDirection.Right) {
        router.pushUrl({ url: 'pages/RunningDataPage' })
      } else if (direction === SwipeDirection.Left) {
        router.pushUrl({ url: 'pages/RunningTimerPage' })
      }
    }})
  }
}
