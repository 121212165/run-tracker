// 跑步结果页
import { DesignTokens, RunRecord, HrZoneDistribution, SplitPace, formatPace, formatDistance, formatDuration } from '../viewmodel/RunningViewModel'
import { HrZoneBar } from '../components/HrZoneBar'
import router from '@ohos.router'

@Entry
@Component
struct RunResultPage {
  @State record: RunRecord = this.getDefaultRecord()

  aboutToAppear() {
    const params = router.getParams() as Record<string, string>
    if (params && params['record']) {
      try {
        this.record = JSON.parse(params['record']) as RunRecord
      } catch (e) {
        // 使用默认数据
      }
    }
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          // 大号距离
          Text(`${formatDistance(this.record.distance)}`)
            .fontSize(48)
            .fontColor(DesignTokens.BRAND)
            .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
          Text('km')
            .fontSize(DesignTokens.FONT_BODY)
            .fontColor(DesignTokens.TEXT_SECONDARY)
            .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
            .margin({ top: DesignTokens.SPACE_4 })

          // 3 列摘要
          Row() {
            this.SummaryItem('用时', formatDuration(this.record.duration))
            this.SummaryItem('配速', `${formatPace(this.record.avgPace)}/km`)
            this.SummaryItem('卡路里', `${this.record.calories} kcal`)
          }
          .width('100%')
          .margin({ top: DesignTokens.SPACE_32 })
          .justifyContent(FlexAlign.SpaceEvenly)

          // 心率区间分布
          this.HeartRateSection()

          // 分段配速
          this.SplitPaceSection()
        }
        .width('100%')
        .padding({ left: DesignTokens.SPACE_16, right: DesignTokens.SPACE_16, top: DesignTokens.SPACE_32 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // 保存按钮
      Button('保存')
        .width('100%')
        .height(48)
        .backgroundColor(DesignTokens.BRAND)
        .fontColor('#FFFFFF')
        .fontSize(DesignTokens.FONT_BODY)
        .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
        .borderRadius(DesignTokens.RADIUS_SM)
        .margin({ top: DesignTokens.SPACE_16, bottom: DesignTokens.SPACE_32 })
        .padding({ left: DesignTokens.SPACE_16, right: DesignTokens.SPACE_16 })
        .onClick(() => {
          router.back()
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.BG)
  }

  @Builder
  SummaryItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(DesignTokens.FONT_CAPTION)
        .fontColor(DesignTokens.TEXT_TERTIARY)
        .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
      Text(value)
        .fontSize(16)
        .fontColor(DesignTokens.TEXT_PRIMARY)
        .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
        .margin({ top: DesignTokens.SPACE_4 })
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
  }

  @Builder
  HeartRateSection() {
    Column() {
      Text('心率区间')
        .fontSize(DesignTokens.FONT_BODY)
        .fontColor(DesignTokens.TEXT_PRIMARY)
        .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
        .width('100%')
        .margin({ bottom: DesignTokens.SPACE_8 })

      HrZoneBar({ hrZones: this.record.hrZones, showLabels: true })

      // 心率数值
      Row() {
        this.HrZoneStat('平均', `${this.record.avgHeartRate} bpm`)
        this.HrZoneStat('最大', `${this.record.maxHeartRate} bpm`)
      }
      .width('100%')
      .margin({ top: DesignTokens.SPACE_16 })
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .padding(DesignTokens.SPACE_16)
    .borderRadius(DesignTokens.RADIUS_LG)
    .backgroundColor(DesignTokens.BG)
    .border({ width: 1, color: DesignTokens.BORDER })
    .margin({ top: DesignTokens.SPACE_24 })
  }

  @Builder
  HrZoneStat(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(DesignTokens.FONT_CAPTION)
        .fontColor(DesignTokens.TEXT_TERTIARY)
        .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
      Text(value)
        .fontSize(DesignTokens.FONT_BODY)
        .fontColor(DesignTokens.TEXT_PRIMARY)
        .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
        .margin({ top: DesignTokens.SPACE_4 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SplitPaceSection() {
    Column() {
      Text('分段配速')
        .fontSize(DesignTokens.FONT_BODY)
        .fontColor(DesignTokens.TEXT_PRIMARY)
        .fontWeight(DesignTokens.FONT_WEIGHT_BOLD)
        .width('100%')
        .margin({ bottom: DesignTokens.SPACE_16 })

      // 简单柱状图
      Row() {
        ForEach(this.record.splits, (split: SplitPace, index: number) => {
          Column() {
            // 柱条
            Row()
              .width(24)
              .height(this.getBarHeight(split.avgPace))
              .backgroundColor(this.getSplitColor(index))
              .borderRadius({ topLeft: 4, topRight: 4 })

            // 公里标签
            Text(`${index + 1}`)
              .fontSize(DesignTokens.FONT_CAPTION)
              .fontColor(DesignTokens.TEXT_TERTIARY)
              .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
              .margin({ top: DesignTokens.SPACE_4 })

            // 配速标签
            Text(formatPace(split.avgPace))
              .fontSize(10)
              .fontColor(DesignTokens.TEXT_SECONDARY)
              .fontWeight(DesignTokens.FONT_WEIGHT_REGULAR)
              .margin({ top: DesignTokens.SPACE_4 })
          }
          .alignItems(HorizontalAlign.Center)
          .layoutWeight(1)
        }, (split: SplitPace, index: number) => `split_${index}`)
      }
      .width('100%')
      .height(160)
      .alignItems(VerticalAlign.Bottom)
    }
    .width('100%')
    .padding(DesignTokens.SPACE_16)
    .borderRadius(DesignTokens.RADIUS_LG)
    .backgroundColor(DesignTokens.BG)
    .border({ width: 1, color: DesignTokens.BORDER })
    .margin({ top: DesignTokens.SPACE_24 })
  }

  private getBarHeight(pace: number): number {
    // 配速范围 300-420 秒/公里（5'00" - 7'00"），映射到 30-100 高度
    const minPace = 300
    const maxPace = 420
    const minHeight = 30
    const maxHeight = 100
    const clampedPace = Math.max(minPace, Math.min(maxPace, pace))
    const ratio = (clampedPace - minPace) / (maxPace - minPace)
    // 配速越慢（值越大），柱子越高
    return minHeight + ratio * (maxHeight - minHeight)
  }

  private getSplitColor(index: number): string {
    const colors = [
      DesignTokens.HR_ZONE_2,
      DesignTokens.HR_ZONE_3,
      DesignTokens.HR_ZONE_1,
      DesignTokens.HR_ZONE_4,
      DesignTokens.HR_ZONE_2,
      DesignTokens.HR_ZONE_3,
      DesignTokens.HR_ZONE_1,
      DesignTokens.HR_ZONE_4,
      DesignTokens.HR_ZONE_2,
      DesignTokens.HR_ZONE_3,
    ]
    return colors[index % colors.length]
  }

  private getDefaultRecord(): RunRecord {
    const now = Date.now()
    return {
      id: 'default',
      startTime: now - 1860000,
      endTime: now,
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
    }
  }
}
