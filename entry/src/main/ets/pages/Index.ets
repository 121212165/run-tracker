// 首页 — 4 Tab 容器
import { DesignTokens, RunRecord, formatPace, formatDistance, formatDate, formatTime } from '../viewmodel/RunningViewModel'
import { BottomTabBar } from '../components/BottomTabBar'
import { RunStatCard } from '../components/RunStatCard'
import router from '@ohos.router'

@Entry
@Component
struct Index {
  @State currentTab: number = 0
  @State weeklyGoal: number = 20 // km
  @State weeklyDistance: number = 12.5 // km
  @State recentRuns: RunRecord[] = []

  aboutToAppear() {
    this.recentRuns = this.getMockRecentRuns()
  }

  build() {
    Column() {
      // 内容区
      Stack() {
        if (this.currentTab === 0) {
          this.HomeTab()
        } else if (this.currentTab === 1) {
          this.PlaceholderTab('记录')
        } else if (this.currentTab === 2) {
          this.PlaceholderTab('分析')
        } else {
          this.PlaceholderTab('我的')
        }
      }
      .layoutWeight(1)

      // 底部导航
      BottomTabBar({
        currentTab: this.currentTab,
        onTabChange: (index: number) => {
          this.currentTab = index
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.BG)
  }

  @Builder
  HomeTab() {
    Scroll() {
      Column() {
        // 问候语
        Text(this.getGreeting())
          .fontSize(DesignTokens.FONT_TITLE)
          .fontColor(DesignTokens.TEXT_PRIMARY)
          .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
          .width('100%')
          .margin({ top: DesignTokens.SPACE_24, bottom: DesignTokens.SPACE_16 })

        // 本周目标进度
        this.WeeklyGoalSection()

        // 3 个指标卡
        this.TodayStatsSection()

        // 开始跑步 CTA
        Button('开始跑步')
          .width('100%')
          .height(48)
          .backgroundColor(DesignTokens.BRAND)
          .fontColor('#FFFFFF')
          .fontSize(DesignTokens.FONT_BODY)
          .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
          .borderRadius(DesignTokens.RADIUS_SM)
          .margin({ top: DesignTokens.SPACE_24 })
          .onClick(() => {
            router.pushUrl({ url: 'pages/RunningPage' })
          })

        // 最近跑步列表
        this.RecentRunsSection()
      }
      .width('100%')
      .padding({ left: DesignTokens.SPACE_16, right: DesignTokens.SPACE_16, bottom: DesignTokens.SPACE_24 })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }

  @Builder
  WeeklyGoalSection() {
    Column() {
      Row() {
        Text('本周目标')
          .fontSize(DesignTokens.FONT_BODY)
          .fontColor(DesignTokens.TEXT_PRIMARY)
          .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
        Blank()
        Text(`${this.weeklyDistance.toFixed(1)} / ${this.weeklyGoal} km`)
          .fontSize(DesignTokens.FONT_CAPTION)
          .fontColor(DesignTokens.TEXT_SECONDARY)
          .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
      }
      .width('100%')

      // 进度条
      Row() {
        Row()
          .width(`${Math.min(this.weeklyDistance / this.weeklyGoal * 100, 100)}%`)
          .height('100%')
          .backgroundColor(DesignTokens.BRAND)
          .borderRadius(4)
      }
      .width('100%')
      .height(8)
      .borderRadius(4)
      .backgroundColor(DesignTokens.BG_SUB)
      .margin({ top: DesignTokens.SPACE_8 })
    }
    .width('100%')
    .padding(DesignTokens.SPACE_16)
    .borderRadius(DesignTokens.RADIUS_LG)
    .backgroundColor(DesignTokens.BG)
    .border({ width: 1, color: DesignTokens.BORDER })
  }

  @Builder
  TodayStatsSection() {
    Row() {
      RunStatCard({ label: '今日跑量', value: '3.2', unit: 'km' })
      RunStatCard({ label: '本周跑量', value: '12.5', unit: 'km' })
      RunStatCard({ label: '平均配速', value: "5'42\"", unit: '/km' })
    }
    .width('100%')
    .margin({ top: DesignTokens.SPACE_16 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  RecentRunsSection() {
    Column() {
      Text('最近跑步')
        .fontSize(DesignTokens.FONT_BODY)
        .fontColor(DesignTokens.TEXT_PRIMARY)
        .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
        .width('100%')
        .margin({ top: DesignTokens.SPACE_24, bottom: DesignTokens.SPACE_8 })

      ForEach(this.recentRuns, (run: RunRecord) => {
        this.RunItem(run)
      }, (run: RunRecord) => run.id)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  RunItem(run: RunRecord) {
    Row() {
      Column() {
        Text(`${formatDate(run.startTime)}  ${formatTime(run.startTime)}`)
          .fontSize(DesignTokens.FONT_BODY)
          .fontColor(DesignTokens.TEXT_PRIMARY)
          .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
        Text(`${formatDistance(run.distance)} km · ${formatPace(run.avgPace)}/km`)
          .fontSize(DesignTokens.FONT_CAPTION)
          .fontColor(DesignTokens.TEXT_SECONDARY)
          .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
          .margin({ top: DesignTokens.SPACE_4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Image($r('sys.symbol.chevron_right'))
        .width(16)
        .height(16)
        .fillColor(DesignTokens.TEXT_TERTIARY)
    }
    .width('100%')
    .padding(DesignTokens.SPACE_16)
    .borderRadius(DesignTokens.RADIUS_SM)
    .backgroundColor(DesignTokens.BG)
    .border({ width: 1, color: DesignTokens.BORDER })
    .margin({ top: DesignTokens.SPACE_8 })
  }

  @Builder
  PlaceholderTab(name: string) {
    Column() {
      Text(`${name}页`)
        .fontSize(DesignTokens.FONT_BODY)
        .fontColor(DesignTokens.TEXT_TERTIARY)
        .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  private getGreeting(): string {
    const hour = new Date().getHours()
    if (hour < 6) return '夜深了'
    if (hour < 12) return '早上好'
    if (hour < 14) return '中午好'
    if (hour < 18) return '下午好'
    return '晚上好'
  }

  private getMockRecentRuns(): RunRecord[] {
    const now = Date.now()
    return [
      {
        id: '1',
        startTime: now - 86400000,
        endTime: now - 86400000 + 1860 * 1000,
        duration: 1860,
        distance: 5300,
        avgPace: 351,
        avgHeartRate: 152,
        maxHeartRate: 178,
        calories: 332,
        hrZones: { zone1: 120, zone2: 300, zone3: 600, zone4: 480, zone5: 360 },
        splits: [
          { distance: 1000, duration: 340, avgPace: 340, avgHr: 140 },
          { distance: 2000, duration: 350, avgPace: 350, avgHr: 148 },
          { distance: 3000, duration: 355, avgPace: 355, avgHr: 155 },
          { distance: 4000, duration: 360, avgPace: 360, avgHr: 160 },
          { distance: 5000, duration: 348, avgPace: 348, avgHr: 158 },
        ],
        sportType: 'outdoor_run',
      },
      {
        id: '2',
        startTime: now - 86400000 * 3,
        endTime: now - 86400000 * 3 + 1200 * 1000,
        duration: 1200,
        distance: 3200,
        avgPace: 375,
        avgHeartRate: 145,
        maxHeartRate: 168,
        calories: 198,
        hrZones: { zone1: 180, zone2: 360, zone3: 420, zone4: 180, zone5: 60 },
        splits: [
          { distance: 1000, duration: 370, avgPace: 370, avgHr: 138 },
          { distance: 2000, duration: 380, avgPace: 380, avgHr: 148 },
          { distance: 3000, duration: 375, avgPace: 375, avgHr: 150 },
        ],
        sportType: 'outdoor_run',
      },
      {
        id: '3',
        startTime: now - 86400000 * 5,
        endTime: now - 86400000 * 5 + 2100 * 1000,
        duration: 2100,
        distance: 6100,
        avgPace: 344,
        avgHeartRate: 155,
        maxHeartRate: 182,
        calories: 384,
        hrZones: { zone1: 60, zone2: 240, zone3: 600, zone4: 720, zone5: 480 },
        splits: [
          { distance: 1000, duration: 335, avgPace: 335, avgHr: 142 },
          { distance: 2000, duration: 340, avgPace: 340, avgHr: 150 },
          { distance: 3000, duration: 350, avgPace: 350, avgHr: 158 },
          { distance: 4000, duration: 345, avgPace: 345, avgHr: 160 },
          { distance: 5000, duration: 350, avgPace: 350, avgHr: 162 },
          { distance: 6000, duration: 338, avgPace: 338, avgHr: 158 },
        ],
        sportType: 'outdoor_run',
      },
    ]
  }
}
