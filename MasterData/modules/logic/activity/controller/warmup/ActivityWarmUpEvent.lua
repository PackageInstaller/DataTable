-- chunkname: @modules/logic/activity/controller/warmup/ActivityWarmUpEvent.lua

module("modules.logic.activity.controller.warmup.ActivityWarmUpEvent", package.seeall)

local ActivityWarmUpEvent = {}

ActivityWarmUpEvent.GameTriggerNoHit = 101
ActivityWarmUpEvent.GameTriggerHit = 102
ActivityWarmUpEvent.GameNextRound = 110
ActivityWarmUpEvent.GameOverTimeOut = 201
ActivityWarmUpEvent.GameOverFinished = 202
ActivityWarmUpEvent.NotifyGameClear = 203
ActivityWarmUpEvent.NotifyGameCancel = 204
ActivityWarmUpEvent.PlayOrderFinish = 301
ActivityWarmUpEvent.PlayOrderCancel = 302
ActivityWarmUpEvent.ViewSwitchTab = 501
ActivityWarmUpEvent.InfoReceived = 502
ActivityWarmUpEvent.OnInfosReply = 503
ActivityWarmUpEvent.TaskListUpdated = 601
ActivityWarmUpEvent.TaskDayChanged = 602
ActivityWarmUpEvent.TaskListNeedClose = 603
ActivityWarmUpEvent.TaskListInit = 604

return ActivityWarmUpEvent
