-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/skill/GeneralSkill.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.skill.GeneralSkill", package.seeall)

local GeneralSkill = class("GeneralSkill", SkillBase)

function GeneralSkill:init(id, configId)
	GeneralSkill.super.init(self, id, configId)

	self._skillType = LengZhou6Enum.SkillType.passive
end

function GeneralSkill:execute()
	local canUse = GeneralSkill.super.execute(self)

	if canUse and self._triggerPoint == LengZhou6GameModel.instance:getCurGameStep() then
		local effectType = self._effect[1]
		local func = LengZhou6EffectUtils.instance:getHandleFunc(effectType)

		if func ~= nil then
			func(self._effect)
		end
	end
end

return GeneralSkill
