-- chunkname: @modules/logic/versionactivity3_3/marsha/controller/MarshaEvent.lua

module("modules.logic.versionactivity3_3.marsha.controller.MarshaEvent", package.seeall)

local MarshaEvent = _M
local _get = GameUtil.getUniqueTb()

MarshaEvent.EpisodeFinished = _get()
MarshaEvent.OneClickClaimReward = _get()
MarshaEvent.GameStart = _get()
MarshaEvent.GamePause = _get()
MarshaEvent.GameResume = _get()
MarshaEvent.GameReset = _get()
MarshaEvent.GameEnd = _get()
MarshaEvent.GameRestart = _get()
MarshaEvent.ClickLevelItem = _get()
MarshaEvent.BallDead = _get()
MarshaEvent.ZTrigger = _get()

return MarshaEvent
