-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomInitBuildingLvUp.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomInitBuildingLvUp", package.seeall)

local WaitGuideActionRoomInitBuildingLvUp = class("WaitGuideActionRoomInitBuildingLvUp", BaseGuideAction)

function WaitGuideActionRoomInitBuildingLvUp:onStart(context)
	WaitGuideActionRoomInitBuildingLvUp.super.onStart(self, context)

	self._targetLevel = tonumber(self.actionParam) or 3

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, self._onUpdateRoomLevel, self, LuaEventSystem.Low)
end

function WaitGuideActionRoomInitBuildingLvUp:_onOpenViewFinish(viewName)
	if viewName == ViewName.RoomInitBuildingView and self:_isSatisfy() then
		self:onDone(true)
	end
end

function WaitGuideActionRoomInitBuildingLvUp:_isSatisfy()
	return ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) and RoomMapModel.instance:getRoomLevel() >= self._targetLevel
end

function WaitGuideActionRoomInitBuildingLvUp:_onUpdateRoomLevel()
	if self:_isSatisfy() then
		self:_checkTaskFinish()
	end
end

function WaitGuideActionRoomInitBuildingLvUp:_checkTaskFinish()
	local hasFinish, taskIds = RoomSceneTaskController.instance:isFirstTaskFinished()

	if hasFinish then
		TaskController.instance:registerCallback(TaskEvent.SuccessGetBonus, self._checkTaskFinish, self, LuaEventSystem.Low)
	else
		self:onDone(true)
	end
end

function WaitGuideActionRoomInitBuildingLvUp:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateRoomLevel, self._onUpdateRoomLevel, self)
	TaskController.instance:unregisterCallback(TaskEvent.SuccessGetBonus, self._checkTaskFinish, self)
end

return WaitGuideActionRoomInitBuildingLvUp
