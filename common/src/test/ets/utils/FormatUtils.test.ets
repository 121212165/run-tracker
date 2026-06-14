import { describe, it, expect } from '@ohos/hypium'
import { formatPace, formatDuration, formatDistance, formatDate } from '../../../src/main/ets/utils/Format'

describe('Format', () => {

  describe('formatPace()', () => {
    it('360 秒/km → "6\'00"', () => {
      expect(formatPace(360)).assertEqual("6'00")
    })
    it('305 秒/km → "5\'05"', () => {
      expect(formatPace(305)).assertEqual("5'05")
    })
    it('0 → "--\'--"', () => {
      expect(formatPace(0)).assertEqual("--'--\"")
    })
    it('负数 → "--\'--"', () => {
      expect(formatPace(-10)).assertEqual("--'--\"")
    })
  })

  describe('formatDuration()', () => {
    it('3661 秒 → "01:01:01"', () => {
      expect(formatDuration(3661)).assertEqual('01:01:01')
    })
    it('59 秒 → "00:59"', () => {
      expect(formatDuration(59)).assertEqual('00:59')
    })
    it('0 秒 → "00:00"', () => {
      expect(formatDuration(0)).assertEqual('00:00')
    })
  })

  describe('formatDistance()', () => {
    it('5230 米 → "5.2"', () => {
      expect(formatDistance(5230)).assertEqual('5.2')
    })
    it('1000 米 → "1.0"', () => {
      expect(formatDistance(1000)).assertEqual('1.0')
    })
    it('0 米 → "0.0"', () => {
      expect(formatDistance(0)).assertEqual('0.0')
    })
  })

  describe('formatDate()', () => {
    it('格式化为 M月D日', () => {
      const ts = new Date(2026, 5, 14).getTime()
      expect(formatDate(ts)).assertEqual('6月14日')
    })
  })
})
