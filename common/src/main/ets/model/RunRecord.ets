export interface RunRecord {
  id: string
  startTime: number
  endTime: number
  duration: number
  distance: number
  avgPace: number
  avgHr: number
  calories: number
}

export enum RunStatus {
  IDLE = 'idle',
  RUNNING = 'running',
  PAUSED = 'paused',
  FINISHED = 'finished'
}

export interface RunningState {
  status: RunStatus
  duration: number
  distance: number
  currentPace: number
  avgPace: number
  currentHr: number
  avgHr: number
  calories: number
  startTime: number
}
