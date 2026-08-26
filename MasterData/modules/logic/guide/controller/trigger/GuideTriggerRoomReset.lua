-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerRoomReset.lua

module("modules.logic.guide.controller.trigger.GuideTriggerRoomReset", package.seeall)

local GuideTriggerRoomReset = class("GuideTriggerRoomReset", BaseGuideTrigger)

function GuideTriggerRoomReset:ctor(triggerKey)
	GuideTriggerRoomReset.super.ctor(self, triggerKey)
	RoomMapController.instance:registerCallback(RoomEvent.Reset, self._onReset, self)
end

function GuideTriggerRoomReset:assertGuideSatisfy(param, configParam)
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	return sceneType == SceneType.Room
end

function GuideTriggerRoomReset:_onReset()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Room then
		self:checkStartGuide()
	end
end

return GuideTriggerRoomReset
