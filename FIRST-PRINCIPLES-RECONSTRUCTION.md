# First-Principles Reconstruction: run-tracker

> Applied Elon Musk's first-principles thinking: break to fundamental truths, rebuild from zero.

## Core Problem

Runners want to record their runs and track progress over time.

## First Principles Breakdown

1. GPS + time = distance + pace. The phone already has GPS.
2. The runner wants 3 numbers: how far, how fast, and the trend.

## Essential Features

| Priority | Feature |
|----------|---------|
| P0 | Start/stop run with GPS tracking |
| P0 | Display distance, time, pace in real-time |
| P0 | Save run to history |
| P1 | Run history list with stats |

## Reconstruction Blueprint

One activity with GPS listener + timer + database insert. One history screen with a list.

## Musk\'s Razor

Cut social features, cut complex analytics, cut cloud sync for v1.
