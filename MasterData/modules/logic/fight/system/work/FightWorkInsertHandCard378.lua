-- chunkname: @modules/logic/fight/system/work/FightWorkInsertHandCard378.lua

module("modules.logic.fight.system.work.FightWorkInsertHandCard378", package.seeall)

local FightWorkInsertHandCard378 = class("FightWorkInsertHandCard378", FightEffectBase)

function FightWorkInsertHandCard378:onConstructor()
	self.SAFETIME = 3
end

function FightWorkInsertHandCard378:onStart()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.FightView)

	if not viewContainer then
		return self:onDone(true)
	end

	local handCardGo = viewContainer:getCacheUserData(FightViewContainerCacheKey.UserDataKey.HandCardGo)

	if not handCardGo or not handCardGo.activeSelf then
		return self:onDone(true)
	end

	FightDataHelper.tempMgr:onInsertHandCard(self.actEffectData.cardInfo)

	local insertIndex = self.actEffectData.effectNum

	FightController.instance:dispatchEvent(FightEvent.TriggerInsertHandCard, insertIndex)
	FightController.instance:registerCallback(FightEvent.TriggerInsertHandCardDone, self.onTriggerInsertHandCardDone, self)
end

function FightWorkInsertHandCard378:onTriggerInsertHandCardDone()
	return self:onDone(true)
end

function FightWorkInsertHandCard378:clearWork()
	FightController.instance:unregisterCallback(FightEvent.TriggerInsertHandCardDone, self.onTriggerInsertHandCardDone, self)
end

return FightWorkInsertHandCard378
