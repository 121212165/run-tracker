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

interface SportItem {
  icon: string
  name: string
}

@Entry
@Component
struct SportSelectPage {
  @State selectedIndex: number = 0

  private sports: SportItem[] = [
    { icon: '🏃', name: '户外跑' },
    { icon: '🏠', name: '室内跑' },
    { icon: '⚡', name: '间歇跑' },
    { icon: '🎯', name: '目标跑' }
  ]

  build() {
    Column() {
      // 标题
      Text('选择运动')
        .fontSize(12)
        .fontColor(COLORS.TEXT_DIM)
        .margin({ top: 24, bottom: 16 })

      // 运动列表
      List() {
        ForEach(this.sports, (item: SportItem, index: number) => {
          ListItem() {
            Row() {
              // 选中指示条
              Row()
                .width(3)
                .height(24)
                .backgroundColor(index === this.selectedIndex ? COLORS.BRAND : Color.Transparent)
                .borderRadius(1.5)
                .margin({ right: 12 })
              // 图标
              Text(item.icon)
                .fontSize(20)
                .margin({ right: 12 })
              // 名称
              Text(item.name)
                .fontSize(14)
                .fontColor(index === this.selectedIndex ? COLORS.TEXT : COLORS.TEXT_DIM)
                .fontWeight(index === this.selectedIndex ? FontWeight.Bold : FontWeight.Normal)
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            .borderRadius(8)
            .onClick(() => {
              this.selectedIndex = index
            })
          }
        }, (index: number) => index.toString())
      }
      .layoutWeight(1)
      .width('100%')

      // 开始按钮
      Button('开始')
        .width('100%')
        .height(44)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.TEXT)
        .backgroundColor(COLORS.BRAND)
        .borderRadius(12)
        .margin({ left: 16, right: 16, bottom: 24 })
        .onClick(() => {
          router.pushUrl({ url: 'pages/RunningDataPage' })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.BG)
  }
}
