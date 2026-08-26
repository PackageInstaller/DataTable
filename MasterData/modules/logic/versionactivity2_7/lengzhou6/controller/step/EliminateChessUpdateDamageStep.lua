-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/EliminateChessUpdateDamageStep.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessUpdateDamageStep", package.seeall)

local EliminateChessUpdateDamageStep = class("EliminateChessUpdateDamageStep", EliminateChessStepBase)

function EliminateChessUpdateDamageStep:onStart()
	local totalPlayerDamage = self._data.damage
	local totalPlayerHp = self._data.hp

	self._isRound = self._data.isRound

	local enemyEntity = LengZhou6GameModel.instance:getEnemy()

	enemyEntity:changeHp(-totalPlayerDamage)

	local playerEntity = LengZhou6GameModel.instance:getPlayer()

	playerEntity:changeHp(totalPlayerHp)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdateEliminateDamage)

	local asset = LengZhou6EliminateController.instance:dispatchShowAssess()

	LengZhou6EliminateController.instance:resetCurEliminateCount()

	local time = 0

	if asset ~= nil then
		time = math.max(time, EliminateEnum_2_7.AssessShowTime)
	end

	local damage, _ = LengZhou6GameModel.instance:getTotalPlayerSettle()

	if damage > 0 then
		time = math.max(time, EliminateEnum_2_7.UpdateDamageStepTime)
	end

	if time == 0 then
		self:_onDone()
	else
		TaskDispatcher.runDelay(self._onDone, self, time)
	end
end

function EliminateChessUpdateDamageStep:_onDone()
	LengZhou6GameController.instance:_updateRoundAndCD(self._isRound)
	EliminateChessUpdateDamageStep.super._onDone(self)
end

return EliminateChessUpdateDamageStep
