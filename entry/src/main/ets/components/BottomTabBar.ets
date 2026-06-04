// 底部导航栏组件
import { DesignTokens } from '../viewmodel/RunningViewModel'

@Component
export struct BottomTabBar {
  @Prop currentTab: number = 0
  private onTabChange: (index: number) => void = () => {}

  build() {
    Row() {
      this.TabItem({ index: 0, icon: $r('sys.symbol.house'), label: '首页' })
      this.TabItem({ index: 1, icon: $r('sys.symbol.list_bullet_rectangle'), label: '记录' })
      this.TabItem({ index: 2, icon: $r('sys.symbol.chart_bar'), label: '分析' })
      this.TabItem({ index: 3, icon: $r('sys.symbol.person'), label: '我的' })
    }
    .width('100%')
    .height(56)
    .backgroundColor(DesignTokens.BG)
    .border({ width: { top: 1 }, color: DesignTokens.BORDER })
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TabItem(params: { index: number; icon: Resource; label: string }) {
    Column() {
      Image(params.icon)
        .width(24)
        .height(24)
        .fillColor(params.index === this.currentTab ? DesignTokens.BRAND : DesignTokens.TEXT_TERTIARY)
      Text(params.label)
        .fontSize(DesignTokens.FONT_CAPTION)
        .fontColor(params.index === this.currentTab ? DesignTokens.BRAND : DesignTokens.TEXT_TERTIARY)
        .fontWeight(params.index === this.currentTab ? DesignTokens.FONT_WEIGHT_BOLD : DesignTokens.FONT_WEIGHT_REGULAR)
        .margin({ top: DesignTokens.SPACE_4 })
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
