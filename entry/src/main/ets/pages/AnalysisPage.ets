// 分析页 — 周跑量柱状图 + 配速趋势 + 训练洞察
const COLORS = {
  BG: '#FFFFFF', BG_SUB: '#F8F9FA',
  TEXT_1: '#1A1A1A', TEXT_2: '#6B7280', TEXT_3: '#9CA3AF',
  BORDER: '#E4E7EC', BRAND: '#E8453C', BRAND_LIGHT: '#FEF2F2',
  SUCCESS: '#22C55E'
}

@Entry
@Component
struct AnalysisPage {
  // 本周每日跑量（米）
  @State dailyDistances: number[] = [5200, 0, 8000, 0, 0, 10000, 0]
  @State weeklyGoal: number = 30

  // 最近10次配速（秒/公里）
  @State recentPaces: number[] = [360, 355, 345, 350, 340, 338, 335, 330, 325, 320]
  @State paceLabels: string[] = ['5/6', '5/8', '5/10', '5/12', '5/15', '5/17', '5/20', '5/22', '5/29', '6/3']

  // 训练洞察
  @State fitnessScore: number = 72
  @State trainingLoad: string = '适中'
  @State vo2max: number = 42.3

  build() {
    Scroll() {
      Column({ space: 16 }) {
        // 标题
        Text('训练分析')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.TEXT_1)
          .width('100%')
          .padding({ left: 16, top: 16 })

        // 本周跑量柱状图
        this.WeekChart()

        // 配速趋势折线图
        this.PaceTrendChart()

        // 训练洞察卡片
        this.TrainingInsights()

        // 底部留白
        Row().height(32)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.BG_SUB)
  }

  // 本周跑量柱状图
  @Builder
  WeekChart() {
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
            // 柱子
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
    .margin({ left: 16, right: 16 })
  }

  // 配速趋势折线图
  @Builder
  PaceTrendChart() {
    Column() {
      // 标题
      Row() {
        Text('配速趋势')
          .fontSize(14)
          .fontColor(COLORS.TEXT_1)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text('最近' + this.recentPaces.length + '次')
          .fontSize(12)
          .fontColor(COLORS.TEXT_3)
      }
      .width('100%')
      .margin({ bottom: 16 })

      // 折线模拟：每根竖条高度反映配速
      Row({ space: 4 }) {
        ForEach(this.recentPaces, (pace: number, index: number) => {
          Column() {
            // 配速值
            Text(this.formatPace(pace))
              .fontSize(9)
              .fontColor(COLORS.BRAND)

            // 柱状占位
            Column() {
              Blank()
            }
            .width(4)
            .height(this.getTrendHeight(index))
            .borderRadius(2)
            .backgroundColor(COLORS.BRAND_LIGHT)

            // 日期标签
            if (this.paceLabels.length > index) {
              Text(this.paceLabels[index])
                .fontSize(8)
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
    .margin({ left: 16, right: 16 })
  }

  // 训练洞察卡片
  @Builder
  TrainingInsights() {
    Column({ space: 12 }) {
      Text('训练洞察')
        .fontSize(14)
        .fontColor(COLORS.TEXT_1)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 体能评分 — 进度环
      Row() {
        // 简易进度环：用圆环 + 百分比文字
        Stack() {
          // 背景圆环
          Circle()
            .width(64)
            .height(64)
            .fill('#00000000')
            .stroke(COLORS.BORDER)
            .strokeWidth(6)

          // 进度弧
          Circle()
            .width(64)
            .height(64)
            .fill('#00000000')
            .stroke(COLORS.BRAND)
            .strokeWidth(6)
            .startAngle(0)
            .sweepAngle(this.fitnessScore / 100 * 360)

          // 分数文字
          Column() {
            Text(`${this.fitnessScore}`)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLORS.TEXT_1)
            Text('/100')
              .fontSize(9)
              .fontColor(COLORS.TEXT_3)
          }
        }
        .width(64)
        .height(64)

        // 体能描述
        Column() {
          Text('体能评分')
            .fontSize(14)
            .fontColor(COLORS.TEXT_1)
          Text('您的体能状态良好，保持当前训练节奏')
            .fontSize(12)
            .fontColor(COLORS.TEXT_2)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })
        .layoutWeight(1)
      }
      .width('100%')
      .padding(16)
      .borderRadius(8)
      .backgroundColor(COLORS.BG_SUB)

      // 训练负荷
      Row() {
        Column() {
          Text('训练负荷')
            .fontSize(14)
            .fontColor(COLORS.TEXT_1)
          Text(this.trainingLoad)
            .fontSize(12)
            .fontColor(COLORS.SUCCESS)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // 简易指示条
        Row() {
          Row()
            .width('60%')
            .height(4)
            .borderRadius(2)
            .backgroundColor(COLORS.SUCCESS)
          Row()
            .width('40%')
            .height(4)
            .borderRadius(2)
            .backgroundColor(COLORS.BORDER)
        }
        .width(80)
        .borderRadius(2)
      }
      .width('100%')
      .padding(16)
      .borderRadius(8)
      .backgroundColor(COLORS.BG_SUB)

      // VO2max 估算
      Row() {
        Column() {
          Text('VO2max 估算')
            .fontSize(14)
            .fontColor(COLORS.TEXT_1)
          Text(`${this.vo2max} mL/kg/min`)
            .fontSize(12)
            .fontColor(COLORS.TEXT_2)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // 等级标签
        Text('良好')
          .fontSize(12)
          .fontColor(COLORS.BRAND)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(8)
          .backgroundColor(COLORS.BRAND_LIGHT)
      }
      .width('100%')
      .padding(16)
      .borderRadius(8)
      .backgroundColor(COLORS.BG_SUB)
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .backgroundColor(COLORS.BG)
    .border({ width: 1, color: COLORS.BORDER, radius: 12 })
    .margin({ left: 16, right: 16 })
  }

  // 获取周几标签
  private getWeekDays(): string[] {
    return ['一', '二', '三', '四', '五', '六', '日']
  }

  // 获取柱子高度
  private getBarHeight(index: number): number {
    if (this.dailyDistances.length <= index) return 0
    const maxDistance = Math.max(...this.dailyDistances, 1000)
    const value = this.dailyDistances[index]
    if (value <= 0) return 8
    return Math.max(8, (value / maxDistance) * 80)
  }

  // 计算周总跑量
  private getWeeklyTotal(): string {
    const total = this.dailyDistances.reduce((sum: number, d: number) => sum + d, 0)
    return (total / 1000).toFixed(1)
  }

  // 获取趋势图柱高度
  private getTrendHeight(index: number): number {
    if (this.recentPaces.length === 0) return 20
    const minPace = Math.min(...this.recentPaces)
    const maxPace = Math.max(...this.recentPaces)
    const range = maxPace - minPace
    if (range === 0) return 50
    const normalized = 1 - (this.recentPaces[index] - minPace) / range
    return Math.max(12, normalized * 60 + 12)
  }

  // 格式化配速
  private formatPace(secondsPerKm: number): string {
    if (secondsPerKm <= 0 || !isFinite(secondsPerKm)) return "--'"
    const min = Math.floor(secondsPerKm / 60)
    const sec = Math.floor(secondsPerKm % 60)
    return `${min}'${sec.toString().padStart(2, '0')}"`
  }
}
