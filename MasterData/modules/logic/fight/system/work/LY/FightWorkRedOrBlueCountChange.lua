-- chunkname: @modules/logic/fight/system/work/LY/FightWorkRedOrBlueCountChange.lua

module("modules.logic.fight.system.work.LY.FightWorkRedOrBlueCountChange", package.seeall)

local FightWorkRedOrBlueCountChange = class("FightWorkRedOrBlueCountChange", FightEffectBase)

function FightWorkRedOrBlueCountChange:onStart()
	local buffMo = self.actEffectData.buff

	FightDataHelper.LYDataMgr:setLYCountBuff(buffMo)

	return self:onDone(true)
end

function FightWorkRedOrBlueCountChange:clearWork()
	return
end

return FightWorkRedOrBlueCountChange
