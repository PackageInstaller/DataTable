-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/skill/PlayerActiveSkill.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.skill.PlayerActiveSkill", package.seeall)

local PlayerActiveSkill = class("PlayerActiveSkill", SkillBase)

function PlayerActiveSkill:init(id, configId)
	PlayerActiveSkill.super.init(self, id, configId)

	self._skillParams = {}
	self._skillParamCount = 0

	if self._effect[1] == "EliminationCross" or self._effect[1] == "EliminationRange" then
		self._skillParamCount = 2
	end

	self._skillType = LengZhou6Enum.SkillType.active
end

function PlayerActiveSkill:setParams(x, y)
	table.insert(self._skillParams, x)
	table.insert(self._skillParams, y)
end

function PlayerActiveSkill:clearParams()
	tabletool.clear(self._skillParams)
end

function PlayerActiveSkill:paramIsFull()
	return #self._skillParams == self._skillParamCount
end

function PlayerActiveSkill:execute()
	local canUse = PlayerActiveSkill.super.execute(self)

	if canUse and self:paramIsFull() then
		local effectType = self._effect[1]
		local func = LengZhou6EffectUtils.instance:getHandleFunc(effectType)

		if func ~= nil then
			if #self._skillParams ~= 0 then
				func(self._skillParams[1], self._skillParams[2])
			else
				func(self._effect)
			end

			self:clearParams()
			LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdatePlayerSkill)
			LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.FinishReleaseSkill)
			LengZhou6StatHelper.instance:addUseSkillInfo(self:getConfigId())
		end
	end
end

return PlayerActiveSkill
