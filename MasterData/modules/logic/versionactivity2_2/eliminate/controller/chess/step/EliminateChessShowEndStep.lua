-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateChessShowEndStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessShowEndStep", package.seeall)

local EliminateChessShowEndStep = class("EliminateChessShowEndStep", EliminateChessStepBase)

function EliminateChessShowEndStep:onStart()
	local time = self._data.time

	self._cb = self._data.cb

	local needShowEnd = self._data.needShowEnd
	local switchTime = EliminateTeamChessEnum.matchToTeamChessStepTime

	time = math.min(time, switchTime)

	if needShowEnd then
		EliminateChessController.instance:dispatchEvent(EliminateChessEvent.Match3ChessEndViewOpen)
		EliminateChessController.instance:openNoticeView(false, true, false, false, 0, time, nil, nil)
	end

	TaskDispatcher.runDelay(self._onDone, self, switchTime)
end

function EliminateChessShowEndStep:_onDone()
	if self._cb then
		self._cb()
	end

	EliminateChessShowEndStep.super._onDone(self)
end

return EliminateChessShowEndStep
