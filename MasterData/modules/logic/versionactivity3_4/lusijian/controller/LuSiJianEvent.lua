-- chunkname: @modules/logic/versionactivity3_4/lusijian/controller/LuSiJianEvent.lua

module("modules.logic.versionactivity3_4.lusijian.controller.LuSiJianEvent", package.seeall)

local LuSiJianEvent = _M
local _get = GameUtil.getUniqueTb()

LuSiJianEvent.EpisodeFinished = _get()
LuSiJianEvent.OnBackToLevel = _get()
LuSiJianEvent.OneClickClaimReward = _get()
LuSiJianEvent.OnConnectGuideFinish = _get()
LuSiJianEvent.GameFinished = _get()
LuSiJianEvent.CompleteLine = _get()
LuSiJianEvent.CloseGameView = _get()

return LuSiJianEvent
