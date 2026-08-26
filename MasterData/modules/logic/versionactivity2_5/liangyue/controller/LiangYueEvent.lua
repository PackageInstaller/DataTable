-- chunkname: @modules/logic/versionactivity2_5/liangyue/controller/LiangYueEvent.lua

module("modules.logic.versionactivity2_5.liangyue.controller.LiangYueEvent", package.seeall)

local LiangYueEvent = _M
local _get = GameUtil.getUniqueTb()

LiangYueEvent.OnReceiveEpisodeInfo = _get()
LiangYueEvent.OnEpisodeInfoPush = _get()
LiangYueEvent.OnFinishEpisode = _get()
LiangYueEvent.OneClickClaimReward = _get()
LiangYueEvent.OnClickStoryItem = _get()
LiangYueEvent.OnDragIllustration = _get()
LiangYueEvent.OnAttributeMeetConditions = _get()
LiangYueEvent.OnEpisodeUnlock = _get()

return LiangYueEvent
