-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/LengZhou6EnemyGenerateSkillStep.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.LengZhou6EnemyGenerateSkillStep", package.seeall)

local LengZhou6EnemyGenerateSkillStep = class("LengZhou6EnemyGenerateSkillStep", EliminateChessStepBase)

function LengZhou6EnemyGenerateSkillStep:onStart()
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdateEnemySkill)

	local enemy = LengZhou6GameModel.instance:getEnemy()
	local action = enemy:getAction()
	local residueCd = action:calCurResidueCd()
	local delayTime = 0
	local enemy = LengZhou6GameModel.instance:getEnemy()

	if enemy:havePoisonBuff() then
		delayTime = LengZhou6Enum.EnemyBuffEffectShowTime
	end

	LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.poisonSettlement)
	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.EnemySkillRound, residueCd)

	if delayTime ~= 0 then
		TaskDispatcher.runDelay(self._onDone, self, delayTime)
	else
		self:onDone(true)
	end
end

return LengZhou6EnemyGenerateSkillStep
