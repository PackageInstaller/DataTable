-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffSpecialCountCastBuff.lua

module("modules.logic.fight.entity.comp.buff.FightBuffSpecialCountCastBuff", package.seeall)

local FightBuffSpecialCountCastBuff = class("FightBuffSpecialCountCastBuff", FightBuffHandleClsBase)

function FightBuffSpecialCountCastBuff:onBuffStart(entity, buffMo)
	self.entityMo = entity:getMO()
	self.entity = entity
	self.buffId = buffMo.buffId
	self.buffCo = buffMo:getCO()
	self.buffTypeId = self.buffCo.typeId
	self.entityId = entity.id

	local spCoDict = lua_fight_sp_effect_wuerlixi.configDict[self.buffTypeId]

	if not spCoDict then
		logError(string.format("buffId : %s, buffTypeId 不存在 ： %s", self.buffId, self.buffTypeId))

		return
	end

	local spCo = spCoDict and spCoDict[self.entityMo.skin]

	if not spCo then
		return
	end

	self.spCo = spCo

	local hangPoint = self:getCurEffectPoint()

	self.effectWrap = entity.effect:addHangEffect(self.spCo.effect, hangPoint)

	FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, self.effectWrap)
	self.effectWrap:setLocalPos(0, 0, 0)
	self.entity.buff:addLoopBuff(self.effectWrap)

	self.preHangPoint = hangPoint

	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, self.onUpdateBuff, self)
end

function FightBuffSpecialCountCastBuff:onUpdateBuff(entityId, effectType, buffId, buffUid)
	if entityId ~= self.entityId then
		return
	end

	local curHangPoint = self:getCurEffectPoint()

	if curHangPoint == self.preHangPoint then
		return
	end

	self.preHangPoint = curHangPoint

	local hangPointGO = self.entity:getHangPoint(curHangPoint)

	self.effectWrap:setHangPointGO(hangPointGO)
	self.effectWrap:setLocalPos(0, 0, 0)
end

function FightBuffSpecialCountCastBuff:getCurEffectPoint()
	if self.entityMo:hasBuffFeature(FightEnum.BuffType_SpecialCountCastChannel) then
		return self.spCo.channelHangPoint
	else
		return self.spCo.hangPoint
	end
end

function FightBuffSpecialCountCastBuff:clear()
	if not self.effectWrap then
		return
	end

	self.entity.buff:removeLoopBuff(self.effectWrap)
	self.entity.effect:removeEffect(self.effectWrap)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entity.id, self.effectWrap)

	self.effectWrap = nil

	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, self.onUpdateBuff, self)
end

return FightBuffSpecialCountCastBuff
