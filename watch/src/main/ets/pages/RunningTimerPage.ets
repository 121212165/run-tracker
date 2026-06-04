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

@Entry
@Component
struct RunningTimerPage {
  @State timer: string = '00:23:15'
  @State pace: string = '5\'42"'
  @State distance: string = '3.2 km'
  @State calories: string = '198'
  @State cadence: string = '168 spm'

  build() {
    Column() {
      // 大号计时器
      Text(this.timer)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.TEXT)
        .margin({ top: 32, bottom: 24 })

      // 2×2 宫格
      Grid() {
        GridItem() {
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
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .width('100%')
          .height('100%')
        }

        GridItem() {
          Column() {
            Text('距离')
              .fontSize(12)
              .fontColor(COLORS.TEXT_DIM)
            Text(this.distance)
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLORS.TEXT)
              .margin({ top: 4 })
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .width('100%')
          .height('100%')
        }

        GridItem() {
          Column() {
            Text('卡路里')
              .fontSize(12)
              .fontColor(COLORS.TEXT_DIM)
            Text(this.calories)
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLORS.TEXT)
              .margin({ top: 4 })
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .width('100%')
          .height('100%')
        }

        GridItem() {
          Column() {
            Text('步频')
              .fontSize(12)
              .fontColor(COLORS.TEXT_DIM)
            Text(this.cadence)
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLORS.TEXT)
              .margin({ top: 4 })
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .width('100%')
          .height('100%')
        }
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .width('100%')
      .height(140)
      .padding({ left: 16, right: 16 })
      .margin({ bottom: 16 })

      Blank()

      // 页码指示器 ○ ○ ●
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
          .backgroundColor(COLORS.TEXT_DIM)
          .margin({ left: 8 })
        Row()
          .width(8)
          .height(8)
          .borderRadius(4)
          .backgroundColor(COLORS.TEXT)
          .margin({ left: 8 })
      }
      .margin({ bottom: 16 })

      // 结束按钮（白色边框）
      Button('结束')
        .width(80)
        .height(36)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.TEXT)
        .backgroundColor(Color.Transparent)
        .borderWidth(1)
        .borderColor(COLORS.TEXT)
        .borderRadius(8)
        .margin({ bottom: 24 })
        .onClick(() => {
          router.pushUrl({ url: 'pages/RunResultPage' })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.BG)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .swipeAction({ onSwipe: (direction: SwipeDirection) => {
      if (direction === SwipeDirection.Right) {
        router.pushUrl({ url: 'pages/RunningHeartPage' })
      }
    }})
  }
}
