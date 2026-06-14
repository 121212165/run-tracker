# Reconstruction Plan

## Principle
GPS + time = distance + pace. The runner wants 3 numbers: how far, how fast, and the trend.

## What Gets CUT (Musk's Razor)

| Target | Reason |
|--------|--------|
| `watch/` entire module | v1 = phone only. Watch is P2. |
| `widget/` entire module | Service cards are P2. |
| `AnalysisPage.ets` | VO2max, fitness score, training load = complex analytics. Cut. |
| `ProfilePage.ets` | Settings page with no real backend. Cut. |
| `RecordDetailPage.ets` | Redundant with result page. Cut. |
| `common/.../HealthKitService.ets` | 100% TODO stubs. Dead code. Cut. |
| `common/.../DesignTokens.ets` | Merge essential values into a single `theme.ts` inline. |
| `WeekChart.ets` | Used only by AnalysisPage. Cut. |
| `TrendChart.ets` | Used only by AnalysisPage. Cut. |
| `RunListItem.ets` | Unused component (RecordsPage has its own inline). Cut. |
| `docs/test-plan.html` | Not source code. Cut. |

## What Gets REBUILT

### common/ — Single source of truth
- **`model/RunRecord.ets`**: One `RunRecord` interface (minimal: id, startTime, endTime, duration, distance, avgPace, avgHr, calories)
- **`utils/Format.ets`**: `formatPace`, `formatDuration`, `formatDistance` — ONE copy
- **`constants/Theme.ets`**: Minimal color + spacing constants (no class, just const object)
- Delete everything else in common/

### entry/ — 4 pages, 2 components, 1 ViewModel

**Pages:**
1. `Index.ets` — Home: greeting, "开始跑步" CTA, recent runs list (reads from StorageService)
2. `RunningPage.ets` — Timer + distance + pace + calories display, pause/stop buttons
3. `RunResultPage.ets` — Post-run summary with save button
4. `RecordsPage.ets` — Flat list of all saved runs

**Components:**
1. `RunStatCard.ets` — Reusable stat display (label/value/unit)
2. `BottomTabBar.ets` — 2-tab nav (首页 / 记录)

**ViewModel:**
- `RunningViewModel.ets` — Timer + simulated GPS tick, exports `RunRecord` on stop. No type redefinition. Imports from `common/`.

### Tests — Rewrite to match new API
- `RunningViewModel.test.ets` — Tests start/pause/resume/stop + format functions
- `FormatUtils.test.ets` — Tests for formatPace/formatDuration/formatDistance

## File Count: Before vs After

| Module | Before (files) | After (files) |
|--------|----------------|---------------|
| common/ | 6 source + 2 test | 3 source + 1 test |
| entry/ | 7 pages + 6 components + 1 VM + 1 ability + 2 test | 4 pages + 2 components + 1 VM + 1 ability + 1 test |
| watch/ | 6 pages + 2 components | **DELETED** |
| widget/ | 2 source + 1 test | **DELETED** |
| docs/ | 1 | **DELETED** |
| **Total source** | **~30** | **~13** |
