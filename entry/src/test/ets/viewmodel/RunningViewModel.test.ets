// RunningViewModel.test.ets
// 单元测试：跑步状态管理 ViewModel
// 对应测试计划 ID: PC-01 ~ PC-08

import { describe, it, expect, beforeEach, afterEach } from '@ohos/hypium';
import { RunningViewModel, RunningState, RunRecord, HrZoneDistribution } from '../../../src/main/ets/viewmodel/RunningViewModel';

describe('RunningViewModel', () => {
  let viewModel: RunningViewModel;

  beforeEach(() => {
    viewModel = new RunningViewModel();
  });

  afterEach(() => {
    viewModel = null;
  });

  // ==================== PC-01 ====================
  describe('PC-01: start() 方法调用后 RunningState 切换为 running', () => {
    it('start() 后 state 应为 running', () => {
      // 初始状态应为 idle
      expect(viewModel.state).assertEqual(RunningState.IDLE);

      viewModel.start();

      // start 后状态变为 running
      expect(viewModel.state).assertEqual(RunningState.RUNNING);
    });

    it('start() 后计时器启动，elapsedSeconds 开始增长', (done: Function) => {
      viewModel.start();

      // 等待 1.1 秒后检查 elapsedSeconds > 0
      setTimeout(() => {
        expect(viewModel.elapsedSeconds > 0).assertTrue();
        done();
      }, 1100);
    });
  });

  // ==================== PC-02 ====================
  describe('PC-02: pause() 方法暂停后数据停止增长', () => {
    it('pause() 后 state 应为 paused', () => {
      viewModel.start();
      viewModel.pause();

      expect(viewModel.state).assertEqual(RunningState.PAUSED);
    });

    it('pause() 后 elapsedSeconds 冻结', (done: Function) => {
      viewModel.start();

      setTimeout(() => {
        const frozenTime = viewModel.elapsedSeconds;
        viewModel.pause();

        // 再等 1 秒，确认时间不再增长
        setTimeout(() => {
          expect(viewModel.elapsedSeconds).assertEqual(frozenTime);
          done();
        }, 1100);
      }, 1100);
    });
  });

  // ==================== PC-03 ====================
  describe('PC-03: resume() 恢复后数据继续增长', () => {
    it('resume() 后 state 恢复为 running', () => {
      viewModel.start();
      viewModel.pause();
      viewModel.resume();

      expect(viewModel.state).assertEqual(RunningState.RUNNING);
    });

    it('resume() 后 elapsedSeconds 从暂停点继续增长', (done: Function) => {
      viewModel.start();

      setTimeout(() => {
        viewModel.pause();
        const timeAtPause = viewModel.elapsedSeconds;

        setTimeout(() => {
          viewModel.resume();

          setTimeout(() => {
            expect(viewModel.elapsedSeconds > timeAtPause).assertTrue();
            done();
          }, 1100);
        }, 500);
      }, 1100);
    });
  });

  // ==================== PC-04 ====================
  describe('PC-04: stop() 结束后生成完整 RunRecord', () => {
    it('stop() 返回包含完整字段的 RunRecord', () => {
      viewModel.start();

      // 模拟跑 3 秒
      const record: RunRecord = viewModel.stop();

      expect(record).assertNotNull();
      expect(record.distance).assertLarger(0);
      expect(record.duration).assertLarger(0);
      expect(record.avgPace).assertLarger(0);
      expect(record.avgHr).assertLarger(0);
      expect(record.calories).assertLarger(0);
      expect(record.hrZoneDistribution).assertNotNull();
      expect(record.splits).assertNotNull();
    });

    it('stop() 后 state 变为 idle', () => {
      viewModel.start();
      viewModel.stop();

      expect(viewModel.state).assertEqual(RunningState.IDLE);
    });
  });

  // ==================== PC-05 ====================
  describe('PC-05: formatPace() 格式化配速显示', () => {
    it('输入 360 秒/km → 输出 "6:00"', () => {
      const result = viewModel.formatPace(360);
      expect(result).assertEqual('6:00');
    });

    it('输入 305 秒/km → 输出 "5:05"', () => {
      const result = viewModel.formatPace(305);
      expect(result).assertEqual('5:05');
    });

    it('输入 0 返回 "--:--"', () => {
      const result = viewModel.formatPace(0);
      expect(result).assertEqual('--:--');
    });
  });

  // ==================== PC-06 ====================
  describe('PC-06: formatDuration() 格式化时长', () => {
    it('输入 3661 秒 → 输出 "1:01:01"', () => {
      const result = viewModel.formatDuration(3661);
      expect(result).assertEqual('1:01:01');
    });

    it('输入 59 秒 → 输出 "0:00:59"', () => {
      const result = viewModel.formatDuration(59);
      expect(result).assertEqual('0:00:59');
    });

    it('输入 3600 秒 → 输出 "1:00:00"', () => {
      const result = viewModel.formatDuration(3600);
      expect(result).assertEqual('1:00:00');
    });
  });

  // ==================== PC-07 ====================
  describe('PC-07: formatDistance() 格式化距离', () => {
    it('输入 5230 米 → 输出 "5.23"', () => {
      const result = viewModel.formatDistance(5230);
      expect(result).assertEqual('5.23');
    });

    it('输入 1000 米 → 输出 "1.00"', () => {
      const result = viewModel.formatDistance(1000);
      expect(result).assertEqual('1.00');
    });

    it('输入 0 米 → 输出 "0.00"', () => {
      const result = viewModel.formatDistance(0);
      expect(result).assertEqual('0.00');
    });
  });

  // ==================== PC-08 ====================
  describe('PC-08: 心率模拟值在合理范围内', () => {
    it('跑步中模拟心率在 60~190 bpm 区间', (done: Function) => {
      viewModel.start();

      setTimeout(() => {
        const hr = viewModel.currentHr;
        expect(hr >= 60 && hr <= 190).assertTrue();
        done();
      }, 1500);
    });
  });
});
