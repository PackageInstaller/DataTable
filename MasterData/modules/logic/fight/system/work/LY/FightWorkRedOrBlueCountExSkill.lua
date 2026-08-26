-- chunkname: @modules/logic/fight/system/work/LY/FightWorkRedOrBlueCountExSkill.lua

module("modules.logic.fight.system.work.LY.FightWorkRedOrBlueCountExSkill", package.seeall)

local FightWorkRedOrBlueCountExSkill = class("FightWorkRedOrBlueCountExSkill", FightEffectBase)

function FightWorkRedOrBlueCountExSkill:onStart()
	local array = FightStrUtil.instance:getSplitToNumberCache(self.actEffectData.reserveStr, "#")

	if not array then
		return self:onDone(true)
	end

	FightController.instance:dispatchEvent(FightEvent.LY_TriggerCountSkill, array[1], array[2], tonumber(self.actEffectData.reserveId))

	return self:onDone(true)
end

function FightWorkRedOrBlueCountExSkill:clearWork()
	return
end

return FightWorkRedOrBlueCountExSkill
