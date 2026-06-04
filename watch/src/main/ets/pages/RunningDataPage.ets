import { router } from '@kit.ArkUI'
import { HrZoneRow } from '../components/HrZoneRow'

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

@Entry
@Component
struct RunningDataPage {
  @State distance: string = '3.2'
  @State pace: string = '5\'42"'
  @State calories: string = '198'
  @State heartRate: number = 156
  @State currentZone: number = 3
  @State isPaused: boolean = false

  build() {
    Column() {
      // 大字距离
      Row() {
        Text(this.distance)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.TEXT)
        Text(' km')
          .fontSize(14)
          .fontColor(COLORS.TEXT_DIM)
          .margin({ left: 4 })
      }
      .margin({ top: 32, bottom: 16 })

      // 3列小字数据
      Row() {
        Column() {
          Text('配速')
            .fontSize(12)
            .fontColor(COLORS.TEXT_DIM)
          Text(this.pace)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLORS.TEXT)
            .margin({ top: 4 })
        }
        .layoutWeight(1)

        Column() {
          Text('千卡')
            .fontSize(12)
            .fontColor(COLORS.TEXT_DIM)
          Text(this.calories)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLORS.TEXT)
            .margin({ top: 4 })
        }
        .layoutWeight(1)

        Column() {
          Text('心率')
            .fontSize(12)
            .fontColor(COLORS.TEXT_DIM)
          Text(`${this.heartRate}`)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLORS.TEXT)
            .margin({ top: 4 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .margin({ bottom: 16 })

      // 心率5区间横条
      HrZoneRow({ currentZone: this.currentZone })
        .width('100%')
        .padding({ left: 16, right: 16 })
        .margin({ bottom: 16 })

      Blank()

      // 页码指示器 ● ○ ○
      Row() {
        Row()
          .width(8)
          .height(8)
          .borderRadius(4)
          .backgroundColor(COLORS.TEXT)
        Row()
          .width(8)
          .height(8)
          .borderRadius(4)
          .backgroundColor(COLORS.TEXT_DIM)
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
          if (this.isPaused) {
            // 暂停逻辑
          } else {
            // 继续逻辑
          }
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.BG)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .swipeAction({ onSwipe: (direction: SwipeDirection) => {
      if (direction === SwipeDirection.Left) {
        router.pushUrl({ url: 'pages/RunningHeartPage' })
      }
    }})
  }
}
