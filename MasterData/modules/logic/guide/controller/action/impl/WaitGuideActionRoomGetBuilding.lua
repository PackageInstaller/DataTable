-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomGetBuilding.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomGetBuilding", package.seeall)

local WaitGuideActionRoomGetBuilding = class("WaitGuideActionRoomGetBuilding", BaseGuideAction)

function WaitGuideActionRoomGetBuilding:onStart(context)
	WaitGuideActionRoomGetBuilding.super.onStart(self, context)

	self._sceneType = SceneType.Room

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._checkOpenView, self)
	RoomController.instance:registerCallback(RoomEvent.GetGuideBuilding, self._onGetGuideBuilding, self)

	self._buildingId = tonumber(self.actionParam)

	if GameSceneMgr.instance:getCurSceneType() == self._sceneType and not GameSceneMgr.instance:isLoading() then
		self:_check()
	else
		GameSceneMgr.instance:registerCallback(self._sceneType, self._onEnterScene, self)
	end
end

function WaitGuideActionRoomGetBuilding:_onEnterScene(sceneId, enterOrExit)
	if enterOrExit == 1 then
		self:_check()
	end
end

function WaitGuideActionRoomGetBuilding:_check()
	local quantity = 1
	local hasQuantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Building, self._buildingId)

	if quantity <= hasQuantity then
		self:onDone(true)
	else
		RoomRpc.instance:sendGainGuideBuildingRequest(self.guideId, self.stepId)
	end
end

function WaitGuideActionRoomGetBuilding:_checkOpenView(viewName)
	if ViewName.RoomBlockPackageGetView == viewName then
		self:clearWork()
		self:onDone(true)
	end
end

function WaitGuideActionRoomGetBuilding:_onGetGuideBuilding(msg)
	local list = {}

	table.insert(list, {
		roomBuildingLevel = 1,
		itemType = MaterialEnum.MaterialType.Building,
		itemId = self._buildingId
	})
	PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomBlockPackageGetView, ViewName.RoomBlockPackageGetView, {
		itemList = list
	})
end

function WaitGuideActionRoomGetBuilding:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._checkOpenView, self)
	RoomController.instance:unregisterCallback(RoomEvent.GetGuideBuilding, self._onGetGuideBuilding, self)
	GameSceneMgr.instance:unregisterCallback(self._sceneType, self._onEnterScene, self)
end

return WaitGuideActionRoomGetBuilding
