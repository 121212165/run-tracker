// 跑步记录数据模型

// 单次跑步记录
export interface RunRecord {
  id: string
  startTime: number       // 时间戳 ms
  endTime: number         // 时间戳 ms
  duration: number        // 秒
  distance: number        // 米
  avgPace: number         // 秒/公里
  avgHeartRate: number    // bpm
  maxHeartRate: number    // bpm
  calories: number        // kcal
  // 心率区间分布（秒）
  hrZones: HrZoneDistribution
  // 分段配速
  splits: SplitPace[]
  // GPS 轨迹点
  trackPoints: TrackPoint[]
  // 元数据
  source: DataSource
  sportType: SportType
}

// 心率区间分布
export interface HrZoneDistribution {
  zone1: number  // 热身 (50-60% HRmax)
  zone2: number  // 燃脂 (60-70%)
  zone3: number  // 有氧 (70-80%)
  zone4: number  // 无氧 (80-90%)
  zone5: number  // 最大 (90-100%)
}

// 分段配速（每公里）
export interface SplitPace {
  distance: number    // 累计距离 米
  duration: number    // 该段用时 秒
  avgPace: number     // 该段配速 秒/公里
  avgHr: number       // 该段平均心率
}

// GPS 轨迹点
export interface TrackPoint {
  latitude: number
  longitude: number
  altitude: number
  timestamp: number
  heartRate?: number
}

// 数据来源
export enum DataSource {
  PHONE_GPS = 'phone_gps',
  WATCH = 'watch',
  HEALTH_KIT = 'health_kit',
  MANUAL = 'manual'
}

// 运动类型
export enum SportType {
  OUTDOOR_RUN = 'outdoor_run',
  INDOOR_RUN = 'indoor_run',
  INTERVAL = 'interval',
  GOAL_RUN = 'goal_run'
}

// 跑步中实时状态
export interface RunningState {
  status: RunStatus
  duration: number        // 已用时间 秒
  distance: number        // 已跑距离 米
  currentPace: number     // 当前配速 秒/公里
  avgPace: number         // 平均配速
  currentHr: number       // 当前心率
  avgHr: number           // 平均心率
  calories: number        // 已消耗 kcal
  hrZone: number          // 当前心率区间 1-5
  hrZones: HrZoneDistribution  // 实时区间分布
  trackPoints: TrackPoint[]
  startTime: number
}

// 跑步状态
export enum RunStatus {
  IDLE = 'idle',
  RUNNING = 'running',
  PAUSED = 'paused',
  FINISHED = 'finished'
}

// 用户设置
export interface UserProfile {
  maxHeartRate: number    // 最大心率
  restHeartRate: number   // 静息心率
  weeklyGoal: number      // 周目标 公里
  weight: number          // 体重 kg
  dateOfBirth: string     // 出生日期
  connectedWatch: string  // 已连接手表 ID
  healthKitAuthorized: boolean
}

// 周统计
export interface WeekSummary {
  weekStart: string       // 周一开始日期
  totalDistance: number    // 总距离 米
  totalDuration: number    // 总时间 秒
  totalCalories: number
  runCount: number
  avgPace: number
  avgHr: number
  dailyDistances: number[]  // 7天每日距离
}

// 服务卡片状态
export enum WidgetState {
  IDLE = 'idle',
  RUNNING = 'running',
  DONE = 'done'
}

// 卡片数据
export interface WidgetData {
  state: WidgetState
  todayDistance: number   // 今日跑量 米
  avgHr: number          // 平均心率
  currentPace: number     // 当前配速
  duration: number        // 用时 秒
  calories: number
  weeklyProgress: number  // 周目标进度 0-1
  weeklyGoal: number      // 周目标 km
}
