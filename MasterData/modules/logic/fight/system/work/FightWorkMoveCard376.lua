-- chunkname: @modules/logic/fight/system/work/FightWorkMoveCard376.lua

module("modules.logic.fight.system.work.FightWorkMoveCard376", package.seeall)

local FightWorkMoveCard376 = class("FightWorkMoveCard376", FightEffectBase)

function FightWorkMoveCard376:onConstructor()
	self.SAFETIME = 3
end

function FightWorkMoveCard376:onStart()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.FightView)

	if not viewContainer then
		return self:onDone(true)
	end

	local handCardGo = viewContainer:getCacheUserData(FightViewContainerCacheKey.UserDataKey.HandCardGo)

	if not handCardGo or not handCardGo.activeSelf then
		return self:onDone(true)
	end

	local startIndex = self.actEffectData.effectNum
	local endIndex = self.actEffectData.effectNum1

	FightController.instance:dispatchEvent(FightEvent.TriggerMoveHandCard, startIndex, endIndex)
	FightController.instance:registerCallback(FightEvent.TriggerMoveHandCardDone, self.onTriggerMoveHandCardDone, self)
end

function FightWorkMoveCard376:onTriggerMoveHandCardDone()
	return self:onDone(true)
end

function FightWorkMoveCard376:clearWork()
	FightController.instance:unregisterCallback(FightEvent.TriggerMoveHandCardDone, self.onTriggerMoveHandCardDone, self)
end

return FightWorkMoveCard376
