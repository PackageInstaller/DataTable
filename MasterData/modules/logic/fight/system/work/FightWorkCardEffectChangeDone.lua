-- chunkname: @modules/logic/fight/system/work/FightWorkCardEffectChangeDone.lua

module("modules.logic.fight.system.work.FightWorkCardEffectChangeDone", package.seeall)

local FightWorkCardEffectChangeDone = class("FightWorkCardEffectChangeDone", BaseWork)

function FightWorkCardEffectChangeDone:ctor()
	return
end

function FightWorkCardEffectChangeDone:onStart()
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onCardMagicEffectChangeDone, self)
	FightController.instance:dispatchEvent(FightEvent.PlayCardMagicEffectChange)
end

function FightWorkCardEffectChangeDone:_onCardMagicEffectChangeDone()
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCardMagicEffectChangeDone, self)
	self:_onDone()
end

function FightWorkCardEffectChangeDone:_onDone()
	self:clearWork()
	self:onDone(true)
end

function FightWorkCardEffectChangeDone:clearWork()
	return
end

return FightWorkCardEffectChangeDone
