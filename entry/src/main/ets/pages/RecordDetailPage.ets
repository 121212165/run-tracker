// 单次记录详情页
const COLORS = {
  BG: '#FFFFFF', BG_SUB: '#F8F9FA',
  TEXT_1: '#1A1A1A', TEXT_2: '#6B7280', TEXT_3: '#9CA3AF',
  BORDER: '#E4E7EC', BRAND: '#E8453C', BRAND_LIGHT: '#FEF2F2',
  SUCCESS: '#22C55E'
}

// 心率区间颜色
const HR_ZONE_COLORS = ['#22C55E', '#84CC16', '#EAB308', '#F97316', '#E8453C']
const HR_ZONE_LABELS = ['热身', '燃脂', '有氧', '无氧', '最大']

@Entry
@Component
struct RecordDetailPage {
  // 模拟跑步记录详情数据
  @State recordDate: string = '2026年6月7日'
  @State sportType: string = '户外跑'
  @State distance: number = 10000      // 米
  @State avgPace: number = 325         // 秒/公里
  @State duration: number = 3250       // 秒
  @State avgHr: number = 155           // 平均心率
  @State maxHr: number = 178           // 最大心率
  @State calories: number = 620        // kcal
  // 心率区间分布（百分比）
  @State hrZonePercents: number[] = [5, 15, 40, 30, 10]
  // 分段配速（每公里秒数）
  @State splits: number[] = [340, 335, 328, 320, 315, 310, 318, 325, 330, 335]

  build() {
    Scroll() {
      Column({ space: 16 }) {
        // 顶部：日期 + 运动类型
        Column() {
          Text(this.recordDate)
            .fontSize(14)
            .fontColor(COLORS.TEXT_2)
          Text(this.sportType)
            .fontSize(12)
            .fontColor(COLORS.BRAND)
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(8)
            .backgroundColor(COLORS.BRAND_LIGHT)
            .margin({ top: 8 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 16, top: 16 })

        // 大号距离 + 配速
        Row() {
          Column() {
            Text(this.formatDistance(this.distance))
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLORS.TEXT_1)
            Text('公里')
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
              .margin({ top: 4 })
          }.alignItems(HorizontalAlign.Start)

          Column() {
            Text(this.formatPace(this.avgPace))
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLORS.TEXT_1)
            Text('平均配速')
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
              .margin({ top: 4 })
          }.alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .justifyContent(FlexAlign.Start)
        .space(48)

        // 4 宫格：用时/平均心率/最大心率/卡路里
        Row() {
          this.StatCell('用时', this.formatDuration(this.duration))
          this.StatCell('平均心率', `${this.avgHr} bpm`)
          this.StatCell('最大心率', `${this.maxHr} bpm`)
          this.StatCell('卡路里', `${this.calories} kcal`)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })

        // 心率5区间分布横条
        Column() {
          Text('心率区间')
            .fontSize(14)
            .fontColor(COLORS.TEXT_1)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({ bottom: 12 })

          // 横条
          Row() {
            ForEach(this.hrZonePercents, (percent: number, index: number) => {
              Row()
                .width(`${percent}%`)
                .height(24)
                .backgroundColor(HR_ZONE_COLORS[index])
            })
          }
          .width('100%')
          .borderRadius(8)
          .clip(true)

          // 区间标签
          Row() {
            ForEach(HR_ZONE_LABELS, (label: string, index: number) => {
              Column() {
                Row()
                  .width(8)
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(HR_ZONE_COLORS[index])
                Text(label)
                  .fontSize(10)
                  .fontColor(COLORS.TEXT_3)
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Center)
            })
          }
          .width('100%')
          .margin({ top: 8 })
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor(COLORS.BG)
        .border({ width: 1, color: COLORS.BORDER, radius: 12 })
        .margin({ left: 16, right: 16 })

        // 分段配速柱状图
        Column() {
          Text('分段配速')
            .fontSize(14)
            .fontColor(COLORS.TEXT_1)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({ bottom: 12 })

          Row({ space: 4 }) {
            ForEach(this.splits, (pace: number, index: number) => {
              Column() {
                // 配速值
                Text(this.formatPaceShort(pace))
                  .fontSize(9)
                  .fontColor(COLORS.TEXT_3)

                // 柱子
                Column() {
                  Blank()
                }
                .width('100%')
                .height(this.getSplitBarHeight(pace))
                .borderRadius(4)
                .backgroundColor(this.getSplitBarColor(pace))

                // 公里标签
                Text(`${index + 1}`)
                  .fontSize(9)
                  .fontColor(COLORS.TEXT_3)
                  .margin({ top: 4 })
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

        // 轨迹地图占位
        Column() {
          Text('运动轨迹')
            .fontSize(14)
            .fontColor(COLORS.TEXT_1)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({ bottom: 12 })

          // 占位区域
          Row() {
            Text('地图占位区域')
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
          }
          .width('100%')
          .height(200)
          .borderRadius(8)
          .backgroundColor(COLORS.BG_SUB)
          .border({ width: 1, color: COLORS.BORDER, radius: 8 })
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor(COLORS.BG)
        .border({ width: 1, color: COLORS.BORDER, radius: 12 })
        .margin({ left: 16, right: 16, bottom: 32 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.BG_SUB)
  }

  // 统计小卡片
  @Builder
  StatCell(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(14)
        .fontColor(COLORS.TEXT_1)
        .fontWeight(FontWeight.Bold)
      Text(label)
        .fontSize(12)
        .fontColor(COLORS.TEXT_3)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .padding(12)
    .borderRadius(8)
    .backgroundColor(COLORS.BG_SUB)
    .alignItems(HorizontalAlign.Center)
  }

  // 获取分段配速柱高度
  private getSplitBarHeight(pace: number): number {
    const minPace = Math.min(...this.splits)
    const maxPace = Math.max(...this.splits)
    const range = maxPace - minPace
    if (range === 0) return 40
    const normalized = 1 - (pace - minPace) / range
    return Math.max(12, normalized * 70 + 12)
  }

  // 获取分段配速柱颜色：最快的用品牌红，其余用品牌浅色
  private getSplitBarColor(pace: number): string {
    const minPace = Math.min(...this.splits)
    return pace === minPace ? COLORS.BRAND : COLORS.BRAND_LIGHT
  }

  // 格式化配速（完整）
  private formatPace(secondsPerKm: number): string {
    if (secondsPerKm <= 0 || !isFinite(secondsPerKm)) return "--'--\""
    const min = Math.floor(secondsPerKm / 60)
    const sec = Math.floor(secondsPerKm % 60)
    return `${min}'${sec.toString().padStart(2, '0')}"`
  }

  // 格式化配速（简短）
  private formatPaceShort(secondsPerKm: number): string {
    if (secondsPerKm <= 0 || !isFinite(secondsPerKm)) return "--'"
    const min = Math.floor(secondsPerKm / 60)
    return `${min}'`
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
