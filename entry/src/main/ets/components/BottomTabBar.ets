import { Theme } from 'common/Index'

@Component
export struct BottomTabBar {
  @Prop currentTab: number = 0
  private onTabChange: (index: number) => void = () => {}

  build() {
    Row() {
      this.TabItem({ index: 0, icon: $r('sys.symbol.house'), label: '首页' })
      this.TabItem({ index: 1, icon: $r('sys.symbol.list_bullet_rectangle'), label: '记录' })
    }
    .width('100%')
    .height(56)
    .backgroundColor(Theme.BG)
    .border({ width: { top: 1 }, color: Theme.BORDER })
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TabItem(params: { index: number; icon: Resource; label: string }) {
    Column() {
      Image(params.icon)
        .width(24)
        .height(24)
        .fillColor(params.index === this.currentTab ? Theme.BRAND : Theme.TEXT_TERTIARY)
      Text(params.label)
        .fontSize(Theme.FONT_CAPTION)
        .fontColor(params.index === this.currentTab ? Theme.BRAND : Theme.TEXT_TERTIARY)
        .fontWeight(params.index === this.currentTab ? Theme.FONT_BOLD : Theme.FONT_REGULAR)
        .margin({ top: Theme.SPACE_4 })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
    .height('100%')
    .onClick(() => {
      this.onTabChange(params.index)
    })
  }
}
