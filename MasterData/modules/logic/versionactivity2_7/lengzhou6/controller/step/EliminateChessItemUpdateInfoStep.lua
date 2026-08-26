-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/EliminateChessItemUpdateInfoStep.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessItemUpdateInfoStep", package.seeall)

local EliminateChessItemUpdateInfoStep = class("EliminateChessItemUpdateInfoStep", EliminateChessStepBase)

function EliminateChessItemUpdateInfoStep:onStart()
	local x = self._data.x
	local y = self._data.y

	if x == nil or y == nil then
		self:onDone(true)

		return
	end

	local data = LocalEliminateChessModel.instance:changeCellId(x, y, EliminateEnum_2_7.ChessTypeToIndex.stone)
	local viewItem = LengZhou6EliminateChessItemController.instance:getChessItem(x, y)

	if data ~= nil and viewItem ~= nil then
		viewItem:initData(data)
	end

	self:onDone(true)
end

return EliminateChessItemUpdateInfoStep
