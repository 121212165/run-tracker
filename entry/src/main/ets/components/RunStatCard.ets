// 跑步指标卡片组件
import { DesignTokens } from '../viewmodel/RunningViewModel'

@Component
export struct RunStatCard {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop unit: string = ''
  @Prop valueColor: string = DesignTokens.TEXT_PRIMARY
  private onCardClick?: () => void

  build() {
    Column() {
      Text(this.label)
        .fontSize(DesignTokens.FONT_CAPTION)
        .fontColor(DesignTokens.TEXT_TERTIARY)
        .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
      Text(this.value)
        .fontSize(DesignTokens.FONT_TITLE)
        .fontColor(this.valueColor)
        .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
        .margin({ top: DesignTokens.SPACE_4 })
      if (this.unit) {
        Text(this.unit)
          .fontSize(DesignTokens.FONT_CAPTION)
          .fontColor(DesignTokens.TEXT_SECONDARY)
          .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
          .margin({ top: DesignTokens.SPACE_4 })
      }
    }
    .padding(DesignTokens.SPACE_16)
    .borderRadius(DesignTokens.RADIUS_LG)
    .backgroundColor(DesignTokens.BG)
    .border({ width: 1, color: DesignTokens.BORDER })
    .alignItems(HorizontalAlign.Start)
    .onClick(() => {
      if (this.onCardClick) {
        this.onCardClick()
      }
    })
  }
}

// 紧凑型指标卡片（用于跑步中页面 3 列布局）
@Component
export struct RunStatCardCompact {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop unit: string = ''

  build() {
    Column() {
      Text(this.label)
        .fontSize(DesignTokens.FONT_CAPTION)
        .fontColor(DesignTokens.TEXT_TERTIARY)
        .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
      Row() {
        Text(this.value)
          .fontSize(20)
          .fontColor(DesignTokens.TEXT_PRIMARY)
          .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
        if (this.unit) {
          Text(this.unit)
            .fontSize(DesignTokens.FONT_CAPTION)
            .fontColor(DesignTokens.TEXT_SECONDARY)
            .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
            .margin({ left: DesignTokens.SPACE_4 })
        }
      }
      .margin({ top: DesignTokens.SPACE_4 })
      .alignItems(VerticalAlign.Bottom)
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
  }
}
