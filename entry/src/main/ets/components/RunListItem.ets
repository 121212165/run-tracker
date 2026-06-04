// 跑步列表项组件
const COLORS = {
  BG: '#FFFFFF', BG_SUB: '#F8F9FA',
  TEXT_1: '#1A1A1A', TEXT_2: '#6B7280', TEXT_3: '#9CA3AF',
  BORDER: '#E4E7EC', BRAND: '#E8453C', BRAND_LIGHT: '#FEF2F2',
  SUCCESS: '#22C55E'
}

@Component
export struct RunListItem {
  // 跑步日期
  @Prop date: string = ''
  // 距离（米）
  @Prop distance: number = 0
  // 配速（秒/公里）
  @Prop pace: number = 0
  // 时长（秒）
  @Prop duration: number = 0
  // 平均心率
  @Prop avgHr: number = 0
  // 点击回调
  onItemClick?: () => void

  build() {
    Row() {
      // 左侧信息
      Column() {
        Text(this.date)
          .fontSize(14)
          .fontColor(COLORS.TEXT_1)
          .fontWeight(FontWeight.Regular)

        Row({ space: 16 }) {
          // 距离
          Column() {
            Text(this.formatDistance(this.distance))
              .fontSize(14)
              .fontColor(COLORS.TEXT_1)
              .fontWeight(FontWeight.Bold)
            Text('km')
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
          }.alignItems(HorizontalAlign.Start)

          // 配速
          Column() {
            Text(this.formatPace(this.pace))
              .fontSize(14)
              .fontColor(COLORS.TEXT_2)
            Text('配速')
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
          }.alignItems(HorizontalAlign.Start)

          // 时长
          Column() {
            Text(this.formatDuration(this.duration))
              .fontSize(14)
              .fontColor(COLORS.TEXT_2)
            Text('时长')
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
          }.alignItems(HorizontalAlign.Start)
        }
        .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // 右侧心率图标 + 箭头
      Row({ space: 8 }) {
        // 心率图标区域
        Row({ space: 4 }) {
          Text('\u2665')
            .fontSize(12)
            .fontColor(COLORS.BRAND)
          Text(`${this.avgHr}`)
            .fontSize(12)
            .fontColor(COLORS.TEXT_2)
        }

        Text('>')
          .fontSize(14)
          .fontColor(COLORS.TEXT_3)
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
    .borderRadius(8)
    .backgroundColor(COLORS.BG)
    .border({ width: 1, color: COLORS.BORDER, radius: 8 })
    .onClick(() => {
      if (this.onItemClick) {
        this.onItemClick()
      }
    })
  }

  // 格式化配速
  private formatPace(secondsPerKm: number): string {
    if (secondsPerKm <= 0 || !isFinite(secondsPerKm)) return "--'--\""
    const min = Math.floor(secondsPerKm / 60)
    const sec = Math.floor(secondsPerKm % 60)
    return `${min}'${sec.toString().padStart(2, '0')}"`
  }

  // 格式化距离
  private formatDistance(meters: number): string {
    if (meters < 0) return '0.0'
    return (meters / 1000).toFixed(1)
  }

  // 格式化时长
  private formatDuration(seconds: number): string {
    if (seconds < 0) return '00:00'
    const h = Math.floor(seconds / 3600)
    const m = Math.floor((seconds % 3600) / 60)
    const s = Math.floor(seconds % 60)
    if (h > 0) {
      return `${h.toString().padStart(2, '0')}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
    }
    return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
  }
}
