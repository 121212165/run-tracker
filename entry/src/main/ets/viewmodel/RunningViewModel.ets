import { RunRecord, RunningState, RunStatus, generateId } from 'common/Index'

export { RunRecord, RunningState, RunStatus }
export { formatPace, formatDuration, formatDistance, formatDate, formatTime } from 'common/Index'

@Observed
export class RunningViewModel {
  @State runningState: RunningState = {
    status: RunStatus.IDLE,
    duration: 0,
    distance: 0,
    currentPace: 0,
    avgPace: 0,
    currentHr: 0,
    avgHr: 0,
    calories: 0,
    startTime: 0,
  }

  private timerId: number = -1

  start(): void {
    this.runningState.status = RunStatus.RUNNING
    this.runningState.startTime = Date.now()
    this.runningState.duration = 0
    this.runningState.distance = 0
    this.runningState.calories = 0
    this.runningState.currentHr = 72
    this.runningState.avgHr = 72
    this.startTimer()
  }

  pause(): void {
    this.runningState.status = RunStatus.PAUSED
    this.stopTimer()
  }

  resume(): void {
    this.runningState.status = RunStatus.RUNNING
    this.startTimer()
  }

  stop(): RunRecord {
    this.runningState.status = RunStatus.FINISHED
    this.stopTimer()
    return {
      id: generateId(),
      startTime: this.runningState.startTime,
      endTime: Date.now(),
      duration: this.runningState.duration,
      distance: this.runningState.distance,
      avgPace: this.runningState.avgPace,
      avgHr: this.runningState.avgHr,
      calories: this.runningState.calories,
    }
  }

  private startTimer(): void {
    this.timerId = setInterval(() => {
      this.tick()
    }, 1000)
  }

  private stopTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }

  private tick(): void {
    if (this.runningState.status !== RunStatus.RUNNING) return

    this.runningState.duration += 1

    // Simulated GPS: ~2.8 m/s (5'52"/km pace)
    const paceVariation = 2.5 + Math.random() * 1.0
    this.runningState.distance += Math.round(paceVariation)

    // Simulated heart rate
    const hrBase = 140 + Math.sin(this.runningState.duration / 60) * 20
    this.runningState.currentHr = Math.round(hrBase + (Math.random() - 0.5) * 10)
    this.runningState.avgHr = Math.round(
      (this.runningState.avgHr * (this.runningState.duration - 1) + this.runningState.currentHr) /
      this.runningState.duration
    )

    // Pace
    if (this.runningState.distance > 0) {
      this.runningState.avgPace = this.runningState.duration / (this.runningState.distance / 1000)
    }
    this.runningState.currentPace = this.runningState.avgPace + (Math.random() - 0.5) * 30

    // Calories
    this.runningState.calories = Math.round(this.runningState.distance / 1000 * 65)
  }
}
