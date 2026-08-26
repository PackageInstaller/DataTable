-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomBuildingPlaceBlock.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomBuildingPlaceBlock", package.seeall)

local WaitGuideActionRoomBuildingPlaceBlock = class("WaitGuideActionRoomBuildingPlaceBlock", BaseGuideAction)

function WaitGuideActionRoomBuildingPlaceBlock:onStart(context)
	WaitGuideActionRoomBuildingPlaceBlock.super.onStart(self, context)

	self._sceneType = SceneType.Room

	local arr = string.splitToNumber(self.actionParam, "#")

	self._buildingId = arr[1]
	self._toastId = arr[2]

	if GameSceneMgr.instance:getCurSceneType() == self._sceneType and not GameSceneMgr.instance:isLoading() then
		self:_check()
	else
		self:addEvents()
	end
end

function WaitGuideActionRoomBuildingPlaceBlock:_onEnterScene(sceneId, enterOrExit)
	if enterOrExit == 1 then
		self:_check()
	end
end

function WaitGuideActionRoomBuildingPlaceBlock:_check()
	if not GuideExceptionChecker.checkBuildingPut(nil, nil, self._buildingId) then
		self:onDone(true)
	else
		if self._toastId then
			GameFacade.showToast(self._toastId)
		end

		self:addEvents()
	end
end

function WaitGuideActionRoomBuildingPlaceBlock:addEvents()
	if self.hasAddEvents then
		return
	end

	self.hasAddEvents = true

	GameSceneMgr.instance:registerCallback(self._sceneType, self._onEnterScene, self)
end

function WaitGuideActionRoomBuildingPlaceBlock:removeEvents()
	if not self.hasAddEvents then
		return
	end

	self.hasAddEvents = false

	GameSceneMgr.instance:unregisterCallback(self._sceneType, self._onEnterScene, self)
end

function WaitGuideActionRoomBuildingPlaceBlock:clearWork()
	self:removeEvents()
end

return WaitGuideActionRoomBuildingPlaceBlock
