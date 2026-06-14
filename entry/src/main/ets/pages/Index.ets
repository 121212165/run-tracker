import { Theme, RunRecord, formatPace, formatDistance, formatDate, formatTime } from 'common/Index'
import { BottomTabBar } from '../components/BottomTabBar'
import { RunStatCard } from '../components/RunStatCard'
import router from '@ohos.router'

@Entry
@Component
struct Index {
  @State currentTab: number = 0
  @State weeklyDistance: number = 12.5
  @State weeklyGoal: number = 20
  @State recentRuns: RunRecord[] = []

  aboutToAppear() {
    this.recentRuns = this.getMockRuns()
  }

  build() {
    Column() {
      Stack() {
        if (this.currentTab === 0) {
          this.HomeTab()
        } else {
          this.HistoryTab()
        }
      }
      .layoutWeight(1)

      BottomTabBar({
        currentTab: this.currentTab,
        onTabChange: (index: number) => {
          this.currentTab = index
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Theme.BG)
  }

  @Builder
  HomeTab() {
    Scroll() {
      Column() {
        Text(this.getGreeting())
          .fontSize(Theme.FONT_TITLE)
          .fontColor(Theme.TEXT_PRIMARY)
          .fontWeight(Theme.FONT_BOLD)
          .width('100%')
          .margin({ top: Theme.SPACE_24, bottom: Theme.SPACE_16 })

        this.WeeklyGoalSection()
        this.TodayStatsSection()

        Button('开始跑步')
          .width('100%')
          .height(48)
          .backgroundColor(Theme.BRAND)
          .fontColor('#FFFFFF')
          .fontSize(Theme.FONT_BODY)
          .fontWeight(Theme.FONT_BOLD)
          .borderRadius(Theme.RADIUS_SM)
          .margin({ top: Theme.SPACE_24 })
          .onClick(() => {
            router.pushUrl({ url: 'pages/RunningPage' })
          })

        this.RecentRunsSection()
      }
      .width('100%')
      .padding({ left: Theme.SPACE_16, right: Theme.SPACE_16, bottom: Theme.SPACE_24 })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }

  @Builder
  HistoryTab() {
    Column() {
      Text('跑步记录')
        .fontSize(Theme.FONT_TITLE)
        .fontColor(Theme.TEXT_PRIMARY)
        .fontWeight(Theme.FONT_BOLD)
        .width('100%')
        .padding({ left: Theme.SPACE_16, top: Theme.SPACE_16, bottom: Theme.SPACE_8 })

      List({ space: Theme.SPACE_8 }) {
        ForEach(this.recentRuns, (run: RunRecord) => {
          ListItem() {
            Row() {
              Column() {
                Text(`${formatDate(run.startTime)}  ${formatTime(run.startTime)}`)
                  .fontSize(Theme.FONT_BODY)
                  .fontColor(Theme.TEXT_PRIMARY)
                Text(`${formatDistance(run.distance)} km · ${formatPace(run.avgPace)}/km`)
                  .fontSize(Theme.FONT_CAPTION)
                  .fontColor(Theme.TEXT_SECONDARY)
                  .margin({ top: Theme.SPACE_4 })
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Text(`${run.calories} kcal`)
                .fontSize(Theme.FONT_CAPTION)
                .fontColor(Theme.TEXT_TERTIARY)
            }
            .width('100%')
            .padding(Theme.SPACE_16)
            .borderRadius(Theme.RADIUS_SM)
            .backgroundColor(Theme.BG)
            .border({ width: 1, color: Theme.BORDER })
          }
        }, (run: RunRecord) => run.id)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: Theme.SPACE_16, right: Theme.SPACE_16, bottom: Theme.SPACE_16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Theme.BG_SUB)
  }

  @Builder
  WeeklyGoalSection() {
    Column() {
      Row() {
        Text('本周目标')
          .fontSize(Theme.FONT_BODY)
          .fontColor(Theme.TEXT_PRIMARY)
          .fontWeight(Theme.FONT_REGULAR)
        Blank()
        Text(`${this.weeklyDistance.toFixed(1)} / ${this.weeklyGoal} km`)
          .fontSize(Theme.FONT_CAPTION)
          .fontColor(Theme.TEXT_SECONDARY)
          .fontWeight(Theme.FONT_REGULAR)
      }
      .width('100%')

      Row() {
        Row()
          .width(`${Math.min(this.weeklyDistance / this.weeklyGoal * 100, 100)}%`)
          .height('100%')
          .backgroundColor(Theme.BRAND)
          .borderRadius(4)
      }
      .width('100%')
      .height(8)
      .borderRadius(4)
      .backgroundColor(Theme.BG_SUB)
      .margin({ top: Theme.SPACE_8 })
    }
    .width('100%')
    .padding(Theme.SPACE_16)
    .borderRadius(Theme.RADIUS_LG)
    .backgroundColor(Theme.BG)
    .border({ width: 1, color: Theme.BORDER })
  }

  @Builder
  TodayStatsSection() {
    Row() {
      RunStatCard({ label: '今日跑量', value: '3.2', unit: 'km' })
      RunStatCard({ label: '本周跑量', value: '12.5', unit: 'km' })
      RunStatCard({ label: '平均配速', value: "5'42\"", unit: '/km' })
    }
    .width('100%')
    .margin({ top: Theme.SPACE_16 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  RecentRunsSection() {
    Column() {
      Text('最近跑步')
        .fontSize(Theme.FONT_BODY)
        .fontColor(Theme.TEXT_PRIMARY)
        .fontWeight(Theme.FONT_BOLD)
        .width('100%')
        .margin({ top: Theme.SPACE_24, bottom: Theme.SPACE_8 })

      ForEach(this.recentRuns, (run: RunRecord) => {
        Row() {
          Column() {
            Text(`${formatDate(run.startTime)}  ${formatTime(run.startTime)}`)
              .fontSize(Theme.FONT_BODY)
              .fontColor(Theme.TEXT_PRIMARY)
              .fontWeight(Theme.FONT_REGULAR)
            Text(`${formatDistance(run.distance)} km · ${formatPace(run.avgPace)}/km`)
              .fontSize(Theme.FONT_CAPTION)
              .fontColor(Theme.TEXT_SECONDARY)
              .fontWeight(Theme.FONT_REGULAR)
              .margin({ top: Theme.SPACE_4 })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Image($r('sys.symbol.chevron_right'))
            .width(16)
            .height(16)
            .fillColor(Theme.TEXT_TERTIARY)
        }
        .width('100%')
        .padding(Theme.SPACE_16)
        .borderRadius(Theme.RADIUS_SM)
        .backgroundColor(Theme.BG)
        .border({ width: 1, color: Theme.BORDER })
        .margin({ top: Theme.SPACE_8 })
      }, (run: RunRecord) => run.id)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  private getGreeting(): string {
    const hour = new Date().getHours()
    if (hour < 6) return '夜深了'
    if (hour < 12) return '早上好'
    if (hour < 14) return '中午好'
    if (hour < 18) return '下午好'
    return '晚上好'
  }

  private getMockRuns(): RunRecord[] {
    const now = Date.now()
    return [
      { id: '1', startTime: now - 86400000, endTime: now - 86400000 + 1860000, duration: 1860, distance: 5300, avgPace: 351, avgHr: 152, calories: 332 },
      { id: '2', startTime: now - 86400000 * 3, endTime: now - 86400000 * 3 + 1200000, duration: 1200, distance: 3200, avgPace: 375, avgHr: 145, calories: 198 },
      { id: '3', startTime: now - 86400000 * 5, endTime: now - 86400000 * 5 + 2100000, duration: 2100, distance: 6100, avgPace: 344, avgHr: 155, calories: 384 },
    ]
  }
}
