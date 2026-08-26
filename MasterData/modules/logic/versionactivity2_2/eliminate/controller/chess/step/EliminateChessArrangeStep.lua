-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateChessArrangeStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessArrangeStep", package.seeall)

local EliminateChessArrangeStep = class("EliminateChessArrangeStep", EliminateChessStepBase)

function EliminateChessArrangeStep:onStart()
	if self._data == nil or #self._data < 1 then
		self:onDone(true)

		return
	end

	for _, value in ipairs(self._data) do
		local model = value.model
		local viewItem = value.viewItem

		if model and viewItem then
			EliminateChessItemController.instance:updateChessItem(model.x, model.y, viewItem)
		end
	end

	self:onDone(true)
end

return EliminateChessArrangeStep
