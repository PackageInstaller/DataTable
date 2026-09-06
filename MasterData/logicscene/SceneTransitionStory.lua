-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/transition/SceneTransitionStory.lua

module("logicscene.scene.SceneTransitionStory", package.seeall)

local SceneTransitionStory = class("SceneTransitionStory", SceneTransitionBase)

function SceneTransitionStory:prepareTransition(preScene, currScene, isSwitchFestival)
	SceneTransitionStory.super.prepareTransition(self, preScene, currScene, isSwitchFestival)
	self:_clear()
	self:_startLoadResources()

	if checknumber(self._storyId) <= 0 then
		self._isWaitingBulletHit = true
	else
		GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onEndStory, self)
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._storyId, StoryModel.StoryType.SCCopy)
		GameUtil.clickEnabled(true, self)
	end
end

function SceneTransitionStory:onEnterFinished()
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onEndStory, self)
	ScenePreLoaderMgr.instance:clearExcept(self._currScene:getSceneId())

	if self._preScene then
		self._preScene:onExitFinished()
		self._preScene.stage:unload()
	end

	WaitingView.instance:hide(self)

	if not self.holdUIStatus then
		UIStateManager.instance:clear(false)
		ViewMgr.instance:closeAllViews()
	end

	self.holdUIStatus = nil

	SceneTransitionStory.super.onEnterFinished(self)
end

function SceneTransitionStory:clear()
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onEndStory, self)

	if self._preScene then
		self._preScene:onExitFinished()
		self._preScene.stage:unload()
	end

	self:_clear()

	self._storyId = nil

	SceneTransitionStory.super.clear(self)
end

function SceneTransitionStory:setStoryId(storyId)
	self._storyId = storyId
end

function SceneTransitionStory:_onEndStory(storyId, isAllEnd)
	if not isAllEnd then
		return
	end

	if self._storyId ~= storyId then
		return
	end

	self._isWaitingBulletHit = true

	self:_checkSwitchScene()
end

function SceneTransitionStory:_checkSwitchScene()
	if self._isLoadingFinished and self._isWaitingBulletHit then
		SceneMgr.instance:notifyEnterFinished()
	end
end

function SceneTransitionStory:_startLoadResources()
	LoadingFacade.instance:setLoadingListener()
	self._currScene.stage:load(self._currScene:getSceneId(), self._onLoadingFinished, self)
end

function SceneTransitionStory:_onLoadingFinished(progress, finished)
	if finished and progress >= 1 then
		self._isLoadingFinished = true

		self:_checkSwitchScene()
	end
end

function SceneTransitionStory:_clear()
	self._isLoadingFinished = false

	if self._animationPlayer then
		self._animationPlayer:Stop()

		self._animationPlayer = nil
	end

	self._isWaitingBulletHit = nil
	self.holdUIStatus = nil
end

SceneTransitionStory.instance = SceneTransitionStory.New()

return SceneTransitionStory
