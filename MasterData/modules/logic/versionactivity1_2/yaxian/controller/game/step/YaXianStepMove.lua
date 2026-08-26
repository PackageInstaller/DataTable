-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/step/YaXianStepMove.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepMove", package.seeall)

local YaXianStepMove = class("YaXianStepMove", YaXianStepBase)

function YaXianStepMove:start()
	local interactItem = YaXianGameController.instance:getInteractItem(self.originData.id)

	if not interactItem then
		logError("not found interactObj, id : " .. tostring(self.originData.id))
		self:finish()
	end

	self.interactItem = interactItem

	local handle = interactItem:getHandler()

	if handle then
		handle:moveToFromMoveStep(self.originData, self.finish, self)

		return
	end

	logError("interact not found handle, interactId : " .. self.originData.id)
	self:finish()
end

function YaXianStepMove:finish()
	YaXianStepMove.super.finish(self)
end

function YaXianStepMove:dispose()
	if self.interactItem then
		local handle = self.interactItem:getHandler()

		if handle then
			handle:stopAllAction()
		end
	end
end

return YaXianStepMove
