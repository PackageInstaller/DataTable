-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/TianShiNaNaEvent.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaEvent", package.seeall)

local TianShiNaNaEvent = _M
local _get = GameUtil.getUniqueTb()

TianShiNaNaEvent.LoadLevelFinish = _get()
TianShiNaNaEvent.DragScene = _get()
TianShiNaNaEvent.ExitLevel = _get()
TianShiNaNaEvent.OnFlowEnd = _get()
TianShiNaNaEvent.RoundUpdate = _get()
TianShiNaNaEvent.ResetScene = _get()
TianShiNaNaEvent.RoundFail = _get()
TianShiNaNaEvent.CheckMapCollapse = _get()
TianShiNaNaEvent.PlayerMove = _get()
TianShiNaNaEvent.StatuChange = _get()
TianShiNaNaEvent.WaitClickJumpRound = _get()
TianShiNaNaEvent.CubePointUpdate = _get()
TianShiNaNaEvent.OneClickClaimReward = _get()
TianShiNaNaEvent.DragMainScene = _get()
TianShiNaNaEvent.EnterLevelScene = _get()
TianShiNaNaEvent.EpisodeClick = _get()
TianShiNaNaEvent.EpisodeStarChange = _get()
TianShiNaNaEvent.EpisodeFinish = _get()
TianShiNaNaEvent.EnterMapAndInitDone = _get()
TianShiNaNaEvent.GuideClickNode = _get()
TianShiNaNaEvent.OnWaitDragEnd = _get()
TianShiNaNaEvent.OnGuideTrigger = _get()

return TianShiNaNaEvent
