import { Theme, RunRecord, formatPace, formatDistance, formatDuration } from 'common/Index'
import router from '@ohos.router'

@Entry
@Component
struct RunResultPage {
  @State record: RunRecord = {
    id: 'default',
    startTime: Date.now() - 1860000,
    endTime: Date.now(),
    duration: 1860,
    distance: 5300,
    avgPace: 351,
    avgHr: 152,
    calories: 332,
  }

  aboutToAppear() {
    const params = router.getParams() as Record<string, string>
    if (params && params['record']) {
      try {
        this.record = JSON.parse(params['record']) as RunRecord
      } catch (e) {
        // use default
      }
    }
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          Text(formatDistance(this.record.distance))
            .fontSize(48)
            .fontColor(Theme.BRAND)
            .fontWeight(Theme.FONT_BOLD)
          Text('km')
            .fontSize(Theme.FONT_BODY)
            .fontColor(Theme.TEXT_SECONDARY)
            .fontWeight(Theme.FONT_REGULAR)
            .margin({ top: Theme.SPACE_4 })

          Row() {
            this.StatItem('用时', formatDuration(this.record.duration))
            this.StatItem('配速', `${formatPace(this.record.avgPace)}/km`)
            this.StatItem('卡路里', `${this.record.calories} kcal`)
          }
          .width('100%')
          .margin({ top: Theme.SPACE_32 })
          .justifyContent(FlexAlign.SpaceEvenly)

          Row() {
            this.StatItem('平均心率', `${this.record.avgHr} bpm`)
          }
          .width('100%')
          .margin({ top: Theme.SPACE_24 })
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .padding({ left: Theme.SPACE_16, right: Theme.SPACE_16, top: Theme.SPACE_32 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Button('保存')
        .width('100%')
        .height(48)
        .backgroundColor(Theme.BRAND)
        .fontColor('#FFFFFF')
        .fontSize(Theme.FONT_BODY)
        .fontWeight(Theme.FONT_BOLD)
        .borderRadius(Theme.RADIUS_SM)
        .margin({ top: Theme.SPACE_16, bottom: Theme.SPACE_32 })
        .padding({ left: Theme.SPACE_16, right: Theme.SPACE_16 })
        .onClick(() => {
          router.back()
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Theme.BG)
  }

  @Builder
  StatItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(Theme.FONT_CAPTION)
        .fontColor(Theme.TEXT_TERTIARY)
        .fontWeight(Theme.FONT_REGULAR)
      Text(value)
        .fontSize(16)
        .fontColor(Theme.TEXT_PRIMARY)
        .fontWeight(Theme.FONT_BOLD)
        .margin({ top: Theme.SPACE_4 })
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
  }
}
