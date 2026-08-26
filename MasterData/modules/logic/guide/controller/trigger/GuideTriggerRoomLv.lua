-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerRoomLv.lua

module("modules.logic.guide.controller.trigger.GuideTriggerRoomLv", package.seeall)

local GuideTriggerRoomLv = class("GuideTriggerRoomLv", BaseGuideTrigger)

function GuideTriggerRoomLv:ctor(triggerKey)
	GuideTriggerRoomLv.super.ctor(self, triggerKey)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, self._checkStartGuide, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
end

function GuideTriggerRoomLv:assertGuideSatisfy(param, configParam)
	local isRoomScene = param == SceneType.Room
	local configLv = tonumber(configParam)

	return isRoomScene and configLv <= self:getParam()
end

function GuideTriggerRoomLv:getParam()
	return RoomMapModel.instance:getRoomLevel()
end

function GuideTriggerRoomLv:_onEnterOneSceneFinish(sceneType, sceneId)
	self:checkStartGuide(sceneType)
end

function GuideTriggerRoomLv:_checkStartGuide()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Room then
		self:checkStartGuide(sceneType)
	end
end

return GuideTriggerRoomLv
