const COLORS = {
  BG: '#000000',
  TEXT: '#FFFFFF',
  TEXT_DIM: '#666666',
  BRAND: '#E8453C',
  SUCCESS: '#22C55E',
  HR_Z1: '#22C55E',
  HR_Z2: '#84CC16',
  HR_Z3: '#EAB308',
  HR_Z4: '#F97316',
  HR_Z5: '#E8453C'
}

@Component
export struct CircleProgress {
  @Prop progress: number = 0
  @Prop label: string = ''
  @Prop ringColor: string = COLORS.BRAND
  private strokeWidth: number = 8

  build() {
    Stack() {
      // 背景环
      Circle()
        .width(140)
        .height(140)
        .fill(Color.Transparent)
        .stroke(COLORS.TEXT_DIM)
        .strokeWidth(this.strokeWidth)
      // 进度环
      Circle()
        .width(140)
        .height(140)
        .fill(Color.Transparent)
        .stroke(this.ringColor)
        .strokeWidth(this.strokeWidth)
        .strokeDasharray([Math.PI * 140 * this.progress, Math.PI * 140])
        .rotate({ angle: -90 })
      // 中心标签
      Text(this.label)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.TEXT)
    }
    .width(160)
    .height(160)
  }
}
