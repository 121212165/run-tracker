// RunModels.test.ets
// 单元测试：数据模型结构验证
// 对应测试计划 数据完整性检查

import { describe, it, expect } from '@ohos/hypium';
import { RunRecord, HrZoneDistribution, SplitPace, RunStatus } from '../../../src/main/ets/model/RunModels';

describe('RunModels', () => {

  describe('RunRecord 数据结构', () => {
    it('应包含 distance 字段 (米)', () => {
      const record: RunRecord = {
        id: '1',
        date: '2026-06-04',
        distance: 5230,
        duration: 1800,
        avgPace: 345,
        avgHr: 145,
        maxHr: 168,
        calories: 320,
        splits: [],
        hrZoneDistribution: null as unknown as HrZoneDistribution
      };
      expect(record.distance).assertEqual(5230);
    });

    it('应包含 duration 字段 (秒)', () => {
      const record: RunRecord = {
        id: '1',
        date: '2026-06-04',
        distance: 5000,
        duration: 1800,
        avgPace: 360,
        avgHr: 145,
        maxHr: 168,
        calories: 300,
        splits: [],
        hrZoneDistribution: null as unknown as HrZoneDistribution
      };
      expect(record.duration).assertEqual(1800);
    });

    it('calories 应为正数', () => {
      const record: RunRecord = {
        id: '1',
        date: '2026-06-04',
        distance: 5000,
        duration: 1800,
        avgPace: 360,
        avgHr: 145,
        maxHr: 168,
        calories: 300,
        splits: [],
        hrZoneDistribution: null as unknown as HrZoneDistribution
      };
      expect(record.calories > 0).assertTrue();
    });
  });

  describe('HrZoneDistribution 数据结构', () => {
    it('应包含 5 个区间字段', () => {
      const dist: HrZoneDistribution = {
        z1: 60,  // 热身
        z2: 180, // 燃脂
        z3: 600, // 有氧
        z4: 300, // 无氧
        z5: 60   // 最大
      };
      expect(dist.z1 >= 0).assertTrue();
      expect(dist.z2 >= 0).assertTrue();
      expect(dist.z3 >= 0).assertTrue();
      expect(dist.z4 >= 0).assertTrue();
      expect(dist.z5 >= 0).assertTrue();
    });

    it('5 区间总和 > 0 (有效跑步)', () => {
      const dist: HrZoneDistribution = {
        z1: 60, z2: 180, z3: 600, z4: 300, z5: 60
      };
      const total = dist.z1 + dist.z2 + dist.z3 + dist.z4 + dist.z5;
      expect(total > 0).assertTrue();
    });
  });

  describe('SplitPace 数据结构', () => {
    it('每公里分段应包含 kmIndex 和 pace', () => {
      const split: SplitPace = { kmIndex: 1, pace: 355, distance: 1000, duration: 355 };
      expect(split.kmIndex).assertEqual(1);
      expect(split.pace).assertEqual(355);
    });
  });

  describe('RunStatus 枚举/类型', () => {
    it('状态值应为合法枚举', () => {
      const status: RunStatus = 'idle';
      expect(['idle', 'running', 'paused', 'done'].indexOf(status) >= 0).assertTrue();
    });
  });
});
