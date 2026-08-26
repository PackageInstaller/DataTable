-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/EliminateChessDieEffectStep.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessDieEffectStep", package.seeall)

local EliminateChessDieEffectStep = class("EliminateChessDieEffectStep", EliminateChessStepBase)

function EliminateChessDieEffectStep:onStart()
	local x = self._data.x
	local y = self._data.y
	local skillEffect = self._data.skillEffect

	self.chess = LengZhou6EliminateChessItemController.instance:getChessItem(x, y)

	if self.chess == nil then
		logWarn("步骤 DieEffect 棋子：" .. x, y .. "不存在")
		self:onDone(true)

		return
	end

	self.chess:toDie(EliminateEnum.AniTime.Die, skillEffect)
	LengZhou6EliminateChessItemController.instance:updateChessItem(x, y, nil)
	TaskDispatcher.runDelay(self._onDone, self, EliminateEnum_2_7.DieStepTime)
end

return EliminateChessDieEffectStep
