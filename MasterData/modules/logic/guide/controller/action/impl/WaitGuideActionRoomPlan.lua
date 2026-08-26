-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomPlan.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomPlan", package.seeall)

local WaitGuideActionRoomPlan = class("WaitGuideActionRoomPlan", BaseGuideAction)

function WaitGuideActionRoomPlan:onStart(context)
	WaitGuideActionRoomPlan.super.onStart(self, context)
	RoomController.instance:registerCallback(RoomEvent.AccelerateGuidePlan, self._onAccelerateGuidePlan, self)
	RoomRpc.instance:sendAccelerateGuidePlanRequest(self.guideId, self.stepId)
end

function WaitGuideActionRoomPlan:_onAccelerateGuidePlan(msg)
	self:clearWork()
	self:onDone(true)
end

function WaitGuideActionRoomPlan:clearWork()
	RoomController.instance:unregisterCallback(RoomEvent.AccelerateGuidePlan, self._onAccelerateGuidePlan, self)
end

return WaitGuideActionRoomPlan
