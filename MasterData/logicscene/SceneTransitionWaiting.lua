-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/transition/SceneTransitionWaiting.lua

module("logicscene.scene.SceneTransitionWaiting", package.seeall)

local SceneTransitionWaiting = class("SceneTransitionWaiting", SceneTransitionBase)

function SceneTransitionWaiting:prepareTransition(preScene, currScene)
	SceneTransitionWaiting.super.prepareTransition(self, preScene, currScene)
	WaitingView.instance:show(nil, self)
	LoadingFacade.instance:setLoadingListener()
	self._currScene.stage:load(self._currScene:getSceneId())
end

function SceneTransitionWaiting:onEnterFinished()
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

	SceneTransitionWaiting.super.onEnterFinished(self)
end

function SceneTransitionWaiting:clear()
	if self._preScene then
		self._preScene:onExitFinished()
		self._preScene.stage:unload()
	end

	self.holdUIStatus = nil

	SceneTransitionWaiting.super.clear(self)
end

SceneTransitionWaiting.instance = SceneTransitionWaiting.New()

return SceneTransitionWaiting
