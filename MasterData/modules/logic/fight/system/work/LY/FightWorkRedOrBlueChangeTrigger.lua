-- chunkname: @modules/logic/fight/system/work/LY/FightWorkRedOrBlueChangeTrigger.lua

module("modules.logic.fight.system.work.LY.FightWorkRedOrBlueChangeTrigger", package.seeall)

local FightWorkRedOrBlueChangeTrigger = class("FightWorkRedOrBlueChangeTrigger", FightEffectBase)

function FightWorkRedOrBlueChangeTrigger:onStart()
	FightDataHelper.LYDataMgr:refreshShowAreaSize()
	self:onDone(true)
end

return FightWorkRedOrBlueChangeTrigger
