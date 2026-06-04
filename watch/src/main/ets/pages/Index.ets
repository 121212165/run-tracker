import { router } from '@kit.ArkUI'
import { SportSelectPage } from './SportSelectPage'

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
struct Index {
  build() {
    Column() {
      Column() {
        // Logo 占位
        Text('🏃')
          .fontSize(40)
        // 品牌名
        Text('RunTrack')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.TEXT)
          .margin({ top: 8 })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.BG)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      router.pushUrl({ url: 'pages/SportSelectPage' })
    })
  }

  aboutToAppear() {
    // 自动跳转延迟
    setTimeout(() => {
      router.pushUrl({ url: 'pages/SportSelectPage' })
    }, 1500)
  }
}
