-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerRoomTradeLv.lua

module("modules.logic.guide.controller.trigger.GuideTriggerRoomTradeLv", package.seeall)

local GuideTriggerRoomTradeLv = class("GuideTriggerRoomTradeLv", BaseGuideTrigger)

function GuideTriggerRoomTradeLv:ctor(triggerKey)
	GuideTriggerRoomTradeLv.super.ctor(self, triggerKey)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnTradeLevelUpReply, self._checkStartGuide, self)
	ManufactureController.instance:registerCallback(ManufactureEvent.TradeLevelChange, self._checkStartGuide, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
end

function GuideTriggerRoomTradeLv:assertGuideSatisfy(param, configParam)
	local isRoomScene = param == SceneType.Room
	local configLv = tonumber(configParam)

	return isRoomScene and configLv <= self:getParam()
end

function GuideTriggerRoomTradeLv:getParam()
	return ManufactureModel.instance:getTradeLevel()
end

function GuideTriggerRoomTradeLv:_onEnterOneSceneFinish(sceneType, sceneId)
	self:checkStartGuide(sceneType)
end

function GuideTriggerRoomTradeLv:_checkStartGuide()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Room then
		self:checkStartGuide(sceneType)
	end
end

return GuideTriggerRoomTradeLv
