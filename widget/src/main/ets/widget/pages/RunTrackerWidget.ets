// 跑步追踪服务卡片 — 4×1 横条 & 2×2 方块

import { WidgetState, WidgetFormData, createIdleFormData, createRunningFormData,
  createDoneFormData } from '../../model/WidgetModels'
import { formBindingData, FormExtensionAbility, formInfo, formProvider } from '@kit.FormKit'
import { Want } from '@kit.AbilityKit'

const COLORS = {
  BG: '#FFFFFF',
  BG_SUB: '#F8F9FA',
  TEXT_1: '#1A1A1A',
  TEXT_2: '#6B7280',
  TEXT_3: '#9CA3AF',
  BORDER: '#E4E7EC',
  BRAND: '#E8453C',
  BRAND_LIGHT: '#FEF2F2',
  SUCCESS: '#22C55E',
  SUCCESS_LIGHT: '#F0FDF4'
}
const RADIUS_LG = 12
const RADIUS_SM = 8

// ═══════════════════════════════════════════
// FormExtension 生命周期
// ═══════════════════════════════════════════
@FormExtension
export default class RunTrackerWidget extends FormExtensionAbility {
  onAddForm(want: Want): formBindingData.FormBindingData {
    let formData = createIdleFormData()
    return formBindingData.createFormBindingData(formData)
  }

  onUpdateForm(formId: string): formBindingData.FormBindingData {
    let formData = createIdleFormData()
    return formBindingData.createFormBindingData(formData)
  }

  onRemoveForm(formId: string): void {
  }

  onCastToNormalForm(formId: string): void {
  }
}

// ═══════════════════════════════════════════
// 4×1 横条卡片 (360×80) — 三态
// ═══════════════════════════════════════════
@Entry
@Component
struct Widget4x1 {
  @State state: string = 'idle'
  @State todayDistance: string = '0.0'
  @State currentDistance: string = '0.0'
  @State avgHr: number = 0
  @State currentHr: number = 0
  @State formattedPace: string = "--'--\""
  @State formattedDuration: string = '00:00'
  @State calories: number = 0

  build() {
    Column() {
      if (this.state === WidgetState.IDLE || this.state === 'idle') {
        // ── 空闲态 ──
        Row() {
          Row() {
            Text('🏃')
              .fontSize(20)
          }
          .width(40)
          .height(40)
          .borderRadius(RADIUS_SM)
          .backgroundColor(COLORS.BRAND_LIGHT)
          .justifyContent(FlexAlign.Center)

          Column() {
            Text('今日跑量')
              .fontSize(12)
              .fontColor(COLORS.TEXT_2)
            Row() {
              Text(this.todayDistance)
                .fontSize(14)
                .fontWeight(700)
                .fontColor(COLORS.TEXT_1)
              Text('km')
                .fontSize(12)
                .fontColor(COLORS.TEXT_2)
                .margin({ left: 2 })
            }
            Text('心率 —')
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 12 })
          .layoutWeight(1)

          Button('开始跑步')
            .fontSize(12)
            .fontColor(COLORS.BG)
            .backgroundColor(COLORS.BRAND)
            .borderRadius(RADIUS_SM)
            .height(32)
            .padding({ left: 12, right: 12 })
            .type(ButtonType.Normal)
        }
        .width('100%')
        .height(80)
        .padding({ left: 16, right: 16 })
        .backgroundColor(COLORS.BG)
        .borderRadius(RADIUS_LG)
        .alignItems(VerticalAlign.Center)
      }

      if (this.state === WidgetState.RUNNING || this.state === 'running') {
        // ── 跑步中 ──
        Row() {
          Row() {
            Text('🏃')
              .fontSize(20)
          }
          .width(40)
          .height(40)
          .borderRadius(RADIUS_SM)
          .backgroundColor(COLORS.BRAND_LIGHT)
          .justifyContent(FlexAlign.Center)

          Column() {
            Row() {
              Text(this.currentDistance)
                .fontSize(14)
                .fontWeight(700)
                .fontColor(COLORS.BRAND)
              Text('km')
                .fontSize(12)
                .fontColor(COLORS.BRAND)
                .margin({ left: 2 })
            }
            Text(`心率 ${this.currentHr}`)
              .fontSize(12)
              .fontColor(COLORS.BRAND)
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 12 })
          .layoutWeight(1)

          Button('暂停')
            .fontSize(12)
            .fontColor(COLORS.TEXT_1)
            .backgroundColor(COLORS.BG_SUB)
            .borderRadius(RADIUS_SM)
            .height(32)
            .padding({ left: 16, right: 16 })
            .type(ButtonType.Normal)
        }
        .width('100%')
        .height(80)
        .padding({ left: 16, right: 16 })
        .backgroundColor(COLORS.BG)
        .borderRadius(RADIUS_LG)
        .border({ width: 1, color: COLORS.BRAND, style: BorderStyle.Solid })
        .alignItems(VerticalAlign.Center)
      }

      if (this.state === WidgetState.DONE || this.state === 'done') {
        // ── 已完成 ──
        Row() {
          Row() {
            Text('✓')
              .fontSize(20)
              .fontColor(COLORS.SUCCESS)
              .fontWeight(700)
          }
          .width(40)
          .height(40)
          .borderRadius(RADIUS_SM)
          .backgroundColor(COLORS.SUCCESS_LIGHT)
          .justifyContent(FlexAlign.Center)

          Column() {
            Row() {
              Text('今日跑量 ')
                .fontSize(12)
                .fontColor(COLORS.TEXT_2)
              Text(this.todayDistance)
                .fontSize(14)
                .fontWeight(700)
                .fontColor(COLORS.BRAND)
              Text('km')
                .fontSize(12)
                .fontColor(COLORS.BRAND)
                .margin({ left: 2 })
            }
            Text(`平均心率 ${this.avgHr}`)
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 12 })
          .layoutWeight(1)

          Button('查看详情')
            .fontSize(12)
            .fontColor(COLORS.TEXT_1)
            .backgroundColor(COLORS.BG_SUB)
            .borderRadius(RADIUS_SM)
            .height(32)
            .padding({ left: 12, right: 12 })
            .type(ButtonType.Normal)
        }
        .width('100%')
        .height(80)
        .padding({ left: 16, right: 16 })
        .backgroundColor(COLORS.BG)
        .borderRadius(RADIUS_LG)
        .alignItems(VerticalAlign.Center)
      }
    }
  }
}

// ═══════════════════════════════════════════
// 2×2 方块卡片 (196×196) — 三态
// ═══════════════════════════════════════════
@Entry
@Component
struct Widget2x2 {
  @State state: string = 'idle'
  @State todayDistance: string = '0.0'
  @State currentDistance: string = '0.0'
  @State avgHr: number = 0
  @State currentHr: number = 0
  @State formattedPace: string = "--'--\""
  @State formattedDuration: string = '00:00'
  @State calories: number = 0
  @State date: string = ''
  @State weeklyGoal: number = 30
  @State formattedWeeklyDistance: string = '0.0'
  @State restHr: number = 62
  @State weeklyProgress: number = 0

  build() {
    Column() {
      if (this.state === WidgetState.IDLE || this.state === 'idle') {
        // ── 空闲态 ──
        Column() {
          Row() {
            Text('今日跑步')
              .fontSize(14)
              .fontWeight(700)
              .fontColor(COLORS.TEXT_1)
            Text(this.date)
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
              .margin({ left: 8 })
          }
          .width('100%')
          .margin({ bottom: 16 })

          // 空进度环
          Stack() {
            Progress({ value: 0, total: 1, type: ProgressType.Ring })
              .width(72)
              .height(72)
              .style({ strokeWidth: 6 })
              .color(COLORS.BORDER)
            Column() {
              Text('0')
                .fontSize(20)
                .fontWeight(700)
                .fontColor(COLORS.TEXT_1)
              Text('km')
                .fontSize(10)
                .fontColor(COLORS.TEXT_3)
            }
          }
          .margin({ bottom: 16 })

          Row() {
            Column() {
              Text(`周目标 ${this.formattedWeeklyDistance}/${this.weeklyGoal}km`)
                .fontSize(12)
                .fontColor(COLORS.TEXT_2)
              Text(`静息心率 ${this.restHr}`)
                .fontSize(12)
                .fontColor(COLORS.TEXT_3)
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .margin({ bottom: 16 })

          Button('开始跑步')
            .width('100%')
            .height(36)
            .fontSize(14)
            .fontColor(COLORS.BG)
            .backgroundColor(COLORS.BRAND)
            .borderRadius(RADIUS_SM)
            .type(ButtonType.Normal)
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .backgroundColor(COLORS.BG)
        .borderRadius(RADIUS_LG)
        .alignItems(HorizontalAlign.Start)
      }

      if (this.state === WidgetState.RUNNING || this.state === 'running') {
        // ── 跑步中 ──
        Column() {
          Row() {
            Text('跑步中')
              .fontSize(14)
              .fontWeight(700)
              .fontColor(COLORS.BRAND)
            Text(this.formattedDuration)
              .fontSize(12)
              .fontColor(COLORS.TEXT_2)
              .margin({ left: 8 })
          }
          .width('100%')
          .margin({ bottom: 12 })

          // 半环进度
          Stack() {
            Progress({ value: 0.5, total: 1, type: ProgressType.Ring })
              .width(72)
              .height(72)
              .style({ strokeWidth: 6 })
              .color(COLORS.BRAND)
            Column() {
              Text(this.currentDistance)
                .fontSize(18)
                .fontWeight(700)
                .fontColor(COLORS.BRAND)
              Text('km')
                .fontSize(10)
                .fontColor(COLORS.BRAND)
            }
          }
          .margin({ bottom: 12 })

          Row() {
            Column() {
              Text('配速')
                .fontSize(10)
                .fontColor(COLORS.TEXT_3)
              Text(this.formattedPace)
                .fontSize(14)
                .fontWeight(700)
                .fontColor(COLORS.BRAND)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Column() {
              Text('心率')
                .fontSize(10)
                .fontColor(COLORS.TEXT_3)
              Text(`${this.currentHr}`)
                .fontSize(14)
                .fontWeight(700)
                .fontColor(COLORS.BRAND)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Column() {
              Text('消耗')
                .fontSize(10)
                .fontColor(COLORS.TEXT_3)
              Text(`${this.calories}`)
                .fontSize(14)
                .fontWeight(700)
                .fontColor(COLORS.TEXT_1)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .margin({ bottom: 12 })

          Button('暂停')
            .width('100%')
            .height(36)
            .fontSize(14)
            .fontColor(COLORS.TEXT_1)
            .backgroundColor(COLORS.BG_SUB)
            .borderRadius(RADIUS_SM)
            .type(ButtonType.Normal)
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .backgroundColor(COLORS.BG)
        .borderRadius(RADIUS_LG)
        .border({ width: 1, color: COLORS.BRAND, style: BorderStyle.Solid })
        .alignItems(HorizontalAlign.Start)
      }

      if (this.state === WidgetState.DONE || this.state === 'done') {
        // ── 已完成 ──
        Column() {
          Row() {
            Text('已完成 ✓')
              .fontSize(14)
              .fontWeight(700)
              .fontColor(COLORS.SUCCESS)
          }
          .width('100%')
          .margin({ bottom: 12 })

          // 72% 绿色进度环
          Stack() {
            Progress({ value: this.weeklyProgress, total: 1, type: ProgressType.Ring })
              .width(72)
              .height(72)
              .style({ strokeWidth: 6 })
              .color(COLORS.SUCCESS)
            Column() {
              Text(this.todayDistance)
                .fontSize(18)
                .fontWeight(700)
                .fontColor(COLORS.SUCCESS)
              Text('km')
                .fontSize(10)
                .fontColor(COLORS.SUCCESS)
            }
          }
          .margin({ bottom: 12 })

          Row() {
            Column() {
              Text('用时')
                .fontSize(10)
                .fontColor(COLORS.TEXT_3)
              Text(this.formattedDuration)
                .fontSize(14)
                .fontWeight(700)
                .fontColor(COLORS.TEXT_1)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Column() {
              Text('平均心率')
                .fontSize(10)
                .fontColor(COLORS.TEXT_3)
              Text(`${this.avgHr}`)
                .fontSize(14)
                .fontWeight(700)
                .fontColor(COLORS.TEXT_1)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Column() {
              Text('消耗')
                .fontSize(10)
                .fontColor(COLORS.TEXT_3)
              Text(`${this.calories}`)
                .fontSize(14)
                .fontWeight(700)
                .fontColor(COLORS.TEXT_1)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .margin({ bottom: 12 })

          Button('查看详情')
            .width('100%')
            .height(36)
            .fontSize(14)
            .fontColor(COLORS.TEXT_1)
            .backgroundColor(COLORS.BG_SUB)
            .borderRadius(RADIUS_SM)
            .type(ButtonType.Normal)
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .backgroundColor(COLORS.BG)
        .borderRadius(RADIUS_LG)
        .alignItems(HorizontalAlign.Start)
      }
    }
  }
}
