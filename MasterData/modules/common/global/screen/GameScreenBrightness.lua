-- chunkname: @modules/common/global/screen/GameScreenBrightness.lua

module("modules.common.global.screen.GameScreenBrightness", package.seeall)

local GameScreenBrightness = class("GameScreenBrightness")

function GameScreenBrightness:ctor()
	if BootNativeUtil.isAndroid() or BootNativeUtil.isIOS() then
		self:_setScreenLightingOff(false)
		GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
		StoryController.instance:registerCallback(StoryEvent.RefreshStep, self._onRefreshState, self)
		StoryController.instance:registerCallback(StoryEvent.Auto, self._refreshAutoState, self)
		StoryController.instance:registerCallback(StoryEvent.Finish, self._onStoryFinished, self)
		StoryController.instance:registerCallback(StoryEvent.Log, self._refreshAutoState, self)
		SettingsController.instance:registerCallback(SettingsEvent.OnChangeEnergyMode, self._onChangeEnergyMode, self)
	end
end

function GameScreenBrightness:_onChangeEnergyMode()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	self:_setScreenLightingOff(sceneType == SceneType.Fight)
end

function GameScreenBrightness:_onEnterOneSceneFinish(sceneType, sceneId)
	self:_setScreenLightingOff(sceneType == SceneType.Fight)
end

function GameScreenBrightness:_onRefreshState(param)
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Fight then
		return
	end

	if #param.branches > 0 then
		self:_setScreenLightingOff(true)

		return
	end

	self._stepCo = StoryStepModel.instance:getStepListById(param.stepId)

	self:_refreshAutoState()
end

function GameScreenBrightness:_refreshAutoState()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Fight then
		return
	end

	local auto = StoryModel.instance:isStoryAuto()

	if auto then
		self:_setScreenLightingOff(true)

		return
	end

	local off = false

	if self._stepCo then
		local isLimitNoInteractLock = StoryModel.instance:isLimitNoInteractLock(self._stepCo)

		if self._stepCo.conversation.type == StoryEnum.ConversationType.None or self._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog or self._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or isLimitNoInteractLock then
			off = true
		end
	end

	self:_setScreenLightingOff(off)
end

function GameScreenBrightness:_onStoryFinished()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Fight then
		return
	end

	self:_setScreenLightingOff(false)
end

function GameScreenBrightness:_setScreenLightingOff(needLightingOff)
	if SettingsModel.instance:getEnergyMode() == 0 then
		SDKMgr.instance:setScreenLightingOff(true)
	else
		SDKMgr.instance:setScreenLightingOff(needLightingOff)
	end
end

return GameScreenBrightness
