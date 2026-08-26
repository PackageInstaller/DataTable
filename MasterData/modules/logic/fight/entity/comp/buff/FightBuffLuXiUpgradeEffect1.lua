-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffLuXiUpgradeEffect1.lua

module("modules.logic.fight.entity.comp.buff.FightBuffLuXiUpgradeEffect1", package.seeall)

local FightBuffLuXiUpgradeEffect1 = class("FightBuffLuXiUpgradeEffect1", FightBaseClass)

function FightBuffLuXiUpgradeEffect1:onConstructor(entity, entityData, luxiUpgradeEffectConfig)
	self.entity = entity
	self.entityData = entityData
	self.entityId = entityData.id
	self.configDict = luxiUpgradeEffectConfig
	self.buffDic = {}

	self:com_registFightEvent(FightEvent.AddEntityBuff, self.onAddEntityBuff)
	self:com_registFightEvent(FightEvent.RemoveEntityBuff, self.onRemoveEntityBuff)
	self:com_registFightEvent(FightEvent.SetBuffEffectVisible, self.onSetBuffEffectVisible)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, LuaEventSystem.High)
end

function FightBuffLuXiUpgradeEffect1:onAddEntityBuff(entityId, buffData)
	if entityId ~= self.entityId then
		return
	end

	local buffId = buffData.buffId
	local config = self.configDict[buffId]

	if not config then
		return
	end

	self:releaseEffect(buffId)

	local effectPath = config.effect
	local effectHangPoint = config.effectHangPoint
	local effectWrap = self.entity.effect:addHangEffect(effectPath, effectHangPoint)

	effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self.entity.id, effectWrap)

	self.buffDic[buffId] = effectWrap

	local audioId = config.audio

	if audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function FightBuffLuXiUpgradeEffect1:onRemoveEntityBuff(entityId, buffData)
	if entityId ~= self.entityId then
		return
	end

	local buffId = buffData.buffId

	if not self.configDict[buffId] then
		return
	end

	self:releaseEffect(buffId)
end

function FightBuffLuXiUpgradeEffect1:onSetBuffEffectVisible(entityId, state, sign)
	if entityId ~= self.entityId then
		return
	end

	for buffId, effectWrap in pairs(self.buffDic) do
		effectWrap:setActive(state, sign or "FightBuffLuXiUpgradeEffect1")
	end
end

function FightBuffLuXiUpgradeEffect1:_onSkillPlayStart(entity)
	self:onSetBuffEffectVisible(entity.id, false, "FightBuffLuXiUpgradeEffect1_PlaySkill")
end

function FightBuffLuXiUpgradeEffect1:_onSkillPlayFinish(entity)
	self:onSetBuffEffectVisible(entity.id, true, "FightBuffLuXiUpgradeEffect1_PlaySkill")
end

function FightBuffLuXiUpgradeEffect1:releaseEffect(buffId)
	local effectWrap = self.buffDic[buffId]

	if effectWrap then
		self.entity.effect:removeEffect(effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, effectWrap)
	end

	self.buffDic[buffId] = nil
end

function FightBuffLuXiUpgradeEffect1:releaseAllEffect()
	for buffId, effect in pairs(self.buffDic) do
		self:releaseEffect(buffId)
	end
end

function FightBuffLuXiUpgradeEffect1:onDestructor()
	self:releaseAllEffect()
end

return FightBuffLuXiUpgradeEffect1
