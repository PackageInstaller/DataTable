-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterpreview/scene/CharacterPreviewAirtightMgr.lua

module("logic.extensions.characterpreview.scene.CharacterPreviewAirtightMgr", package.seeall)

local M = class("CharacterPreviewAirtightMgr", SceneComponentBase)
local kAnimStatus = {
	ToAirtight = "sx-s001_mainscene_env_to_airtight",
	Airtight = "sx-s001_mainscene_env_airtight",
	ToNormal = "sx-s001_mainscene_env_to_normal",
	Normal = "sx-s001_mainscene_env_normal"
}
local kShakeCamEvent = "shake_cam"

function M:onInit()
	return
end

function M:onEnterScene(sceneId, bornX, bornZ)
	return
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	self:_initEnvAnimation()
	self:_setEnvStatusDirectly()
	self:_setEvent(true)
end

function M:onExitScene()
	self:_setEvent(false)

	self._envAnimation = nil

	if not goutil.isNil(self._envAnimListener) then
		self._envAnimListener:RemoveListener()

		self._envAnimListener = nil
	end

	VirtualCameraMgr.instance:stopShake()
end

function M:onLeaveScene()
	self._envAnimation = nil

	self:onExitScene()
end

function M:onReturnScene()
	self:_setEvent(true)
end

function M:onReturnSceneFinished()
	return
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_PREVIEW, self._handleAritightStatePreview, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_PREVIEW, self._handleAritightStatePreview, self)
	end
end

function M:_initEnvAnimation()
	self._envAnimation = self._scene.stage:getSceneEnviromentAnimation()
	self._envAnimListener = Astral.AnimationEventListener.Get(self._envAnimation.gameObject)

	self._envAnimListener:AddListener(self._onAnimEvent, self)

	local inTime = AirtightRoomController.instance:getIsInAirtightTime(nil, nil, nil, false)

	self:_playEnvAni(inTime, false)
end

function M:_handleAritightStateChange(_, isInAirtight, airtightEndTS)
	self:_playEnvAni(isInAirtight, true)
end

function M:_handleAritightStatePreview(_, isInAirtight)
	if isInAirtight ~= nil then
		self:_playEnvAni(isInAirtight, true)
	end
end

function M:_setEnvStatusDirectly()
	local inTime = AirtightRoomController.instance:getIsInAirtightTime(nil, nil, nil, false)

	self:_playEnvAni(inTime, false)
end

function M:_playEnvAni(inAirtight, playAni)
	local animName

	if inAirtight then
		animName = playAni and kAnimStatus.ToAirtight or kAnimStatus.Airtight
	else
		animName = playAni and kAnimStatus.ToNormal or kAnimStatus.Normal
	end

	if playAni then
		CriwareAudioFacade.instance:playSEById(inAirtight and CriwareAudioEnum.ui_main_into_echotime or CriwareAudioEnum.ui_main_into_realtime)
	end

	self._envAnimation:Stop()
	self._envAnimation:Play(animName)
end

function M:_onAnimEvent(animationEvent)
	if animationEvent.stringParameter == kShakeCamEvent then
		local camUnit = VirtualCameraMgr.instance:getActiveCamera()

		camUnit:shake(1, 0.1, 0, 0.1, 0.2)
	end
end

return M
