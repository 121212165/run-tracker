// 跑步状态管理 ViewModel

// 设计 Token 常量
const DesignTokens = {
  BG: '#FFFFFF',
  BG_SUB: '#F8F9FA',
  TEXT_PRIMARY: '#1A1A1A',
  TEXT_SECONDARY: '#6B7280',
  TEXT_TERTIARY: '#9CA3AF',
  BORDER: '#E4E7EC',
  BRAND: '#E8453C',
  BRAND_LIGHT: '#FEF2F2',
  SUCCESS: '#22C55E',
  SUCCESS_LIGHT: '#F0FDF4',
  RADIUS_LG: 12,
  RADIUS_SM: 8,
  SPACE_4: 4,
  SPACE_8: 8,
  SPACE_16: 16,
  SPACE_24: 24,
  SPACE_32: 32,
  SPACE_48: 48,
  FONT_TITLE: 24,
  FONT_BODY: 14,
  FONT_CAPTION: 12,
  FONT_WEIGHT_BOLD: 700,
  FONT_WEIGHT_REGULAR: 400,
  HR_ZONE_1: '#22C55E',
  HR_ZONE_2: '#84CC16',
  HR_ZONE_3: '#EAB308',
  HR_ZONE_4: '#F97316',
  HR_ZONE_5: '#E8453C',
}

// 心率区间分布
export interface HrZoneDistribution {
  zone1: number
  zone2: number
  zone3: number
  zone4: number
  zone5: number
}

// 分段配速
export interface SplitPace {
  distance: number
  duration: number
  avgPace: number
  avgHr: number
}

// 跑步状态枚举
export enum RunStatus {
  IDLE = 'idle',
  RUNNING = 'running',
  PAUSED = 'paused',
  FINISHED = 'finished'
}

// 跑步中实时状态
export interface RunningState {
  status: RunStatus
  duration: number
  distance: number
  currentPace: number
  avgPace: number
  currentHr: number
  avgHr: number
  calories: number
  hrZone: number
  hrZones: HrZoneDistribution
  startTime: number
}

// 跑步记录
export interface RunRecord {
  id: string
  startTime: number
  endTime: number
  duration: number
  distance: number
  avgPace: number
  avgHeartRate: number
  maxHeartRate: number
  calories: number
  hrZones: HrZoneDistribution
  splits: SplitPace[]
  sportType: string
}

// 格式化配速：秒/公里 → m'ss"
export function formatPace(secondsPerKm: number): string {
  if (secondsPerKm <= 0 || !isFinite(secondsPerKm)) return "--'--\""
  const min = Math.floor(secondsPerKm / 60)
  const sec = Math.floor(secondsPerKm % 60)
  return `${min}'${sec.toString().padStart(2, '0')}"`
}

// 格式化时长：秒 → HH:MM:SS
export function formatDuration(seconds: number): string {
  if (seconds < 0) return '00:00:00'
  const h = Math.floor(seconds / 3600)
  const m = Math.floor((seconds % 3600) / 60)
  const s = Math.floor(seconds % 60)
  return `${h.toString().padStart(2, '0')}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
}

// 格式化距离：米 → X.X km
export function formatDistance(meters: number): string {
  if (meters < 0) return '0.0'
  return (meters / 1000).toFixed(1)
}

// 格式化日期：时间戳 → M月D日
export function formatDate(timestamp: number): string {
  const date = new Date(timestamp)
  return `${date.getMonth() + 1}月${date.getDate()}日`
}

// 格式化时间：时间戳 → HH:MM
export function formatTime(timestamp: number): string {
  const date = new Date(timestamp)
  return `${date.getHours().toString().padStart(2, '0')}:${date.getMinutes().toString().padStart(2, '0')}`
}

// 导出设计 Token
export { DesignTokens }

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
    hrZone: 1,
    hrZones: { zone1: 0, zone2: 0, zone3: 0, zone4: 0, zone5: 0 },
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
    this.runningState.hrZones = { zone1: 0, zone2: 0, zone3: 0, zone4: 0, zone5: 0 }
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
    return this.toRunRecord()
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

    // 模拟距离增长（约 170m/min = 2.83m/s，对应配速约 5'52"/km）
    const paceVariation = 2.5 + Math.random() * 1.0
    this.runningState.distance += Math.round(paceVariation)

    // 模拟心率变化
    const hrBase = 140 + Math.sin(this.runningState.duration / 60) * 20
    this.runningState.currentHr = Math.round(hrBase + (Math.random() - 0.5) * 10)
    this.runningState.avgHr = Math.round(
      (this.runningState.avgHr * (this.runningState.duration - 1) + this.runningState.currentHr) /
      this.runningState.duration
    )

    // 配速
    if (this.runningState.distance > 0) {
      this.runningState.avgPace = (this.runningState.duration / (this.runningState.distance / 1000))
    }
    this.runningState.currentPace = this.runningState.avgPace + (Math.random() - 0.5) * 30

    // 卡路里（简易估算）
    this.runningState.calories = Math.round(this.runningState.distance / 1000 * 65)

    // 心率区间
    const hr = this.runningState.currentHr
    if (hr < 120) this.runningState.hrZone = 1
    else if (hr < 140) this.runningState.hrZone = 2
    else if (hr < 160) this.runningState.hrZone = 3
    else if (hr < 175) this.runningState.hrZone = 4
    else this.runningState.hrZone = 5

    // 心率区间分布累加
    const zone = this.runningState.hrZone
    if (zone === 1) this.runningState.hrZones.zone1 += 1
    else if (zone === 2) this.runningState.hrZones.zone2 += 1
    else if (zone === 3) this.runningState.hrZones.zone3 += 1
    else if (zone === 4) this.runningState.hrZones.zone4 += 1
    else this.runningState.hrZones.zone5 += 1
  }

  private toRunRecord(): RunRecord {
    return {
      id: Date.now().toString(36) + Math.random().toString(36).substring(2, 8),
      startTime: this.runningState.startTime,
      endTime: Date.now(),
      duration: this.runningState.duration,
      distance: this.runningState.distance,
      avgPace: this.runningState.avgPace,
      avgHeartRate: this.runningState.avgHr,
      maxHeartRate: this.runningState.currentHr,
      calories: this.runningState.calories,
      hrZones: { ...this.runningState.hrZones },
      splits: this.generateSplits(),
      sportType: 'outdoor_run',
    }
  }

  private generateSplits(): SplitPace[] {
    const totalKm = Math.floor(this.runningState.distance / 1000)
    const splits: SplitPace[] = []
    for (let i = 0; i < totalKm; i++) {
      const basePace = 340 + (Math.random() - 0.5) * 40  // ~5'40" ± 20"
      splits.push({
        distance: (i + 1) * 1000,
        duration: Math.round(basePace),
        avgPace: Math.round(basePace),
        avgHr: Math.round(140 + Math.random() * 30),
      })
    }
    return splits
  }
}
