-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffRedOrBlueCountBuff.lua

module("modules.logic.fight.entity.comp.buff.FightBuffRedOrBlueCountBuff", package.seeall)

local FightBuffRedOrBlueCountBuff = class("FightBuffRedOrBlueCountBuff")

function FightBuffRedOrBlueCountBuff:ctor()
	return
end

function FightBuffRedOrBlueCountBuff:onBuffStart(entity, buffMo)
	self.entityMo = entity:getMO()
	self.side = self.entityMo.side

	if self.side == FightEnum.EntitySide.MySide then
		FightDataHelper.LYDataMgr:setLYCountBuff(buffMo)
	end
end

function FightBuffRedOrBlueCountBuff:clear()
	if self.side == FightEnum.EntitySide.MySide then
		FightDataHelper.LYDataMgr:setLYCountBuff(nil)
	end
end

function FightBuffRedOrBlueCountBuff:onBuffEnd()
	self:clear()
end

function FightBuffRedOrBlueCountBuff:dispose()
	self:clear()
end

return FightBuffRedOrBlueCountBuff
