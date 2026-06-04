// 配速趋势折线图组件 — 用 Row 高度模拟折线
const COLORS = {
  BG: '#FFFFFF', BG_SUB: '#F8F9FA',
  TEXT_1: '#1A1A1A', TEXT_2: '#6B7280', TEXT_3: '#9CA3AF',
  BORDER: '#E4E7EC', BRAND: '#E8453C', BRAND_LIGHT: '#FEF2F2',
  SUCCESS: '#22C55E'
}

@Component
export struct TrendChart {
  // 最近 N 次跑步的平均配速（秒/公里）
  @Prop paces: number[] = []
  // 对应的日期标签
  @Prop labels: string[] = []

  build() {
    Column() {
      // 标题
      Row() {
        Text('配速趋势')
          .fontSize(14)
          .fontColor(COLORS.TEXT_1)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text('最近' + this.paces.length + '次')
          .fontSize(12)
          .fontColor(COLORS.TEXT_3)
      }
      .width('100%')
      .margin({ bottom: 16 })

      // 折线模拟：每根竖条上放一个圆点，高度对应配速
      Row({ space: 4 }) {
        ForEach(this.paces, (pace: number, index: number) => {
          Column() {
            // 配速值
            Text(this.formatPace(pace))
              .fontSize(10)
              .fontColor(COLORS.BRAND)

            // 柱状占位，高度反映配速快慢（配速越低=越快=柱子越高）
            Column() {
              Blank()
            }
            .width(4)
            .height(this.getDotPosition(index))
            .borderRadius(2)
            .backgroundColor(COLORS.BRAND_LIGHT)

            // 日期标签
            if (this.labels.length > index) {
              Text(this.labels[index])
                .fontSize(9)
                .fontColor(COLORS.TEXT_3)
            }
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.End)
        })
      }
      .width('100%')
      .height(100)
      .alignItems(VerticalAlign.Bottom)
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .backgroundColor(COLORS.BG)
    .border({ width: 1, color: COLORS.BORDER, radius: 12 })
  }

  // 根据配速计算柱高度（配速越低=越快=越高）
  private getDotPosition(index: number): number {
    if (this.paces.length === 0) return 20
    const minPace = Math.min(...this.paces)
    const maxPace = Math.max(...this.paces)
    const range = maxPace - minPace
    if (range === 0) return 50
    // 配速越低（越快），柱子越高
    const normalized = 1 - (this.paces[index] - minPace) / range
    return Math.max(12, normalized * 70 + 12)
  }

  // 格式化配速
  private formatPace(secondsPerKm: number): string {
    if (secondsPerKm <= 0 || !isFinite(secondsPerKm)) return "--'--\""
    const min = Math.floor(secondsPerKm / 60)
    const sec = Math.floor(secondsPerKm % 60)
    return `${min}'${sec.toString().padStart(2, '0')}"`
  }
}
