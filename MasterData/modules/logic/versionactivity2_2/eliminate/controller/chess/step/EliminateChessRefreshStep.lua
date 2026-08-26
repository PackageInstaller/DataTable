-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateChessRefreshStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessRefreshStep", package.seeall)

local EliminateChessRefreshStep = class("EliminateChessRefreshStep", EliminateChessStepBase)

function EliminateChessRefreshStep:onStart()
	local data = EliminateChessModel.instance:getNeedResetData()

	if data == nil then
		self:onDone(true)

		return
	end

	EliminateChessController.instance:handleEliminateChessInfo(data.info)
	EliminateChessController.instance:handleMatch3Tips(data.match3tips)
	EliminateChessItemController.instance:refreshChess()
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.RefreshInitChessShow, false)
	EliminateChessModel.instance:setNeedResetData(nil)
	TaskDispatcher.runDelay(self._onDone, self, EliminateEnum.AniTime.InitDrop)
end

return EliminateChessRefreshStep
