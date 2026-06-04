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
export struct HrZoneRow {
  @Prop currentZone: number = 1

  private zoneColors: string[] = [
    COLORS.HR_Z1, COLORS.HR_Z2, COLORS.HR_Z3, COLORS.HR_Z4, COLORS.HR_Z5
  ]

  build() {
    Row() {
      ForEach(this.zoneColors, (color: string, index: number) => {
        Row()
          .layoutWeight(1)
          .height(6)
          .backgroundColor(index === this.currentZone - 1 ? color : COLORS.TEXT_DIM)
          .borderRadius(3)
          .margin({ left: index > 0 ? 4 : 0 })
      }, (index: number) => index.toString())
    }
    .width('100%')
  }
}
