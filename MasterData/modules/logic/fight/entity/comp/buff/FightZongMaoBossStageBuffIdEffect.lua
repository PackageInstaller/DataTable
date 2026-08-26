-- chunkname: @modules/logic/fight/entity/comp/buff/FightZongMaoBossStageBuffIdEffect.lua

module("modules.logic.fight.entity.comp.buff.FightZongMaoBossStageBuffIdEffect", package.seeall)

local FightZongMaoBossStageBuffIdEffect = class("FightZongMaoBossStageBuffIdEffect", FightBaseClass)

function FightZongMaoBossStageBuffIdEffect:onConstructor(entity, entityData, zongMaoBossStageBuffIdEffectConfig)
	self.entity = entity
	self.entityData = entityData
	self.zongMaoBossStageBuffIdEffectConfig = zongMaoBossStageBuffIdEffectConfig
	self.effectDic = {}

	self:com_registMsg(FightMsgId.OnAddBuff, self.onAddBuff)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish)
end

function FightZongMaoBossStageBuffIdEffect:onAddBuff(buffData)
	local config = self.zongMaoBossStageBuffIdEffectConfig[buffData.buffId]

	if config then
		self:removeEffect()

		local paths = string.split(config.effects, "#")
		local hangPoints = string.split(config.hangpoints, "#")
		local scales = string.split(config.scales, "#")

		for i, path in ipairs(paths) do
			if not hangPoints[i] then
				local hangPoint = ModuleEnum.SpineHangPointRoot
				local effectWrap = self.entity.effect:addHangEffect(path, hangPoint)

				FightRenderOrderMgr.instance:onAddEffectWrap(self.entity.id, effectWrap)
				effectWrap:setLocalPos(0, 0, 0)

				local scaleArr = string.splitToNumber(scales[i], ",")

				effectWrap:setEffectScale(scaleArr[1] or 1, scaleArr[2] or 1, scaleArr[3] or 1)

				self.effectDic[effectWrap.uniqueId] = effectWrap
			end
		end
	end
end

function FightZongMaoBossStageBuffIdEffect:removeEffect()
	if self.effectDic then
		for _, effectWrap in pairs(self.effectDic) do
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entity.id, effectWrap)
			self.entity.effect:removeEffect(effectWrap)
		end

		self.effectDic = {}
	end
end

function FightZongMaoBossStageBuffIdEffect:_onSkillPlayStart(entity, skillId, fightStepData, timelineName)
	if entity and self._entity ~= entity and entity:getMO() and FightCardDataHelper.isBigSkill(skillId) then
		self._uniqueSkill = skillId

		self:hideSpecialEffects("UniqueSkill")
	end
end

function FightZongMaoBossStageBuffIdEffect:_onSkillPlayFinish(entity, skillId, fightStepData, timelineName)
	if self._uniqueSkill and skillId == self._uniqueSkill then
		self._uniqueSkill = nil

		self:showSpecialEffects("UniqueSkill")
	end
end

function FightZongMaoBossStageBuffIdEffect:showSpecialEffects(key)
	for _, effectWrap in pairs(self.effectDic) do
		effectWrap:setActive(true, key or self.__cname)
	end
end

function FightZongMaoBossStageBuffIdEffect:hideSpecialEffects(key)
	for _, effectWrap in pairs(self.effectDic) do
		effectWrap:setActive(false, key or self.__cname)
	end
end

function FightZongMaoBossStageBuffIdEffect:onDestructor()
	self:removeEffect()
end

return FightZongMaoBossStageBuffIdEffect
