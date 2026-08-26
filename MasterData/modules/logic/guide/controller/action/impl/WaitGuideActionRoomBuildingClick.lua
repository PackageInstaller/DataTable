-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomBuildingClick.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomBuildingClick", package.seeall)

local WaitGuideActionRoomBuildingClick = class("WaitGuideActionRoomBuildingClick", BaseGuideAction)

function WaitGuideActionRoomBuildingClick:ctor(guideId, stepId, actionParam)
	WaitGuideActionRoomBuildingClick.super.ctor(self, guideId, stepId, actionParam)
end

function WaitGuideActionRoomBuildingClick:onStart(context)
	WaitGuideActionRoomBuildingClick.super.onStart(self, context)
	GuideViewMgr.instance:enableHoleClick()
	GuideViewMgr.instance:setHoleClickCallback(self._onClickTarget, self)
end

function WaitGuideActionRoomBuildingClick:clearWork()
	GuideViewMgr.instance:setHoleClickCallback(nil, nil)
	TaskDispatcher.cancelTask(self._onDelayDone, self)
end

function WaitGuideActionRoomBuildingClick:_onClickTarget(isInside)
	if isInside then
		GuideViewMgr.instance:disableHoleClick()
		GuideViewMgr.instance:setHoleClickCallback(nil, nil)
		TaskDispatcher.runDelay(self._onDelayDone, self, 0.01)

		local buildingId = tonumber(self.actionParam)
		local mo = RoomMapBuildingModel.instance:getBuildingMoByBuildingId(buildingId)

		if mo then
			RoomMap3DClickController.instance:onBuildingEntityClick(mo)
		end
	end
end

function WaitGuideActionRoomBuildingClick:_onDelayDone()
	self:onDone(true)
end

return WaitGuideActionRoomBuildingClick
