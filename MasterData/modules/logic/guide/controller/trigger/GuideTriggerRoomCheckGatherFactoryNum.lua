-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerRoomCheckGatherFactoryNum.lua

module("modules.logic.guide.controller.trigger.GuideTriggerRoomCheckGatherFactoryNum", package.seeall)

local GuideTriggerRoomCheckGatherFactoryNum = class("GuideTriggerRoomCheckGatherFactoryNum", BaseGuideTrigger)

function GuideTriggerRoomCheckGatherFactoryNum:ctor(triggerKey)
	GuideTriggerRoomCheckGatherFactoryNum.super.ctor(self, triggerKey)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
	RoomMapController.instance:registerCallback(RoomEvent.UseBuildingReply, self._onUseBuildingReply, self)
end

function GuideTriggerRoomCheckGatherFactoryNum:_onUseBuildingReply()
	self:checkStartGuide(SceneType.Room)
end

function GuideTriggerRoomCheckGatherFactoryNum:assertGuideSatisfy(param, configParam)
	local isRoomScene = param == SceneType.Room
	local isObMode = RoomController.instance:isObMode()

	if not isRoomScene or not isObMode then
		return
	end

	local list = RoomMapBuildingModel.instance:getBuildingMOList()
	local num = 0

	for i, v in ipairs(list) do
		if v.config.buildingType == RoomBuildingEnum.BuildingType.Gather and v.buildingState == RoomBuildingEnum.BuildingState.Map then
			num = num + 1
		end
	end

	return num >= 4
end

function GuideTriggerRoomCheckGatherFactoryNum:_onEnterOneSceneFinish(sceneType, sceneId)
	self:checkStartGuide(sceneType)
end

return GuideTriggerRoomCheckGatherFactoryNum
