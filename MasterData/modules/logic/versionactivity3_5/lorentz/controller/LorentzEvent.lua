-- chunkname: @modules/logic/versionactivity3_5/lorentz/controller/LorentzEvent.lua

module("modules.logic.versionactivity3_5.lorentz.controller.LorentzEvent", package.seeall)

local LorentzEvent = _M
local _get = GameUtil.getUniqueTb()

LorentzEvent.EpisodeFinished = _get()
LorentzEvent.OnBackToLevel = _get()
LorentzEvent.OneClickClaimReward = _get()
LorentzEvent.OnDragBeginPuzzle = _get()
LorentzEvent.OnGuideFinishGame = _get()
LorentzEvent.FinishGame = _get()
LorentzEvent.ToNextLevel = _get()
LorentzEvent.SpLevelStep2 = _get()
LorentzEvent.SpLevelStep3 = _get()

return LorentzEvent
