// FormatUtils.test.ets
// 单元测试：格式化工具函数
// 对应测试计划 ID: PC-05, PC-06, PC-07

import { describe, it, expect } from '@ohos/hypium';
import { formatPace, formatDuration, formatDistance, formatDate } from '../../../common/src/main/ets/utils/FormatUtils';

describe('FormatUtils', () => {

  // ==================== formatPace ====================
  describe('formatPace()', () => {
    it('输入 360 秒/km → 输出 "6:00"', () => {
      const result = formatPace(360);
      expect(result).assertEqual('6:00');
    });

    it('输入 305 秒/km → 输出 "5:05"', () => {
      const result = formatPace(305);
      expect(result).assertEqual('5:05');
    });

    it('输入 275 秒/km → 输出 "4:35"', () => {
      const result = formatPace(275);
      expect(result).assertEqual('4:35');
    });

    it('输入 0 返回 "--:--"', () => {
      const result = formatPace(0);
      expect(result).assertEqual('--:--');
    });

    it('输入负数返回 "--:--"', () => {
      const result = formatPace(-10);
      expect(result).assertEqual('--:--');
    });
  });

  // ==================== formatDuration ====================
  describe('formatDuration()', () => {
    it('输入 3661 秒 → 输出 "1:01:01"', () => {
      const result = formatDuration(3661);
      expect(result).assertEqual('1:01:01');
    });

    it('输入 59 秒 → 输出 "0:00:59"', () => {
      const result = formatDuration(59);
      expect(result).assertEqual('0:00:59');
    });

    it('输入 3600 秒 → 输出 "1:00:00"', () => {
      const result = formatDuration(3600);
      expect(result).assertEqual('1:00:00');
    });

    it('输入 7200 秒 → 输出 "2:00:00"', () => {
      const result = formatDuration(7200);
      expect(result).assertEqual('2:00:00');
    });

    it('输入 0 秒 → 输出 "0:00:00"', () => {
      const result = formatDuration(0);
      // 根据实现可能返回 "0:00:00" 或 "0:00:00"
      expect(result).assertEqual('0:00:00');
    });
  });

  // ==================== formatDistance ====================
  describe('formatDistance()', () => {
    it('输入 5230 米 → 输出 "5.23"', () => {
      const result = formatDistance(5230);
      expect(result).assertEqual('5.23');
    });

    it('输入 1000 米 → 输出 "1.00"', () => {
      const result = formatDistance(1000);
      expect(result).assertEqual('1.00');
    });

    it('输入 0 米 → 输出 "0.00"', () => {
      const result = formatDistance(0);
      expect(result).assertEqual('0.00');
    });

    it('输入 150 米 → 输出 "0.15"', () => {
      const result = formatDistance(150);
      expect(result).assertEqual('0.15');
    });

    it('输入 42195 米(全马) → 输出 "42.20"', () => {
      const result = formatDistance(42195);
      expect(result).assertEqual('42.20');
    });
  });

  // ==================== formatDate ====================
  describe('formatDate()', () => {
    it('格式化日期为 YYYY-MM-DD', () => {
      const date = new Date(2026, 5, 4); // 2026-06-04
      const result = formatDate(date);
      expect(result).assertEqual('2026-06-04');
    });

    it('格式化日期为 YYYY-MM-DD (个位数月份/日期补零)', () => {
      const date = new Date(2026, 0, 3); // 2026-01-03
      const result = formatDate(date);
      expect(result).assertEqual('2026-01-03');
    });
  });
});
