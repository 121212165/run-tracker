// 我的页面
const COLORS = {
  BG: '#FFFFFF', BG_SUB: '#F8F9FA',
  TEXT_1: '#1A1A1A', TEXT_2: '#6B7280', TEXT_3: '#9CA3AF',
  BORDER: '#E4E7EC', BRAND: '#E8453C', BRAND_LIGHT: '#FEF2F2',
  SUCCESS: '#22C55E'
}

@Entry
@Component
struct ProfilePage {
  @State nickname: string = '跑步爱好者'
  @State connectedWatch: string = '华为 Watch GT 4'
  @State healthKitAuthorized: boolean = true
  @State maxHeartRate: number = 190
  @State weeklyGoal: number = 30
  @State weight: number = 70

  build() {
    Scroll() {
      Column({ space: 16 }) {
        // 头像 + 昵称
        Row({ space: 16 }) {
          // 头像占位圆圈
          Circle()
            .width(56)
            .height(56)
            .fill(COLORS.BG_SUB)
            .stroke(COLORS.BORDER)

          Column() {
            Text(this.nickname)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLORS.TEXT_1)
            Text('已跑步 42 天')
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(24)
        .borderRadius(12)
        .backgroundColor(COLORS.BG)
        .border({ width: 1, color: COLORS.BORDER, radius: 12 })
        .margin({ left: 16, right: 16, top: 16 })

        // 已连接设备卡片
        Column() {
          Text('已连接设备')
            .fontSize(12)
            .fontColor(COLORS.TEXT_3)
            .width('100%')
            .margin({ bottom: 12 })

          Row() {
            // 设备图标占位
            Circle()
              .width(36)
              .height(36)
              .fill(COLORS.BG_SUB)
              .stroke(COLORS.BORDER)

            Column() {
              Text(this.connectedWatch)
                .fontSize(14)
                .fontColor(COLORS.TEXT_1)
              Text('已连接')
                .fontSize(12)
                .fontColor(COLORS.SUCCESS)
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: 12 })
            .layoutWeight(1)

            Text('管理')
              .fontSize(12)
              .fontColor(COLORS.TEXT_2)
          }
          .width('100%')
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor(COLORS.BG)
        .border({ width: 1, color: COLORS.BORDER, radius: 12 })
        .margin({ left: 16, right: 16 })

        // Health Kit 授权
        Row() {
          Column() {
            Text('Health Kit 授权')
              .fontSize(14)
              .fontColor(COLORS.TEXT_1)
            Text('允许读取和写入健康数据')
              .fontSize(12)
              .fontColor(COLORS.TEXT_3)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Toggle({ type: ToggleType.Switch, isOn: this.healthKitAuthorized })
            .onChange((isOn: boolean) => {
              this.healthKitAuthorized = isOn
            })
            .selectedColor(COLORS.BRAND)
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor(COLORS.BG)
        .border({ width: 1, color: COLORS.BORDER, radius: 12 })
        .margin({ left: 16, right: 16 })

        // 设置项列表
        Column() {
          // 最大心率
          this.SettingItem('最大心率', `${this.maxHeartRate} bpm`)
          this.SettingDivider()

          // 周目标
          this.SettingItem('周目标', `${this.weeklyGoal} km`)
          this.SettingDivider()

          // 体重
          this.SettingItem('体重', `${this.weight} kg`)
          this.SettingDivider()

          // 数据导出
          this.SettingItem('数据导出', '')
          this.SettingDivider()

          // 关于
          this.SettingItem('关于', '')
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 4, bottom: 4 })
        .borderRadius(12)
        .backgroundColor(COLORS.BG)
        .border({ width: 1, color: COLORS.BORDER, radius: 12 })
        .margin({ left: 16, right: 16 })

        // 底部留白
        Row().height(32)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.BG_SUB)
  }

  // 设置项行
  @Builder
  SettingItem(title: string, value: string) {
    Row() {
      Text(title)
        .fontSize(14)
        .fontColor(COLORS.TEXT_1)
        .layoutWeight(1)

      if (value) {
        Text(value)
          .fontSize(14)
          .fontColor(COLORS.TEXT_2)
      }

      Text('>')
        .fontSize(14)
        .fontColor(COLORS.TEXT_3)
        .margin({ left: 8 })
    }
    .width('100%')
    .height(48)
  }

  // 分隔线
  @Builder
  SettingDivider() {
    Row()
      .width('100%')
      .height(1)
      .backgroundColor(COLORS.BORDER)
  }
}
