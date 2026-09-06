-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/transition/SceneTransitionLoading.lua

module("logicscene.scene.SceneTransitionLoading", package.seeall)

local SceneTransitionLoading = class("SceneTransitionLoading", SceneTransitionBase)

function SceneTransitionLoading:ctor()
	self.loadingBgIndex = nil
end

function SceneTransitionLoading:prepareTransition(preScene, currScene)
	SceneTransitionLoading.super.prepareTransition(self, preScene, currScene)

	if not self.loadingBgIndex then
		self.loadingBgIndex = LoadingTipsAndPicsModel.instance:getNextPicsIndex()

		getres(GameUrl.getLoadingbgUrl(self.loadingBgIndex), self._onResLoadedFinish, self, ResType.AssetBundle, true)
	end
end

function SceneTransitionLoading:onEnterFinished()
	GlobalModel.instance:resetUINodes()

	if SceneMgr.instance.isGogingToEnterBattleScene or not StoryController.instance.firstStoryId or TaskController.instance:hasDoFirstTaskTarget() or StoryController.instance:isPlaying(StoryController.instance.firstStoryId) then
		SceneMgr.instance:hideLoading()

		TaskController.instance.isFirstTaskDoing = nil
	else
		TaskController.instance.isFirstTaskDoing = true
	end

	self.loadingBgIndex = nil

	if self._loadingBgRes then
		self._loadingBgRes:Release()

		self._loadingBgRes = nil
	end

	SceneTransitionLoading.super.onEnterFinished(self)
end

function SceneTransitionLoading:_onResLoadedFinish(res)
	if not self.loadingBgIndex or not self._currScene then
		return
	end

	self._loadingBgRes = res

	self._loadingBgRes:Retain()

	LoadingView.loadingBgIndex = self.loadingBgIndex

	UIStateManager.instance:clear(false)
	ViewMgr.instance:closeAllViews()
	SceneMgr.instance:showLoading()
	ScenePreLoaderMgr.instance:clearAll()

	if self._preScene then
		self._preScene:onExitFinished()
		self._preScene.stage:unload()
	end

	GlobalModel.instance:onlyShowUINode("TOPMOST")
	LoadingFacade.instance:setLoadingListener(self._onProgressingFinish, self)
	self._currScene.stage:load(self._currScene:getSceneId(), self._onLoadingProgress, self)
end

function SceneTransitionLoading:_onLoadingProgress(progress, finished)
	LoadingFacade.instance:setTargetProgress(progress)

	if finished and progress >= 1 then
		if self._currScene then
			self._currScene.stage:loadingDone()
		end

		SceneMgr.instance:notifyEnterFinished()
	end
end

function SceneTransitionLoading:_onProgressingFinish()
	if self._currScene then
		self._currScene.stage:loadingDone()
	end
end

function SceneTransitionLoading:clear()
	SceneTransitionLoading.super.clear(self)
	GlobalModel.instance:resetUINodes()

	if self.loadingBgIndex then
		removeresl(GameUrl.getLoadingbgUrl(self.loadingBgIndex), self._onResLoadedFinish, self)

		self.loadingBgIndex = nil
	end

	if self._loadingBgRes then
		self._loadingBgRes:Release()

		self._loadingBgRes = nil
	end
end

SceneTransitionLoading.instance = SceneTransitionLoading.New()

return SceneTransitionLoading
