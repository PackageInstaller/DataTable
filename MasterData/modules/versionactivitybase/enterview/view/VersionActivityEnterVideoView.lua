-- chunkname: @modules/versionactivitybase/enterview/view/VersionActivityEnterVideoView.lua

module("modules.versionactivitybase.enterview.view.VersionActivityEnterVideoView", package.seeall)

local VersionActivityEnterVideoView = class("VersionActivityEnterVideoView", BaseView)

function VersionActivityEnterVideoView:ctor(param)
	VersionActivityEnterVideoView.super.ctor(self)

	param = param or {}
	self._videoGOContainerPath = param.videoGOContainerPath
	self._loopVideoName = param.loopVideoName
	self._enterVideoName = param.enterVideoName
	self._enterVideoTime = param.enterVideoTime or 5
	self._audioId = param.audioId
	self._noVideoAudioId = param.noVideoAudioId
	self._bgmLayer = param.bgmLayer
end

function VersionActivityEnterVideoView:onInitView()
	self.viewAnim = gohelper.findComponentAnim(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityEnterVideoView:addEvents()
	return
end

function VersionActivityEnterVideoView:removeEvents()
	return
end

function VersionActivityEnterVideoView:_editableInitView()
	return
end

function VersionActivityEnterVideoView:onOpen()
	self:playOrLoadMedia()
end

function VersionActivityEnterVideoView:onOpenFinish()
	return
end

function VersionActivityEnterVideoView:getIsDirectOpen()
	return self.viewParam and self.viewParam.isDirectOpen
end

function VersionActivityEnterVideoView:getEnterVideoDayKey()
	return self.viewName
end

function VersionActivityEnterVideoView:playOrLoadMedia()
	self._needPlayVideo = self:needPlayFullScreenVideo()

	self:setAnimPause(true)

	if self._needPlayVideo then
		self:stopBgm()

		local enterVideoFirstKey = string.format("EnterVideoFirstKey_%s", self.viewName)
		local isCanSkip = GameUtil.playerPrefsGetNumberByUserId(enterVideoFirstKey, 0) ~= 0

		if not isCanSkip then
			GameUtil.playerPrefsSetNumberByUserId(enterVideoFirstKey, 1)
		end

		VideoController.instance:openFullScreenVideoView(self:getEnterVideoName(), nil, self:getFullScreenPlayTime(), nil, nil, {
			couldSkip = isCanSkip
		})

		local key = self:getEnterVideoDayKey()

		TimeUtil.setDayFirstLoginRed(key)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self.onPlayVideoStarted, self)
		self:getVideoComp():loadMedia(self:getLoopVideoName())
	else
		self:onFullScreenVideoPlayFinished()
	end
end

function VersionActivityEnterVideoView:needPlayFullScreenVideo()
	local isDirectOpen = self:getIsDirectOpen()
	local key = self:getEnterVideoDayKey()
	local isFirstLogin = TimeUtil.getDayFirstLoginRed(key)

	return not isDirectOpen and isFirstLogin
end

function VersionActivityEnterVideoView:getFullScreenPlayTime()
	return self._enterVideoTime
end

function VersionActivityEnterVideoView:onFullScreenVideoPlayFinished()
	self:refreshLoopVideo()
end

function VersionActivityEnterVideoView:refreshLoopVideo()
	local videoName = self:getLoopVideoName()

	if self._curLoopVideoName == videoName then
		return
	end

	self._curLoopVideoName = videoName

	self:getVideoComp():play(videoName, true)
	self:getVideoComp():setStartCallback(self.onLoopVideoStarted, self)
	TaskDispatcher.cancelTask(self.onVideoOverTime, self)
	TaskDispatcher.runDelay(self.onVideoOverTime, self, 2)
end

function VersionActivityEnterVideoView:onVideoOverTime()
	self:onLoopVideoStarted()
end

function VersionActivityEnterVideoView:onLoopVideoStarted()
	TaskDispatcher.cancelTask(self.onVideoOverTime, self)

	local animName = self._needPlayVideo and "open1" or "open"

	self:setAnimPause(false, animName)
	self:playBgm()
end

function VersionActivityEnterVideoView:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	self:onFullScreenVideoPlayFinished()
end

function VersionActivityEnterVideoView:onPlayVideoStarted()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self.onPlayVideoStarted, self)

	if self._audioId and self._audioId ~= 0 then
		AudioMgr.instance:trigger(self._audioId)
	end
end

function VersionActivityEnterVideoView:getVideoComp()
	if not self._videoComp then
		local go = gohelper.findChild(self.viewGO, self._videoGOContainerPath)

		self._videoComp = VersionActivityVideoComp.get(go, self)
	end

	return self._videoComp
end

function VersionActivityEnterVideoView:setAnimPause(pause, animName)
	self.viewAnim.speed = pause and 0 or 1

	if not pause then
		self.viewAnim:Play(animName)
	end
end

function VersionActivityEnterVideoView:playBgm()
	if self._hasPlayBgm then
		return
	end

	self._hasPlayBgm = true

	if self._bgmLayer and self._bgmLayer ~= 0 then
		AudioBgmManager.instance:playBgm(self._bgmLayer)
	end

	if self._noVideoAudioId and self._noVideoAudioId ~= 0 then
		AudioMgr.instance:trigger(self._noVideoAudioId)
	end
end

function VersionActivityEnterVideoView:stopBgm()
	if not self._hasPlayBgm then
		return
	end

	self._hasPlayBgm = false

	if self._bgmLayer and self._bgmLayer ~= 0 then
		AudioBgmManager.instance:stopBgm(self._bgmLayer)
	end
end

function VersionActivityEnterVideoView:getLoopVideoName()
	return self._loopVideoName
end

function VersionActivityEnterVideoView:getEnterVideoName()
	return self._enterVideoName
end

function VersionActivityEnterVideoView:onClose()
	if self._videoComp then
		self._videoComp:destroy()

		self._videoComp = nil
	end

	TaskDispatcher.cancelTask(self.onVideoOverTime, self)
end

return VersionActivityEnterVideoView
