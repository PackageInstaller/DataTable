-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/transition/SceneTransitionAnimEff.lua

module("logicscene.scene.SceneTransitionAnimEff", package.seeall)

local SceneTransitionAnimEff = class("SceneTransitionAnimEff", SceneTransitionBase)

function SceneTransitionAnimEff:prepareTransition(preScene, currScene, isSwitchFestival)
	SceneTransitionAnimEff.super.prepareTransition(self, preScene, currScene, isSwitchFestival)
	self:_clear()
	self:_startLoadResources()

	self._animationPlayer = AnimationPlayer.play("storyconfig/animations/" .. self.animationName .. ".txt", self._onAnimationPlayerFinished, self._onAnimationPlayStarted, self)

	self._animationPlayer:setEvtHandler(self._handleAnimationEvt, self)
end

function SceneTransitionAnimEff:onEnterFinished()
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

	SceneTransitionAnimEff.super.onEnterFinished(self)
end

function SceneTransitionAnimEff:_onAnimationPlayStarted()
	return
end

function SceneTransitionAnimEff:_onAnimationPlayerFinished()
	self._animationPlayer = nil
end

function SceneTransitionAnimEff:_handleAnimationEvt(evtName, go, param1)
	if evtName == "WaitingBulletHit" then
		self._isWaitingBulletHit = true

		self:_checkSwitchScene()

		return true
	end
end

function SceneTransitionAnimEff:_checkSwitchScene()
	if self._isLoadingFinished and self._isWaitingBulletHit then
		self._animationPlayer:NotifyBulletHitFinished(10)
		SceneMgr.instance:notifyEnterFinished()
	end
end

function SceneTransitionAnimEff:_startLoadResources()
	LoadingFacade.instance:setLoadingListener()
	self._currScene.stage:load(self._currScene:getSceneId(), self._onLoadingFinished, self)
end

function SceneTransitionAnimEff:_onLoadingFinished(progress, finished)
	if finished and progress >= 1 then
		self._isLoadingFinished = true

		self:_checkSwitchScene()
	end
end

function SceneTransitionAnimEff:_clear()
	self._isLoadingFinished = false

	if self._animationPlayer then
		self._animationPlayer:Stop()

		self._animationPlayer = nil
	end

	self._isWaitingBulletHit = nil
	self.holdUIStatus = nil
end

function SceneTransitionAnimEff:clear()
	if self._preScene then
		self._preScene:onExitFinished()
		self._preScene.stage:unload()
	end

	self:_clear()

	self.animationName = nil

	SceneTransitionAnimEff.super.clear(self)
end

SceneTransitionAnimEff.instance = SceneTransitionAnimEff.New()

return SceneTransitionAnimEff
