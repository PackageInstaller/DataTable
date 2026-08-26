-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionAdditionCondition.lua

module("modules.logic.guide.controller.action.impl.GuideActionAdditionCondition", package.seeall)

local GuideActionAdditionCondition = class("GuideActionAdditionCondition", BaseGuideAction)

function GuideActionAdditionCondition:onStart(context)
	GuideActionAdditionCondition.super.onStart(self, context)

	local param = string.split(self.actionParam, "#")
	local funcName = param[1]
	local funcParam = param[2]
	local actionStr1 = param[3]
	local actionStr2 = param[4]
	local func = self[funcName]

	if func and func(self, funcParam) then
		self:additionStepId(self.sourceGuideId or self.guideId, actionStr1)
	else
		self:additionStepId(self.sourceGuideId or self.guideId, actionStr2)
	end

	self:onDone(true)
end

function GuideActionAdditionCondition:additionStepId(sourceGuideId, actionStr)
	if not sourceGuideId then
		return
	end

	local flow = GuideStepController.instance:getActionFlow(sourceGuideId)

	if not flow then
		return
	end

	if not string.nilorempty(actionStr) then
		actionStr = string.gsub(actionStr, "&", "|")
		actionStr = string.gsub(actionStr, "*", "#")

		local action = GuideActionBuilder.buildAction(sourceGuideId, 0, actionStr)

		flow:addWork(action)
	end
end

function GuideActionAdditionCondition:checkRoomTaskHasFinished()
	local hasFinish, taskIds = RoomSceneTaskController.instance:isFirstTaskFinished()

	return hasFinish
end

return GuideActionAdditionCondition
