-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerRoomEnterEdit.lua

module("modules.logic.guide.controller.trigger.GuideTriggerRoomEnterEdit", package.seeall)

local GuideTriggerRoomEnterEdit = class("GuideTriggerRoomEnterEdit", BaseGuideTrigger)

function GuideTriggerRoomEnterEdit:ctor(triggerKey)
	GuideTriggerRoomEnterEdit.super.ctor(self, triggerKey)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
end

function GuideTriggerRoomEnterEdit:assertGuideSatisfy(param, configParam)
	local isRoomScene = param == SceneType.Room
	local isEditMode = RoomController.instance:isEditMode()

	return isRoomScene and isEditMode
end

function GuideTriggerRoomEnterEdit:_onEnterOneSceneFinish(sceneType, sceneId)
	self:checkStartGuide(sceneType)
end

return GuideTriggerRoomEnterEdit
