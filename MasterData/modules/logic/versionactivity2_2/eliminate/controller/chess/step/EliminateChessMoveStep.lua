-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateChessMoveStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessMoveStep", package.seeall)

local EliminateChessMoveStep = class("EliminateChessMoveStep", EliminateChessStepBase)

function EliminateChessMoveStep:onStart()
	local chessItem = self._data.chessItem
	local time = self._data.time
	local animType = self._data.animType

	if not time or not chessItem then
		logError("步骤 Move 参数错误")
		self:onDone(true)

		return
	end

	EliminateStepUtil.putMoveStepTable(self._data)
	chessItem:toMove(time, animType, self._onDone, self)
end

return EliminateChessMoveStep
