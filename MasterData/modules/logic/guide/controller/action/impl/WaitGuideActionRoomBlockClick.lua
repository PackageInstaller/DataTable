-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomBlockClick.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomBlockClick", package.seeall)

local WaitGuideActionRoomBlockClick = class("WaitGuideActionRoomBlockClick", BaseGuideAction)

function WaitGuideActionRoomBlockClick:ctor(guideId, stepId, actionParam)
	WaitGuideActionRoomBlockClick.super.ctor(self, guideId, stepId, actionParam)
end

function WaitGuideActionRoomBlockClick:onStart(context)
	WaitGuideActionRoomBlockClick.super.onStart(self, context)
	GuideViewMgr.instance:enableHoleClick()
	GuideViewMgr.instance:setHoleClickCallback(self._onClickTarget, self)
end

function WaitGuideActionRoomBlockClick:clearWork()
	GuideViewMgr.instance:setHoleClickCallback(nil, nil)
	TaskDispatcher.cancelTask(self._onDelayDone, self)
end

function WaitGuideActionRoomBlockClick:_onClickTarget(isInside)
	if isInside then
		GuideViewMgr.instance:disableHoleClick()
		GuideViewMgr.instance:setHoleClickCallback(nil, nil)
		TaskDispatcher.runDelay(self._onDelayDone, self, 0.01)

		local goPath = GuideModel.instance:getStepGOPath(self.guideId, self.stepId)
		local blockGO = gohelper.find(goPath)
		local worldPos = blockGO.transform.position
		local bendingPos = RoomBendingHelper.worldToBendingSimple(worldPos)
		local mainCamera = CameraMgr.instance:getMainCamera()
		local screenPos = mainCamera:WorldToScreenPoint(bendingPos)

		RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickScene, screenPos)
	end
end

function WaitGuideActionRoomBlockClick:_onDelayDone()
	self:onDone(true)
end

return WaitGuideActionRoomBlockClick
