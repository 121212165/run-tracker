import { router } from '@kit.ArkUI'
import { CircleProgress } from '../components/CircleProgress'

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
struct RunResultPage {
  @State distance: string = '5.3 km'
  @State duration: string = '31\'08"'
  @State avgPace: string = '5\'52"'
  @State avgHr: string = '138 bpm'
  @State synced: boolean = true

  build() {
    Column() {
      // 圆形进度环
      CircleProgress({
        progress: 0.88,
        label: '5.3 km',
        ringColor: COLORS.BRAND
      })
        .margin({ top: 24, bottom: 24 })

      // 3列摘要
      Row() {
        Column() {
          Text('时长')
            .fontSize(12)
            .fontColor(COLORS.TEXT_DIM)
          Text(this.duration)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLORS.TEXT)
            .margin({ top: 4 })
        }
        .layoutWeight(1)

        Column() {
          Text('配速')
            .fontSize(12)
            .fontColor(COLORS.TEXT_DIM)
          Text(this.avgPace)
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
          Text(this.avgHr)
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

      // 同步状态
      Row() {
        Text('☁')
          .fontSize(12)
          .fontColor(COLORS.SUCCESS)
          .margin({ right: 4 })
        Text('已同步至手机')
          .fontSize(12)
          .fontColor(COLORS.SUCCESS)
      }
      .margin({ bottom: 24 })

      Blank()

      // 完成按钮
      Button('完成')
        .width('100%')
        .height(44)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.TEXT)
        .backgroundColor(COLORS.BRAND)
        .borderRadius(12)
        .margin({ left: 16, right: 16, bottom: 8 })
        .onClick(() => {
          router.back()
        })

      // 详情文字按钮
      Text('详情')
        .fontSize(14)
        .fontColor(COLORS.TEXT_DIM)
        .margin({ bottom: 24 })
        .onClick(() => {
          // 跳转手机端详情
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.BG)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }
}
