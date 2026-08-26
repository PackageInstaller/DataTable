-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffRedOrBlueChangeTriggerBuff.lua

module("modules.logic.fight.entity.comp.buff.FightBuffRedOrBlueChangeTriggerBuff", package.seeall)

local FightBuffRedOrBlueChangeTriggerBuff = class("FightBuffRedOrBlueChangeTriggerBuff")

function FightBuffRedOrBlueChangeTriggerBuff:ctor()
	return
end

function FightBuffRedOrBlueChangeTriggerBuff:onBuffStart(entity, buffMo)
	FightDataHelper.LYDataMgr:setLYChangeTriggerBuff(buffMo)
end

function FightBuffRedOrBlueChangeTriggerBuff:clear()
	FightDataHelper.LYDataMgr:setLYChangeTriggerBuff(nil)
end

function FightBuffRedOrBlueChangeTriggerBuff:onBuffEnd()
	self:clear()
end

function FightBuffRedOrBlueChangeTriggerBuff:dispose()
	self:clear()
end

return FightBuffRedOrBlueChangeTriggerBuff
