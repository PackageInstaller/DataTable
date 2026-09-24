-- chunkname: @modules/logic/fight/system/work/FightWorkClueDel391.lua

module("modules.logic.fight.system.work.FightWorkClueDel391", package.seeall)

local FightWorkClueDel391 = class("FightWorkClueDel391", FightEffectBase)

function FightWorkClueDel391:onStart()
	local cluePosition = self.actEffectData.cluePosition

	if cluePosition then
		local teamType = self.actEffectData.teamType

		teamType = teamType ~= 0 and teamType or FightEnum.TeamType.MySide

		FightController.instance:dispatchEvent(FightEvent.OnClueDel, cluePosition, teamType)
	end

	return self:onDone(true)
end

return FightWorkClueDel391
