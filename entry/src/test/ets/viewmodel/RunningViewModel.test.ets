import { describe, it, expect, beforeEach, afterEach } from '@ohos/hypium'
import { RunningViewModel, RunStatus } from '../../../src/main/ets/viewmodel/RunningViewModel'

describe('RunningViewModel', () => {
  let vm: RunningViewModel

  beforeEach(() => {
    vm = new RunningViewModel()
  })

  afterEach(() => {
    vm = null
  })

  describe('start()', () => {
    it('状态变为 running', () => {
      expect(vm.runningState.status).assertEqual(RunStatus.IDLE)
      vm.start()
      expect(vm.runningState.status).assertEqual(RunStatus.RUNNING)
    })

    it('计时器启动，duration 开始增长', (done: Function) => {
      vm.start()
      setTimeout(() => {
        expect(vm.runningState.duration > 0).assertTrue()
        done()
      }, 1100)
    })
  })

  describe('pause()', () => {
    it('状态变为 paused', () => {
      vm.start()
      vm.pause()
      expect(vm.runningState.status).assertEqual(RunStatus.PAUSED)
    })

    it('暂停后 duration 冻结', (done: Function) => {
      vm.start()
      setTimeout(() => {
        const frozen = vm.runningState.duration
        vm.pause()
        setTimeout(() => {
          expect(vm.runningState.duration).assertEqual(frozen)
          done()
        }, 1100)
      }, 1100)
    })
  })

  describe('resume()', () => {
    it('状态恢复为 running', () => {
      vm.start()
      vm.pause()
      vm.resume()
      expect(vm.runningState.status).assertEqual(RunStatus.RUNNING)
    })
  })

  describe('stop()', () => {
    it('返回完整 RunRecord', () => {
      vm.start()
      const record = vm.stop()
      expect(record).assertNotNull()
      expect(record.distance).assertLarger(0)
      expect(record.duration).assertLarger(0)
      expect(record.avgPace).assertLarger(0)
      expect(record.avgHr).assertLarger(0)
      expect(record.calories).assertLarger(0)
    })

    it('状态变为 finished', () => {
      vm.start()
      vm.stop()
      expect(vm.runningState.status).assertEqual(RunStatus.FINISHED)
    })
  })

  describe('心率模拟', () => {
    it('跑步中模拟心率在 60~200 bpm', (done: Function) => {
      vm.start()
      setTimeout(() => {
        const hr = vm.runningState.currentHr
        expect(hr >= 60 && hr <= 200).assertTrue()
        done()
      }, 1500)
    })
  })
})
