// 工具函数

// 格式化配速：秒/公里 → m'ss"
export function formatPace(secondsPerKm: number): string {
  if (secondsPerKm <= 0 || !isFinite(secondsPerKm)) return "--'--\""
  const min = Math.floor(secondsPerKm / 60)
  const sec = Math.floor(secondsPerKm % 60)
  return `${min}'${sec.toString().padStart(2, '0')}"`
}

// 格式化时长：秒 → HH:MM:SS 或 MM:SS
export function formatDuration(seconds: number): string {
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

// 计算心率区间（Karvonen 公式）
export function calculateHrZone(hr: number, maxHr: number, restHr: number): number {
  if (hr <= restHr) return 1
  const reserve = maxHr - restHr
  const percent = (hr - restHr) / reserve
  if (percent < 0.5) return 1
  if (percent < 0.6) return 2
  if (percent < 0.7) return 3
  if (percent < 0.8) return 4
  return 5
}

// 估算最大心率（220 - 年龄）
export function estimateMaxHr(age: number): number {
  return 220 - age
}

// 生成唯一 ID
export function generateId(): string {
  return Date.now().toString(36) + Math.random().toString(36).substring(2, 8)
}

// 计算卡路里消耗（简易公式：体重×距离×1.036）
export function estimateCalories(weightKg: number, distanceKm: number): number {
  return Math.round(weightKg * distanceKm * 1.036)
}
