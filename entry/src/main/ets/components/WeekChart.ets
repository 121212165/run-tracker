// 周跑量柱状图组件
const COLORS = {
  BG: '#FFFFFF', BG_SUB: '#F8F9FA',
  TEXT_1: '#1A1A1A', TEXT_2: '#6B7280', TEXT_3: '#9CA3AF',
  BORDER: '#E4E7EC', BRAND: '#E8453C', BRAND_LIGHT: '#FEF2F2',
  SUCCESS: '#22C55E'
}

@Component
export struct WeekChart {
  // 7天每日距离（米），长度必须为7
  @Prop dailyDistances: number[] = [0, 0, 0, 0, 0, 0, 0]
  // 周目标（公里）
  @Prop weeklyGoal: number = 30

  build() {
    Column() {
      // 标题行
      Row() {
        Text('本周跑量')
          .fontSize(14)
          .fontColor(COLORS.TEXT_1)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text(this.getWeeklyTotal() + ' / ' + this.weeklyGoal + ' km')
          .fontSize(12)
          .fontColor(COLORS.TEXT_2)
      }
      .width('100%')
      .margin({ bottom: 16 })

      // 柱状图
      Row({ space: 8 }) {
        ForEach(this.getWeekDays(), (day: string, index: number) => {
          Column() {
            // 柱子区域
            Column() {
              Blank()
            }
            .width('100%')
            .height(this.getBarHeight(index))
            .borderRadius(4)
            .backgroundColor(this.dailyDistances[index] > 0 ? COLORS.BRAND : COLORS.BORDER)

            // 日期标签
            Text(day)
              .fontSize(10)
              .fontColor(COLORS.TEXT_3)
              .margin({ top: 8 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
        })
      }
      .width('100%')
      .height(120)
      .alignItems(VerticalAlign.Bottom)
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .backgroundColor(COLORS.BG)
    .border({ width: 1, color: COLORS.BORDER, radius: 12 })
  }

  // 获取周几标签
  private getWeekDays(): string[] {
    return ['一', '二', '三', '四', '五', '六', '日']
  }

  // 获取柱子高度（vp），最大80vp
  private getBarHeight(index: number): number {
    if (this.dailyDistances.length <= index) return 0
    const maxDistance = Math.max(...this.dailyDistances, 1000)
    const value = this.dailyDistances[index]
    if (value <= 0) return 8
    return Math.max(8, (value / maxDistance) * 80)
  }

  // 计算周总跑量
  private getWeeklyTotal(): string {
    const total = this.dailyDistances.reduce((sum, d) => sum + d, 0)
    return (total / 1000).toFixed(1)
  }
}
