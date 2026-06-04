// 心率区间条组件
import { DesignTokens, HrZoneDistribution } from '../viewmodel/RunningViewModel'

@Component
export struct HrZoneBar {
  @Prop hrZones: HrZoneDistribution = { zone1: 0, zone2: 0, zone3: 0, zone4: 0, zone5: 0 }
  @Prop showLabels: boolean = false

  build() {
    Column() {
      // 区间横条
      Row() {
        ForEach(this.getZoneItems(), (item: ZoneItem) => {
          Row()
            .width(item.percent + '%')
            .height(8)
            .backgroundColor(item.color)
        }, (item: ZoneItem) => item.key)
      }
      .width('100%')
      .height(8)
      .borderRadius(DesignTokens.RADIUS_SM)
      .clip(true)

      // 标签行
      if (this.showLabels) {
        Row() {
          ForEach(this.getZoneLabels(), (label: ZoneLabel) => {
            Column() {
              Row()
                .width(8)
                .height(8)
                .borderRadius(4)
                .backgroundColor(label.color)
              Text(label.name)
                .fontSize(10)
                .fontColor(DesignTokens.TEXT_TERTIARY)
                .margin({ top: DesignTokens.SPACE_4 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
          }, (label: ZoneLabel) => label.key)
        }
        .width('100%')
        .margin({ top: DesignTokens.SPACE_8 })
      }
    }
    .width('100%')
  }

  private getZoneItems(): ZoneItem[] {
    const total = this.hrZones.zone1 + this.hrZones.zone2 + this.hrZones.zone3 +
      this.hrZones.zone4 + this.hrZones.zone5
    if (total === 0) {
      return [
        { key: 'z1', percent: 20, color: DesignTokens.HR_ZONE_1 },
        { key: 'z2', percent: 20, color: DesignTokens.HR_ZONE_2 },
        { key: 'z3', percent: 20, color: DesignTokens.HR_ZONE_3 },
        { key: 'z4', percent: 20, color: DesignTokens.HR_ZONE_4 },
        { key: 'z5', percent: 20, color: DesignTokens.HR_ZONE_5 },
      ]
    }
    return [
      { key: 'z1', percent: this.hrZones.zone1 / total * 100, color: DesignTokens.HR_ZONE_1 },
      { key: 'z2', percent: this.hrZones.zone2 / total * 100, color: DesignTokens.HR_ZONE_2 },
      { key: 'z3', percent: this.hrZones.zone3 / total * 100, color: DesignTokens.HR_ZONE_3 },
      { key: 'z4', percent: this.hrZones.zone4 / total * 100, color: DesignTokens.HR_ZONE_4 },
      { key: 'z5', percent: this.hrZones.zone5 / total * 100, color: DesignTokens.HR_ZONE_5 },
    ]
  }

  private getZoneLabels(): ZoneLabel[] {
    return [
      { key: 'l1', name: '热身', color: DesignTokens.HR_ZONE_1 },
      { key: 'l2', name: '燃脂', color: DesignTokens.HR_ZONE_2 },
      { key: 'l3', name: '有氧', color: DesignTokens.HR_ZONE_3 },
      { key: 'l4', name: '无氧', color: DesignTokens.HR_ZONE_4 },
      { key: 'l5', name: '最大', color: DesignTokens.HR_ZONE_5 },
    ]
  }
}

interface ZoneItem {
  key: string
  percent: number
  color: string
}

interface ZoneLabel {
  key: string
  name: string
  color: string
}
