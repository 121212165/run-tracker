// 设计 Token — 严格执行极简规范
// 60-30-10 色彩配比 | 圆角 12/8 | 间距4系 | 字阶 24/14/12

export class DesignTokens {
  // 色彩
  static readonly BG = '#FFFFFF'
  static readonly BG_SUB = '#F8F9FA'
  static readonly TEXT_PRIMARY = '#1A1A1A'
  static readonly TEXT_SECONDARY = '#6B7280'
  static readonly TEXT_TERTIARY = '#9CA3AF'
  static readonly BORDER = '#E4E7EC'
  static readonly BRAND = '#E8453C'
  static readonly BRAND_LIGHT = '#FEF2F2'
  static readonly SUCCESS = '#22C55E'
  static readonly SUCCESS_LIGHT = '#F0FDF4'

  // 圆角 — 仅两个值
  static readonly RADIUS_LG = 12
  static readonly RADIUS_SM = 8

  // 间距 — 4 的倍数单选题
  static readonly SPACE_4 = 4
  static readonly SPACE_8 = 8
  static readonly SPACE_16 = 16
  static readonly SPACE_24 = 24
  static readonly SPACE_32 = 32
  static readonly SPACE_48 = 48

  // 字阶 — 仅三种
  static readonly FONT_TITLE = 24
  static readonly FONT_BODY = 14
  static readonly FONT_CAPTION = 12
  static readonly FONT_WEIGHT_BOLD = 700
  static readonly FONT_WEIGHT_REGULAR = 400

  // 心率区间颜色
  static readonly HR_ZONE_1 = '#22C55E'  // 热身
  static readonly HR_ZONE_2 = '#84CC16'  // 燃脂
  static readonly HR_ZONE_3 = '#EAB308'  // 有氧
  static readonly HR_ZONE_4 = '#F97316'  // 无氧
  static readonly HR_ZONE_5 = '#E8453C'  // 最大

  // 手表端（黑底高对比）
  static readonly WATCH_BG = '#000000'
  static readonly WATCH_TEXT = '#FFFFFF'
  static readonly WATCH_TEXT_DIM = '#666666'
}
