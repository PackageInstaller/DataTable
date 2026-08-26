-- chunkname: @modules/logic/fight/system/work/FightWorkDeviceStop383.lua

module("modules.logic.fight.system.work.FightWorkDeviceStop383", package.seeall)

local FightWorkDeviceStop383 = class("FightWorkDeviceStop383", FightEffectBase)

function FightWorkDeviceStop383:onStart()
	local targetId = self.actEffectData.targetId
	local skillId = self.actEffectData.effectNum

	if skillId ~= 0 then
		FightController.instance:dispatchEvent(FightEvent.OnDevice_SkillStopStatusChange, targetId, skillId)
	else
		FightController.instance:dispatchEvent(FightEvent.OnDevice_RestartDeviceChange, targetId)
	end

	return self:onDone(true)
end

return FightWorkDeviceStop383
