-- chunkname: @modules/logic/fight/system/work/FightWorkDeviceSkillIndex373.lua

module("modules.logic.fight.system.work.FightWorkDeviceSkillIndex373", package.seeall)

local FightWorkDeviceSkillIndex373 = class("FightWorkDeviceSkillIndex373", FightEffectBase)

function FightWorkDeviceSkillIndex373:onStart()
	FightController.instance:dispatchEvent(FightEvent.RefreshDeviceArea)

	return self:onDone(true)
end

return FightWorkDeviceSkillIndex373
