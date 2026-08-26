-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/LengZhou6EnemyReleaseSkillStep.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.LengZhou6EnemyReleaseSkillStep", package.seeall)

local LengZhou6EnemyReleaseSkillStep = class("LengZhou6EnemyReleaseSkillStep", EliminateChessStepBase)

function LengZhou6EnemyReleaseSkillStep:onStart()
	local skill = self._data
	local enemy = LengZhou6GameModel.instance:getEnemy()

	if enemy == nil or skill == nil then
		self:onDone(true)

		return
	end

	local skillId = skill._id
	local skillEffect = skill:getEffect()[1]
	local skillConfigId = skill:getConfigId()

	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UseEnemySkill, skillId)
	enemy:useSkill(skillId)
	LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.EnemyUseSkill, skillConfigId)

	if skillEffect == LengZhou6Enum.SkillEffect.DealsDamage or skillEffect == LengZhou6Enum.SkillEffect.Heal then
		LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ShowEnemyEffect, skillEffect)
		TaskDispatcher.runDelay(self._onDone, self, LengZhou6Enum.EnemySkillTime)

		return
	else
		TaskDispatcher.runDelay(self._onDone, self, LengZhou6Enum.EnemySkillTime_2)
	end
end

return LengZhou6EnemyReleaseSkillStep
