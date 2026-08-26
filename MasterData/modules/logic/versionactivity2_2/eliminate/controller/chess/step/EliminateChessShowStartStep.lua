-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateChessShowStartStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessShowStartStep", package.seeall)

local EliminateChessShowStartStep = class("EliminateChessShowStartStep", EliminateChessStepBase)

function EliminateChessShowStartStep:onStart()
	local time = self._data

	EliminateChessController.instance:openNoticeView(true, false, false, false, 0, time, self._onPlayEnd, self)
end

function EliminateChessShowStartStep:_onPlayEnd()
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.Match3ChessBeginViewClose)
	self:onDone(true)
end

return EliminateChessShowStartStep
