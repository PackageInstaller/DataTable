-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/observerbox/define/ObserverBoxEvent.lua

module("modules.logic.versionactivity3_4.laplaceforum.observerbox.define.ObserverBoxEvent", package.seeall)

local ObserverBoxEvent = _M

ObserverBoxEvent.RewardInfoChanged = GameUtil.getUniqueTb()
ObserverBoxEvent.RewardBonusGet = GameUtil.getUniqueTb()
ObserverBoxEvent.RewardBonusGetFinished = GameUtil.getUniqueTb()

return ObserverBoxEvent
