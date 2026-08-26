-- chunkname: @modules/logic/video/view/FullScreenVideoView.lua

module("modules.logic.video.view.FullScreenVideoView", package.seeall)

local FullScreenVideoView = class("FullScreenVideoView", BaseView)

FullScreenVideoView.DefaultMaxDuration = 3

function FullScreenVideoView:onInitView()
	self._goblackbg = gohelper.findChild(self.viewGO, "blackbg")
	self._govideo = gohelper.findChild(self.viewGO, "#go_video")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
end

function FullScreenVideoView:addEvents()
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function FullScreenVideoView:removeEvents()
	self._btnskip:RemoveClickListener()
end

function FullScreenVideoView:_btnskipOnClick()
	self:onPlayVideoDone()
end

function FullScreenVideoView:onOpen()
	self.doneCb = self.viewParam.doneCb
	self.doneCbObj = self.viewParam.doneCbObj
	self.waitViewOpen = self.viewParam.waitViewOpen
	self.couldSkip = self.viewParam.couldSkip or false

	gohelper.setActive(self._btnskip.gameObject, self.couldSkip)

	self.videoDone = false

	local getVideoPlayer = self.viewParam.getVideoPlayer

	self._setVideoPlayer = self.viewParam.setVideoPlayer

	if getVideoPlayer then
		self._videoPlayer, self.videoGo = self.viewParam.getVideoPlayer(self.doneCbObj)

		gohelper.addChild(self._govideo, self.videoGo)
		transformhelper.setLocalScale(self.videoGo.transform, 1, 1, 1)
		gohelper.setActive(self.videoGo, true)
	else
		self._videoPlayer, self.videoGo = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._govideo)
	end

	if self.viewParam.videoAudio then
		AudioMgr.instance:trigger(self.viewParam.videoAudio)
	end

	self._videoPath = self.viewParam.videoPath

	self._videoPlayer:play(self.viewParam.videoPath, false, self.videoStatusUpdate, self)
	gohelper.setActive(self._goblackbg, not self.viewParam.noShowBlackBg)

	local bgAdapter = self.videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter))

	if bgAdapter then
		bgAdapter.enabled = false
	end

	self._time = self.viewParam.videoDuration or FullScreenVideoView.DefaultMaxDuration

	TaskDispatcher.runDelay(self.onVideoOverTime, self, self._time)
end

function FullScreenVideoView:videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.FinishedPlaying then
		self:onPlayVideoDone()
	elseif status == VideoEnum.PlayerStatus.Closing then
		self:onPlayVideoDone()
	elseif status == VideoEnum.PlayerStatus.Started or status == VideoEnum.PlayerStatus.FinishedSeeking then
		TaskDispatcher.cancelTask(self.onVideoOverTime, self)
		TaskDispatcher.runDelay(self.onVideoOverTime, self, self._time)
		VideoController.instance:dispatchEvent(VideoEvent.OnVideoStarted, self._videoPath)
	elseif status == VideoEnum.PlayerStatus.FirstFrameReady then
		TaskDispatcher.cancelTask(self.onVideoOverTime, self)
		TaskDispatcher.runDelay(self.onVideoOverTime, self, self._time)
		VideoController.instance:dispatchEvent(VideoEvent.OnVideoFirstFrameReady, self._videoPath)
	end
end

function FullScreenVideoView:onPlayVideoDone()
	if self.videoDone then
		return
	end

	self.videoDone = true

	TaskDispatcher.cancelTask(self.onVideoOverTime, self)

	if not self.waitViewOpen or ViewMgr.instance:isOpen(self.waitViewOpen) then
		self:closeThis()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onViewOpen, self)
	end

	if self.doneCb then
		self.doneCb(self.doneCbObj)
	end

	VideoController.instance:dispatchEvent(VideoEvent.OnVideoPlayFinished)
end

function FullScreenVideoView:onVideoOverTime()
	self:onPlayVideoDone()
end

function FullScreenVideoView:_onViewOpen(viewName)
	if self.waitViewOpen == viewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onViewOpen, self)
		self:closeThis()
	end
end

function FullScreenVideoView:onDestroyView()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onViewOpen, self)
	TaskDispatcher.cancelTask(self.onVideoOverTime, self)

	if self._setVideoPlayer then
		self._setVideoPlayer(self.doneCbObj, self._videoPlayer, self.videoGo)

		self._setVideoPlayer = nil
		self._videoPlayer = nil
	end

	if self._videoPlayer then
		self._videoPlayer = nil
	end

	self.doneCb = nil
	self.doneCbObj = nil
end

return FullScreenVideoView
