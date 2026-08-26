-- chunkname: @modules/logic/fight/entity/effect/FightBuffDianJiShiEffect.lua

module("modules.logic.fight.entity.effect.FightBuffDianJiShiEffect", package.seeall)

local FightBuffDianJiShiEffect = class("FightBuffDianJiShiEffect", FightBaseClass)

function FightBuffDianJiShiEffect:onConstructor(entity, entityData, dianJiShiConfig)
	self.entity = entity
	self.entityId = entity.id
	self.entityData = entityData
	self.dianJiShiConfig = dianJiShiConfig

	self:com_registMsg(FightMsgId.OnAddBuff, self.onAddBuff)
end

function FightBuffDianJiShiEffect:onAddBuff(buffData)
	if buffData.entityId ~= self.entityId then
		return
	end

	local buffConfig = lua_skill_buff.configDict[buffData.buffId]

	if not buffConfig then
		return
	end

	local dianJiShiConfig = self.dianJiShiConfig[buffConfig.typeId]

	if not dianJiShiConfig then
		return
	end

	local hasBigger = FightMsgMgr.sendMsg(FightMsgId.GetDianJiShiBiggerPriorityBuffEffect, dianJiShiConfig.priority)

	if hasBigger then
		return
	end

	self:newClass(FightBuffDianJiShiEffectItem, self.entity, buffData, dianJiShiConfig)
end

return FightBuffDianJiShiEffect
