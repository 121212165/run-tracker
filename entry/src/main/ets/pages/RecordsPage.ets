// 记录页 — 按周分组的跑步列表
const COLORS = {
  BG: '#FFFFFF', BG_SUB: '#F8F9FA',
  TEXT_1: '#1A1A1A', TEXT_2: '#6B7280', TEXT_3: '#9CA3AF',
  BORDER: '#E4E7EC', BRAND: '#E8453C', BRAND_LIGHT: '#FEF2F2',
  SUCCESS: '#22C55E'
}

// 模拟跑步记录数据
interface MockRunRecord {
  id: string
  date: string
  distance: number
  pace: number
  duration: number
  avgHr: number
}

// 按周分组
interface WeekGroup {
  title: string
  runs: MockRunRecord[]
}

@Entry
@Component
struct RecordsPage {
  @State currentTab: number = 0 // 0=周, 1=月, 2=全部
  @State weekGroups: WeekGroup[] = []

  aboutToAppear() {
    this.weekGroups = this.generateMockData()
  }

  build() {
    Column() {
      // 标题
      Text('跑步记录')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.TEXT_1)
        .width('100%')
        .padding({ left: 16, top: 16, bottom: 8 })

      // 周/月/全部切换
      Row({ space: 24 }) {
        this.TabButton('周', 0)
        this.TabButton('月', 1)
        this.TabButton('全部', 2)
      }
      .width('100%')
      .padding({ left: 16, bottom: 16 })

      // 跑步列表
      List({ space: 16 }) {
        ForEach(this.getFilteredGroups(), (group: WeekGroup) => {
          ListItem() {
            Column() {
              // 周标题
              Text(group.title)
                .fontSize(12)
                .fontColor(COLORS.TEXT_3)
                .width('100%')
                .margin({ bottom: 8 })

              // 该周的跑步列表
              Column({ space: 8 }) {
                ForEach(group.runs, (run: MockRunRecord) => {
                  this.RunItem(run)
                })
              }
            }
            .width('100%')
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.BG_SUB)
  }

  // Tab 按钮
  @Builder
  TabButton(label: string, index: number) {
    Column() {
      Text(label)
        .fontSize(14)
        .fontColor(this.currentTab === index ? COLORS.BRAND : COLORS.TEXT_2)
        .fontWeight(this.currentTab === index ? FontWeight.Bold : FontWeight.Regular)

      // 选中下划线
      Row()
        .width(24)
        .height(2)
        .borderRadius(1)
        .backgroundColor(this.currentTab === index ? COLORS.BRAND : '#00000000')
        .margin({ top: 4 })
    }
    .onClick(() => {
      this.currentTab = index
    })
  }

  // 单条跑步记录
  @Builder
  RunItem(run: MockRunRecord) {
    Row() {
      // 左侧信息
      Column() {
        Text(run.date)
          .fontSize(14)
          .fontColor(COLORS.TEXT_1)

        Row({ space: 16 }) {
          Column() {
            Text(this.formatDistance(run.distance))
              .fontSize(14)
              .fontColor(COLORS.TEXT_1)
              .fontWeight(FontWeight.Bold)
            Text('km')
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
          }.alignItems(HorizontalAlign.Start)

          Column() {
            Text(this.formatPace(run.pace))
              .fontSize(14)
              .fontColor(COLORS.TEXT_2)
            Text('配速')
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
          }.alignItems(HorizontalAlign.Start)

          Column() {
            Text(this.formatDuration(run.duration))
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

      // 右侧心率 + 箭头
      Row({ space: 8 }) {
        Row({ space: 4 }) {
          Text('\u2665')
            .fontSize(12)
            .fontColor(COLORS.BRAND)
          Text(`${run.avgHr}`)
            .fontSize(12)
            .fontColor(COLORS.TEXT_2)
        }
        Text('>')
          .fontSize(14)
          .fontColor(COLORS.TEXT_3)
      }
    }
    .width('100%')
    .padding(16)
    .borderRadius(8)
    .backgroundColor(COLORS.BG)
    .border({ width: 1, color: COLORS.BORDER, radius: 8 })
  }

  // 根据当前 Tab 过滤分组
  private getFilteredGroups(): WeekGroup[] {
    if (this.currentTab === 0) {
      // 周：只显示最近1周
      return this.weekGroups.length > 0 ? [this.weekGroups[0]] : []
    } else if (this.currentTab === 1) {
      // 月：显示最近4周
      return this.weekGroups.slice(0, 4)
    }
    // 全部
    return this.weekGroups
  }

  // 生成模拟数据
  private generateMockData(): WeekGroup[] {
    return [
      {
        title: '6月2日 - 6月8日',
        runs: [
          { id: '1', date: '6月3日 周二', distance: 5200, pace: 335, duration: 1742, avgHr: 152 },
          { id: '2', date: '6月5日 周四', distance: 8000, pace: 348, duration: 2784, avgHr: 148 },
          { id: '3', date: '6月7日 周六', distance: 10000, pace: 325, duration: 3250, avgHr: 155 },
        ]
      },
      {
        title: '5月26日 - 6月1日',
        runs: [
          { id: '4', date: '5月27日 周一', distance: 6200, pace: 342, duration: 2120, avgHr: 146 },
          { id: '5', date: '5月29日 周三', distance: 5000, pace: 355, duration: 1775, avgHr: 143 },
          { id: '6', date: '5月31日 周五', distance: 7500, pace: 330, duration: 2475, avgHr: 150 },
        ]
      },
      {
        title: '5月19日 - 5月25日',
        runs: [
          { id: '7', date: '5月20日 周二', distance: 4800, pace: 360, duration: 1728, avgHr: 140 },
          { id: '8', date: '5月22日 周四', distance: 6000, pace: 345, duration: 2070, avgHr: 147 },
          { id: '9', date: '5月24日 周六', distance: 12000, pace: 320, duration: 3840, avgHr: 158 },
        ]
      },
      {
        title: '5月12日 - 5月18日',
        runs: [
          { id: '10', date: '5月13日 周一', distance: 5500, pace: 338, duration: 1859, avgHr: 149 },
          { id: '11', date: '5月16日 周四', distance: 8000, pace: 350, duration: 2800, avgHr: 145 },
        ]
      }
    ]
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
