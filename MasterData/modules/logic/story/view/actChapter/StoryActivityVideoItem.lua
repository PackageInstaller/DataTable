-- chunkname: @modules/logic/story/view/actChapter/StoryActivityVideoItem.lua

module("modules.logic.story.view.actChapter.StoryActivityVideoItem", package.seeall)

local StoryActivityVideoItem = class("StoryActivityVideoItem")

function StoryActivityVideoItem:ctor(go)
	self.viewGO = go
end

function StoryActivityVideoItem:playVideo(name, co)
	if name then
		local videoArgs = string.split(name, ".")

		self._videoName = videoArgs[1]
	else
		self._videoName = nil
	end

	co = co or {}
	self._loop = co.loop
	self._videoStartCallback = co.startCallback
	self._videoStartCallbackObj = co.startCallbackObj
	self._videoOutCallback = co.outCallback
	self._videoOutCallbackObj = co.outCallbackObj
	self._audioId = co.audioId
	self._audioNoStopByFinish = co.audioNoStopByFinish
	self._width = co.width or 2592
	self._height = co.height or 1080

	if self._videoName then
		if not self._videoGo then
			self:_build()
		end

		self:_playVideo()
	else
		self:onVideoStart()
	end
end

function StoryActivityVideoItem:_build()
	self._videoPlayer, self._videoGo = VideoPlayerMgr.instance:createGoAndVideoPlayer(self.viewGO, self._videoName, self._loop, self._width, self._height)

	self._videoPlayer:setEventListener(self._onVideoEvent, self)
end

function StoryActivityVideoItem:_playVideo()
	self._videoPlayer:loadMedia(self._videoName)
	StoryModel.instance:setSpecialVideoPlaying(self._videoName)
	TaskDispatcher.runDelay(self._startVideo, self, 0.1)

	if BootNativeUtil.isIOS() then
		TaskDispatcher.runRepeat(self._detectPause, self, 0.05)
	end
end

function StoryActivityVideoItem:_startVideo()
	self._videoPlayer:playLoadMedia(self._loop)
end

function StoryActivityVideoItem:onVideoStart()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end

	if self._videoStartCallback then
		self._videoStartCallback(self._videoStartCallbackObj, self)
	end
end

function StoryActivityVideoItem:onVideoOut(isFinishPlay)
	self:hide(isFinishPlay)

	if self._videoOutCallback then
		self._videoOutCallback(self._videoOutCallbackObj, self)
	end
end

function StoryActivityVideoItem:_onVideoEvent(path, status, errorCode)
	if errorCode ~= AvProEnum.ErrorCode.None then
		self:hide(true)
	end

	if status == VideoEnum.PlayerStatus.Started or status == VideoEnum.PlayerStatus.FinishedSeeking then
		self:onVideoStart()
	end

	if status == AvProEnum.PlayerStatus.FinishedPlaying and not self._loop then
		self:onVideoOut(true)
	end
end

function StoryActivityVideoItem:hide(isFinishPlay)
	if self._videoPlayer then
		self._videoPlayer:stop()
	end

	if BootNativeUtil.isIOS() then
		TaskDispatcher.cancelTask(self._detectPause, self)
	end

	if isFinishPlay then
		if not self._audioNoStopByFinish then
			self:stopAudio()
		end
	else
		self:stopAudio()
	end
end

function StoryActivityVideoItem:_detectPause()
	if self._videoPlayer:isPaused() then
		self:_startVideo()
	end
end

function StoryActivityVideoItem:stopAudio()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityVideoItem:onDestroy()
	if self._videoName then
		StoryModel.instance:setSpecialVideoEnd(self._videoName)
	end

	if self._videoPlayer ~= nil then
		self._videoPlayer:clear()

		self._videoPlayer = nil
	end

	if BootNativeUtil.isIOS() then
		TaskDispatcher.cancelTask(self._detectPause, self)
	end

	self._videoOutCallback = nil
	self._videoOutCallbackObj = nil
	self._videoStartCallback = nil
	self._videoStartCallbackObj = nil

	self:stopAudio()
end

return StoryActivityVideoItem
