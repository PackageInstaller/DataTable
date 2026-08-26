-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/EliminateChessChangeStateStep.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessChangeStateStep", package.seeall)

local EliminateChessChangeStateStep = class("EliminateChessChangeStateStep", EliminateChessStepBase)

function EliminateChessChangeStateStep:onStart()
	local x = self._data.x
	local y = self._data.y
	local fromState = self._data.fromState
	local chess = LengZhou6EliminateChessItemController.instance:getChessItem(x, y)

	if chess == nil then
		logError("步骤 ChangeState 棋子：" .. x, y .. "不存在")
		self:onDone(true)

		return
	end

	chess:changeState(fromState, x, y)
	self:onDone(true)
end

return EliminateChessChangeStateStep
