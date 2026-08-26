-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/EliminateChessArrange_XYStep.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessArrange_XYStep", package.seeall)

local EliminateChessArrange_XYStep = class("EliminateChessArrange_XYStep", EliminateChessStepBase)

function EliminateChessArrange_XYStep:onStart()
	if self._data == nil or #self._data < 1 then
		self:onDone(true)

		return
	end

	for _, value in ipairs(self._data) do
		local x = value.x
		local y = value.y
		local viewItem = value.viewItem

		if viewItem ~= nil then
			LengZhou6EliminateChessItemController.instance:updateChessItem(x, y, viewItem)
		else
			local viewItem = LengZhou6EliminateChessItemController.instance:getChessItem(x, y)
			local data = viewItem:getData()
			local fromX, formY = data.x, data.y
			local fromViewItem = LengZhou6EliminateChessItemController.instance:getChessItem(fromX, formY)

			LengZhou6EliminateChessItemController.instance:updateChessItem(x, y, fromViewItem)
			LengZhou6EliminateChessItemController.instance:updateChessItem(fromX, formY, viewItem)
		end
	end

	self:onDone(true)
end

return EliminateChessArrange_XYStep
