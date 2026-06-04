// WidgetModels.test.ets
// 单元测试：服务卡片数据模型
// 对应测试计划 ID: WD-01 ~ WD-04

import { describe, it, expect } from '@ohos/hypium';
import {
  WidgetState,
  buildFormData,
  createIdleFormData,
  createRunningFormData,
  createDoneFormData,
  WidgetFormData
} from '../../../src/main/ets/model/WidgetModels';

describe('WidgetModels', () => {

  // ==================== WD-01 ====================
  describe('WD-01: createIdleFormData() 生成空闲态数据', () => {
    it('state 应为 idle', () => {
      const data: WidgetFormData = createIdleFormData();
      expect(data.state).assertEqual(WidgetState.IDLE);
    });

    it('weekProgressPercent 应为 0', () => {
      const data: WidgetFormData = createIdleFormData();
      expect(data.weekProgressPercent).assertEqual(0);
    });

    it('格式化字段应正确生成', () => {
      const data: WidgetFormData = createIdleFormData();
      expect(data.formattedDistance).assertEqual('0.00');
      expect(data.formattedDuration).assertEqual('0:00:00');
      expect(data.formattedPace).assertEqual('--:--');
      expect(data.formattedHeartRate).assertEqual('--');
    });

    it('title 应为"今日跑步"', () => {
      const data: WidgetFormData = createIdleFormData();
      expect(data.title).assertEqual('今日跑步');
    });
  });

  // ==================== WD-02 ====================
  describe('WD-02: createRunningFormData() 生成跑步中数据', () => {
    it('state 应为 running', () => {
      const data: WidgetFormData = createRunningFormData();
      expect(data.state).assertEqual(WidgetState.RUNNING);
    });

    it('distance > 0', () => {
      const data: WidgetFormData = createRunningFormData();
      expect(parseFloat(data.formattedDistance) > 0).assertTrue();
    });

    it('heartRate 在正常范围', () => {
      const data: WidgetFormData = createRunningFormData();
      const hr = parseInt(data.formattedHeartRate);
      expect(hr >= 60 && hr <= 190).assertTrue();
    });

    it('title 应为"跑步中"', () => {
      const data: WidgetFormData = createRunningFormData();
      expect(data.title).assertEqual('跑步中');
    });

    it('formattedPace 不为 "--:--"', () => {
      const data: WidgetFormData = createRunningFormData();
      expect(data.formattedPace).assertNotEqual('--:--');
    });
  });

  // ==================== WD-03 ====================
  describe('WD-03: createDoneFormData() 生成完成态数据', () => {
    it('state 应为 done', () => {
      const data: WidgetFormData = createDoneFormData();
      expect(data.state).assertEqual(WidgetState.DONE);
    });

    it('weekProgressPercent > 0', () => {
      const data: WidgetFormData = createDoneFormData();
      expect(data.weekProgressPercent > 0).assertTrue();
    });

    it('所有摘要字段非空', () => {
      const data: WidgetFormData = createDoneFormData();
      expect(data.formattedDistance.length > 0).assertTrue();
      expect(data.formattedDuration.length > 0).assertTrue();
      expect(data.formattedPace.length > 0).assertTrue();
      expect(data.formattedHeartRate.length > 0).assertTrue();
    });

    it('title 含"已完成"', () => {
      const data: WidgetFormData = createDoneFormData();
      expect(data.title.indexOf('完成') >= 0).assertTrue();
    });
  });

  // ==================== WD-04 ====================
  describe('WD-04: buildFormData() 自动计算周进度百分比', () => {
    it('weeklyDistance=0, weeklyGoal=50 → 0%', () => {
      const data: WidgetFormData = buildFormData(WidgetState.IDLE, 0, 0, 0, 0, 0, 50);
      expect(data.weekProgressPercent).assertEqual(0);
    });

    it('weeklyDistance=25, weeklyGoal=50 → 50%', () => {
      const data: WidgetFormData = buildFormData(WidgetState.IDLE, 0, 0, 0, 0, 25, 50);
      expect(data.weekProgressPercent).assertEqual(50);
    });

    it('weeklyDistance=60, weeklyGoal=50 → 100% (clamp)', () => {
      const data: WidgetFormData = buildFormData(WidgetState.IDLE, 0, 0, 0, 0, 60, 50);
      // 超过目标应 clamp 到 100
      expect(data.weekProgressPercent <= 100).assertTrue();
    });

    it('goal=0 时 percent=0 (避免除零)', () => {
      const data: WidgetFormData = buildFormData(WidgetState.IDLE, 0, 0, 0, 0, 10, 0);
      expect(data.weekProgressPercent).assertEqual(0);
    });
  });
});
