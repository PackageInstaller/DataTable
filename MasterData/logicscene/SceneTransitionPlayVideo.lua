-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/transition/SceneTransitionPlayVideo.lua

module("logicscene.scene.SceneTransitionPlayVideo", package.seeall)

local SceneTransitionPlayVideo = class("SceneTransitionPlayVideo", SceneTransitionBase)

function SceneTransitionPlayVideo:prepareTransition(preScene, currScene)
	SceneTransitionPlayVideo.super.prepareTransition(self, preScene, currScene)

	self._isPlayingVideo = nil

	WaitingView.instance:show(nil, self)
	LoadingFacade.instance:setLoadingListener()

	self._currMovieIndex = 0

	GlobalModel.instance.mainCamera.gameObject:SetActive(true)
	VideoFacade.instance:stop()
	self:_playVideo()
	self._currScene.stage:load(self._currScene:getSceneId(), self._onLoadingFinish, self)
end

function SceneTransitionPlayVideo:onEnterFinished()
	if self._preScene then
		self._preScene:onExitFinished()
		self._preScene.stage:unload()
	end

	WaitingView.instance:hide(self)

	self.videoNames = nil
	self._isPlayingVideo = nil
	self.traceStartKeys = nil
	self.traceStartNames = nil
	self.traceEndKeys = nil
	self._hasClearPreScene = nil
	self._isSceneLoadingFinished = nil
	self.traceEndNames = nil
	self._currMovieIndex = nil
	self._isMoviePlayFinished = nil

	SceneTransitionPlayVideo.super.onEnterFinished(self)
end

function SceneTransitionPlayVideo:_onLoadingFinish(progress, finished)
	if finished and progress >= 1 then
		self._isSceneLoadingFinished = true

		self:_checkAllLoadFinished()
	end
end

function SceneTransitionPlayVideo:_playVideo()
	self._currMovieIndex = self._currMovieIndex + 1

	if self._currMovieIndex > #self.videoNames then
		self._isPlayingVideo = nil

		return
	end

	self._isPlayingVideo = true

	if self.traceStartKeys and self.traceStartNames then
		SDKManager.sensorsTrackLoadingOnce(self.traceStartNames[self._currMovieIndex], self.traceStartKeys[self._currMovieIndex])
	end

	ViewMgr.instance:open(ViewName.VideoPlaying, self.videoNames[self._currMovieIndex], false, self._onMoviePlayFinished, self._onMoviePlayStarted, self)
end

function SceneTransitionPlayVideo:_onMoviePlayStarted()
	if not self._isPlayingVideo then
		return
	end

	GameUtil.clickEnabled(true, self)
	WaitingView.instance:hide(self)

	if not self._hasClearPreScene then
		ScenePreLoaderMgr.instance:clearAll()

		if self._preScene then
			self._preScene:onExitFinished()
			self._preScene.stage:unload()
		end

		self._hasClearPreScene = true

		AudioBgmPlayer.instance:stopMusic()

		if not self._preScene then
			ViewMgr.instance:close(ViewName.Login)
			GlobalModel.instance.gameStart:SetActive(false)
			SDKManager.sensorsTrack(BootstrapConstdef.ECPCreateAnimStart)
		elseif self._preScene:getSceneType() == SceneType.CreateRole then
			ViewMgr.instance:close(ViewName.CreateRole)
		end
	end
end

function SceneTransitionPlayVideo:_onMoviePlayFinished()
	if not self._isPlayingVideo then
		return
	end

	self._isPlayingVideo = nil

	GameUtil.clickEnabled(false, self)
	WaitingView.instance:show(nil, self)

	if self.traceEndKeys and self.traceEndNames then
		SDKManager.sensorsTrackLoadingOnce(self.traceEndNames[self._currMovieIndex], self.traceEndKeys[self._currMovieIndex])
	end

	if self._currMovieIndex < #self.videoNames then
		self:_playVideo()
	else
		self._isMoviePlayFinished = true

		self:_checkAllLoadFinished()
	end
end

function SceneTransitionPlayVideo:_checkAllLoadFinished()
	if self._isSceneLoadingFinished and self._isMoviePlayFinished then
		self._currScene.stage:loadingDone()
		SceneMgr.instance:notifyEnterFinished()
	end
end

function SceneTransitionPlayVideo:clear()
	if self._isPlayingVideo then
		VideoFacade.instance:stop()

		self._isPlayingVideo = nil
	end

	self._isMoviePlayFinished = nil
	self._isSceneLoadingFinished = nil
	self._hasClearPreScene = nil
	self.videoNames = nil
	self.traceStartKeys = nil
	self.traceStartNames = nil
	self.traceEndKeys = nil
	self.traceEndNames = nil
	self._currMovieIndex = nil

	if self._preScene then
		self._preScene:onExitFinished()
		self._preScene.stage:unload()
	end

	SceneTransitionPlayVideo.super.clear(self)
end

SceneTransitionPlayVideo.instance = SceneTransitionPlayVideo.New()

return SceneTransitionPlayVideo
