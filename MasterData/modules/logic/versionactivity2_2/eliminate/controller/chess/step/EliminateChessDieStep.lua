-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateChessDieStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessDieStep", package.seeall)

local EliminateChessDieStep = class("EliminateChessDieStep", EliminateChessStepBase)

function EliminateChessDieStep:onStart()
	local x = self._data.x
	local y = self._data.y

	self.resourceIds = self._data.resourceIds

	local source = self._data.source

	self.chess = EliminateChessItemController.instance:getChessItem(x, y)

	if not self.chess then
		logError("步骤 Die 棋子：" .. x, y .. "不存在")
		self:onDone(true)

		return
	end

	self.chess:toDie(EliminateEnum.AniTime.Die, source)
	TaskDispatcher.runDelay(self._onDone, self, EliminateEnum.DieStepTime)
	TaskDispatcher.runDelay(self._playFly, self, EliminateEnum.DieToFlyOffsetTime)
end

function EliminateChessDieStep:_playFly()
	TaskDispatcher.cancelTask(self._playFly, self)

	if self.chess ~= nil and self.resourceIds ~= nil then
		self.chess:toFlyResource(self.resourceIds)
	end
end

function EliminateChessDieStep:clearWork()
	TaskDispatcher.cancelTask(self._playFly, self)
	EliminateChessDieStep.super.clearWork(self)
end

return EliminateChessDieStep
