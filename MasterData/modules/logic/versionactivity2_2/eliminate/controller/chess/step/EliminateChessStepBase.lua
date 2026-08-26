-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateChessStepBase.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessStepBase", package.seeall)

local EliminateChessStepBase = class("EliminateChessStepBase", BaseWork)

function EliminateChessStepBase:initData(data)
	self._data = data
end

function EliminateChessStepBase:onStart(context)
	self:onDone(true)
end

function EliminateChessStepBase:_onDone()
	self:onDone(true)
end

function EliminateChessStepBase:clearWork()
	TaskDispatcher.cancelTask(self._onDone, self)
end

return EliminateChessStepBase
