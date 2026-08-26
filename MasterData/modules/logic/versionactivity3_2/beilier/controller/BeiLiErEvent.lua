-- chunkname: @modules/logic/versionactivity3_2/beilier/controller/BeiLiErEvent.lua

module("modules.logic.versionactivity3_2.beilier.controller.BeiLiErEvent", package.seeall)

local BeiLiErEvent = _M
local _get = GameUtil.getUniqueTb()

BeiLiErEvent.EpisodeFinished = _get()
BeiLiErEvent.OnBackToLevel = _get()
BeiLiErEvent.OneClickClaimReward = _get()
BeiLiErEvent.OnDragBeginPuzzle = _get()
BeiLiErEvent.OnGuideFinishGame = _get()
BeiLiErEvent.FinishGame = _get()
BeiLiErEvent.ToNextLevel = _get()
BeiLiErEvent.SpLevelStep2 = _get()
BeiLiErEvent.SpLevelStep3 = _get()

return BeiLiErEvent
