-- chunkname: @modules/logic/fight/system/work/FightWorkBFSGUseCard.lua

module("modules.logic.fight.system.work.FightWorkBFSGUseCard", package.seeall)

local FightWorkBFSGUseCard = class("FightWorkBFSGUseCard", FightEffectBase)

function FightWorkBFSGUseCard:onStart()
	local version = FightModel.instance:getVersion()

	if version >= 1 and self.actEffectData.teamType ~= FightEnum.TeamType.MySide then
		self:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	self:onDone(true)
end

function FightWorkBFSGUseCard:_delayDone()
	self:onDone(true)
end

function FightWorkBFSGUseCard:clearWork()
	return
end

return FightWorkBFSGUseCard
