-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerRoomOpenBuildingStrengthView.lua

module("modules.logic.guide.controller.trigger.GuideTriggerRoomOpenBuildingStrengthView", package.seeall)

local GuideTriggerRoomOpenBuildingStrengthView = class("GuideTriggerRoomOpenBuildingStrengthView", BaseGuideTrigger)

function GuideTriggerRoomOpenBuildingStrengthView:ctor(triggerKey)
	GuideTriggerRoomOpenBuildingStrengthView.super.ctor(self, triggerKey)
end

function GuideTriggerRoomOpenBuildingStrengthView:assertGuideSatisfy(param, configParam)
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	return sceneType == SceneType.Room
end

function GuideTriggerRoomOpenBuildingStrengthView:_onOpenBuildingStrengthView(buildingId)
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Room then
		self:checkStartGuide(buildingId)
	end
end

return GuideTriggerRoomOpenBuildingStrengthView
