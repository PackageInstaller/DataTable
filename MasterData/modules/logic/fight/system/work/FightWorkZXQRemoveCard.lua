-- chunkname: @modules/logic/fight/system/work/FightWorkZXQRemoveCard.lua

module("modules.logic.fight.system.work.FightWorkZXQRemoveCard", package.seeall)

local FightWorkZXQRemoveCard = class("FightWorkZXQRemoveCard", FightEffectBase)

function FightWorkZXQRemoveCard:onStart()
	if self.actEffectData.teamType ~= FightEnum.TeamType.MySide then
		self:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	self:onDone(true)
end

function FightWorkZXQRemoveCard:clearWork()
	return
end

return FightWorkZXQRemoveCard
