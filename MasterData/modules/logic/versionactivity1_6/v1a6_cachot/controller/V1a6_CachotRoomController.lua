-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/controller/V1a6_CachotRoomController.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotRoomController", package.seeall)

local V1a6_CachotRoomController = class("V1a6_CachotRoomController", BaseController)

function V1a6_CachotRoomController:reInit()
	self._isSwitchLevel = nil

	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomViewOpenAnimEnd, self._switchLevel, self)
end

function V1a6_CachotRoomController:addConstEvents()
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChange, self._checkAndSwitchLevel, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, self._playRoomViewOpenAnim, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._checkAndSwitchLevel, self)
end

function V1a6_CachotRoomController:_checkAndSwitchLevel()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Cachot then
		return
	end

	if not V1a6_CachotRoomModel.instance:getRoomIsChange() then
		return
	end

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not rogueInfo then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView) then
		return
	end

	if PopupController.instance:getPopupCount() > 0 then
		return false
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomChangeBegin)

	local levelId = V1a6_CachotConfig.instance:getSceneLevelId(rogueInfo.sceneId)

	if V1a6_CachotRoomModel.instance:getLayerIsChange() then
		V1a6_CachotRoomModel.instance:clearRoomChangeStatus()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingCachotChangeView)
		GameSceneMgr.instance:startScene(SceneType.Cachot, 90001, levelId, true, true)
	else
		V1a6_CachotRoomModel.instance:clearRoomChangeStatus()
		V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomViewOpenAnimEnd, self._switchLevel, self)
	end
end

function V1a6_CachotRoomController:_switchLevel()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomViewOpenAnimEnd, self._switchLevel, self)

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not rogueInfo then
		return
	end

	local levelId = V1a6_CachotConfig.instance:getSceneLevelId(rogueInfo.sceneId)

	self._isSwitchLevel = true

	GameSceneMgr.instance:getCurScene().level:switchLevel(levelId)
end

function V1a6_CachotRoomController:_playRoomViewOpenAnim(levelId)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Cachot then
		return
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomChangePlayAnim, self._isSwitchLevel)

	self._isSwitchLevel = nil
end

V1a6_CachotRoomController.instance = V1a6_CachotRoomController.New()

return V1a6_CachotRoomController
