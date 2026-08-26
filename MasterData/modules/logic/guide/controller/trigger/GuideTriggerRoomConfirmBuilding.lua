-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerRoomConfirmBuilding.lua

module("modules.logic.guide.controller.trigger.GuideTriggerRoomConfirmBuilding", package.seeall)

local GuideTriggerRoomConfirmBuilding = class("GuideTriggerRoomConfirmBuilding", BaseGuideTrigger)

function GuideTriggerRoomConfirmBuilding:ctor(triggerKey)
	GuideTriggerRoomConfirmBuilding.super.ctor(self, triggerKey)
	RoomBuildingController.instance:registerCallback(RoomEvent.ConfirmBuilding, self._onConfirmBuilding, self)
end

function GuideTriggerRoomConfirmBuilding:assertGuideSatisfy(param, configParam)
	local configBuildingId = tonumber(configParam)

	return param == configBuildingId
end

function GuideTriggerRoomConfirmBuilding:_onConfirmBuilding(buildingId)
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Room then
		self:checkStartGuide(buildingId)
	end
end

return GuideTriggerRoomConfirmBuilding
