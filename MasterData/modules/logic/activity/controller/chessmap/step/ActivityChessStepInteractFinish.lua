-- chunkname: @modules/logic/activity/controller/chessmap/step/ActivityChessStepInteractFinish.lua

module("modules.logic.activity.controller.chessmap.step.ActivityChessStepInteractFinish", package.seeall)

local ActivityChessStepInteractFinish = class("ActivityChessStepInteractFinish", ActivityChessStepBase)

function ActivityChessStepInteractFinish:start()
	local objId = self.originData.id

	ActivityChessGameModel.instance:addFinishInteract(objId)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.CurrentConditionUpdate)
	self:finish()
end

function ActivityChessStepInteractFinish:finish()
	ActivityChessStepInteractFinish.super.finish(self)
end

return ActivityChessStepInteractFinish
