import { Theme } from 'common/Index'

@Component
export struct RunStatCard {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop unit: string = ''

  build() {
    Column() {
      Text(this.label)
        .fontSize(Theme.FONT_CAPTION)
        .fontColor(Theme.TEXT_TERTIARY)
        .fontWeight(Theme.FONT_REGULAR)
      Text(this.value)
        .fontSize(Theme.FONT_TITLE)
        .fontColor(Theme.TEXT_PRIMARY)
        .fontWeight(Theme.FONT_BOLD)
        .margin({ top: Theme.SPACE_4 })
      if (this.unit) {
        Text(this.unit)
          .fontSize(Theme.FONT_CAPTION)
          .fontColor(Theme.TEXT_SECONDARY)
          .fontWeight(Theme.FONT_REGULAR)
          .margin({ top: Theme.SPACE_4 })
      }
    }
    .padding(Theme.SPACE_16)
    .borderRadius(Theme.RADIUS_LG)
    .backgroundColor(Theme.BG)
    .border({ width: 1, color: Theme.BORDER })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
export struct RunStatCompact {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop unit: string = ''

  build() {
    Column() {
      Text(this.label)
        .fontSize(Theme.FONT_CAPTION)
        .fontColor(Theme.TEXT_TERTIARY)
        .fontWeight(Theme.FONT_REGULAR)
      Row() {
        Text(this.value)
          .fontSize(20)
          .fontColor(Theme.TEXT_PRIMARY)
          .fontWeight(Theme.FONT_BOLD)
        if (this.unit) {
          Text(this.unit)
            .fontSize(Theme.FONT_CAPTION)
            .fontColor(Theme.TEXT_SECONDARY)
            .fontWeight(Theme.FONT_REGULAR)
            .margin({ left: Theme.SPACE_4 })
        }
      }
      .margin({ top: Theme.SPACE_4 })
      .alignItems(VerticalAlign.Bottom)
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
  }
}
