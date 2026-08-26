-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/skill/EnemyGeneralSkill.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.skill.EnemyGeneralSkill", package.seeall)

local EnemyGeneralSkill = class("EnemyGeneralSkill", SkillBase)

function EnemyGeneralSkill:init(id, configId)
	EnemyGeneralSkill.super.init(self, id, configId)

	self._skillType = LengZhou6Enum.SkillType.enemyActive
end

function EnemyGeneralSkill:execute()
	local canUse = EnemyGeneralSkill.super.execute(self)

	if canUse then
		local effectType = self._effect[1]
		local func = LengZhou6EffectUtils.instance:getHandleFunc(effectType)

		if func ~= nil then
			local exValue = LengZhou6GameModel.instance:getSkillEffectUp(self._effect[1])

			func(self._effect, exValue)
		end
	end
end

function EnemyGeneralSkill:getSkillDesc()
	local config = self:getConfig()
	local desc = config.desc
	local effectType = self._effect[1]

	if effectType == LengZhou6Enum.SkillEffect.Shuffle then
		return desc
	end

	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, self:getTotalValue())
end

function EnemyGeneralSkill:getTotalValue()
	if self._totalValue == nil then
		self._totalValue = self:_getTotalValue()
	end

	return self._totalValue
end

function EnemyGeneralSkill:_getTotalValue()
	local effectType = self._effect[1]
	local value = self._effect[2] and tonumber(self._effect[2]) or 0
	local exValue = LengZhou6GameModel.instance:getSkillEffectUp(effectType)

	return value + exValue
end

return EnemyGeneralSkill
