// 跑步追踪服务卡片 — 数据模型

const COLORS = {
  BG: '#FFFFFF',
  BG_SUB: '#F8F9FA',
  TEXT_1: '#1A1A1A',
  TEXT_2: '#6B7280',
  TEXT_3: '#9CA3AF',
  BORDER: '#E4E7EC',
  BRAND: '#E8453C',
  BRAND_LIGHT: '#FEF2F2',
  SUCCESS: '#22C55E',
  SUCCESS_LIGHT: '#F0FDF4'
}
const RADIUS_LG = 12
const RADIUS_SM = 8

// 卡片状态
export enum WidgetState {
  IDLE = 'idle',
  RUNNING = 'running',
  DONE = 'done'
}

// 卡片表单数据 — 所有卡片展示需要的字段
export interface WidgetFormData {
  state: WidgetState
  todayDistance: number      // 今日跑量 米
  currentDistance: number     // 当前跑步距离 米
  avgHr: number              // 平均心率 bpm
  currentHr: number          // 当前心率 bpm
  currentPace: number        // 当前配速 秒/公里
  avgPace: number            // 平均配速 秒/公里
  duration: number           // 用时 秒
  calories: number           // 消耗 kcal
  weeklyDistance: number      // 周累计距离 米
  weeklyGoal: number         // 周目标 公里
  restHr: number             // 静息心率 bpm
  date: string               // 日期字符串
  // 格式化字段（供卡片直接显示）
  formattedDistance: string
  formattedCurrentDistance: string
  formattedPace: string
  formattedAvgPace: string
  formattedDuration: string
  formattedWeeklyDistance: string
  weeklyProgress: number     // 0-1
}

// 格式化配速：秒/公里 → m'ss"
function formatPace(secondsPerKm: number): string {
  if (secondsPerKm <= 0 || !isFinite(secondsPerKm)) return "--'--\""
  const min = Math.floor(secondsPerKm / 60)
  const sec = Math.floor(secondsPerKm % 60)
  return `${min}'${sec.toString().padStart(2, '0')}"`
}

// 格式化时长：秒 → HH:MM:SS 或 MM:SS
function formatDuration(seconds: number): string {
  if (seconds < 0) return '00:00'
  const h = Math.floor(seconds / 3600)
  const m = Math.floor((seconds % 3600) / 60)
  const s = Math.floor(seconds % 60)
  if (h > 0) {
    return `${h.toString().padStart(2, '0')}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
  }
  return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
}

// 格式化距离：米 → X.X km
function formatDistance(meters: number): string {
  if (meters < 0) return '0.0'
  return (meters / 1000).toFixed(1)
}

// 构建完整表单数据（含格式化字段）
function buildFormData(base: Omit<WidgetFormData, 'formattedDistance' | 'formattedCurrentDistance' |
  'formattedPace' | 'formattedAvgPace' | 'formattedDuration' | 'formattedWeeklyDistance' |
  'weeklyProgress'>): WidgetFormData {
  return {
    ...base,
    formattedDistance: formatDistance(base.todayDistance),
    formattedCurrentDistance: formatDistance(base.currentDistance),
    formattedPace: formatPace(base.currentPace),
    formattedAvgPace: formatPace(base.avgPace),
    formattedDuration: formatDuration(base.duration),
    formattedWeeklyDistance: formatDistance(base.weeklyDistance),
    weeklyProgress: base.weeklyGoal > 0
      ? Math.min(base.weeklyDistance / (base.weeklyGoal * 1000), 1) : 0
  }
}

// 创建空闲态默认数据
export function createIdleFormData(): WidgetFormData {
  const now = new Date()
  return buildFormData({
    state: WidgetState.IDLE,
    todayDistance: 0,
    currentDistance: 0,
    avgHr: 0,
    currentHr: 0,
    currentPace: 0,
    avgPace: 0,
    duration: 0,
    calories: 0,
    weeklyDistance: 0,
    weeklyGoal: 30,
    restHr: 62,
    date: `${now.getMonth() + 1}月${now.getDate()}日`
  })
}

// 创建跑步中示例数据
export function createRunningFormData(): WidgetFormData {
  const now = new Date()
  return buildFormData({
    state: WidgetState.RUNNING,
    todayDistance: 3200,
    currentDistance: 3200,
    avgHr: 152,
    currentHr: 156,
    currentPace: 342,
    avgPace: 348,
    duration: 1092,
    calories: 198,
    weeklyDistance: 15200,
    weeklyGoal: 30,
    restHr: 62,
    date: `${now.getMonth() + 1}月${now.getDate()}日`
  })
}

// 创建已完成示例数据
export function createDoneFormData(): WidgetFormData {
  const now = new Date()
  return buildFormData({
    state: WidgetState.DONE,
    todayDistance: 5300,
    currentDistance: 5300,
    avgHr: 138,
    currentHr: 138,
    currentPace: 0,
    avgPace: 345,
    duration: 1840,
    calories: 328,
    weeklyDistance: 17300,
    weeklyGoal: 30,
    restHr: 62,
    date: `${now.getMonth() + 1}月${now.getDate()}日`
  })
}
