-- chunkname: @modules/logic/fight/system/work/FightWorkClueAdd390.lua

module("modules.logic.fight.system.work.FightWorkClueAdd390", package.seeall)

local FightWorkClueAdd390 = class("FightWorkClueAdd390", FightEffectBase)

function FightWorkClueAdd390:onStart()
	local cluePosition = self.actEffectData.cluePosition

	if cluePosition then
		local teamType = self.actEffectData.teamType

		teamType = teamType ~= 0 and teamType or FightEnum.TeamType.MySide

		FightController.instance:dispatchEvent(FightEvent.OnClueAdd, cluePosition, teamType)
	end

	return self:onDone(true)
end

return FightWorkClueAdd390
