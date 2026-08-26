-- chunkname: @modules/logic/story/view/StoryVideoItem.lua

module("modules.logic.story.view.StoryVideoItem", package.seeall)

local StoryVideoItem = class("StoryVideoItem")

function StoryVideoItem:init(go, name, co, startCallBack, startCallBackObj)
	self.viewGO = go
	self._videoName = name
	self._videoCo = co
	self._loop = co.loop
	self._startCallBack = startCallBack
	self._startCallBackObj = startCallBackObj
	self._videoPlayer, self._videoGo = VideoPlayerMgr.instance:createGoAndVideoPlayer(self.viewGO, "videoTest")

	if string.find(self._videoName, "3_7_xran_jh") then
		gohelper.setAsFirstSibling(self._videoGo)
	end

	self:_build()
end

function StoryVideoItem:pause(pause)
	if pause then
		self._videoPlayer:pause()
	else
		self._videoPlayer:continue()
	end
end

function StoryVideoItem:reset(go, co)
	self.viewGO = go
	self._videoCo = co
	self._loop = co.loop

	TaskDispatcher.cancelTask(self._playVideo, self)

	if self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_playVideo()

		return
	end

	TaskDispatcher.runDelay(self._playVideo, self, self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryVideoItem:_build()
	local videoArgs = string.split(self._videoName, ".")

	self._videoName = videoArgs[1]

	local isOverseas = SettingsModel.instance:isOverseas()

	if not isOverseas and self._videoName == "xuzhangkaichangpv" and BootNativeUtil.isWindows() then
		local width, height = BootNativeUtil.getDisplayResolution()

		if height >= 2160 then
			self._videoName = "xuzhangkaichangpv_4k"
		elseif height >= 1440 then
			self._videoName = "xuzhangkaichangpv_2k"
		end
	end

	TaskDispatcher.cancelTask(self._playVideo, self)

	if self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_playVideo()

		return
	end

	TaskDispatcher.runDelay(self._playVideo, self, self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryVideoItem:_playVideo()
	StoryModel.instance:setSpecialVideoPlaying(self._videoName)

	if self._videoPlayer then
		self._videoPlayer:play(self._videoName, self._loop, self._startCallBack, self._startCallBackObj)
	end
end

function StoryVideoItem:destroyVideo(co)
	self._videoCo = co

	if self._videoName == "3_7_xran_jh" then
		self._videoFadeTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(self._videoGo, 1, 0, 2, self._realDestroy, self)

		return
	end

	TaskDispatcher.cancelTask(self._playVideo, self)
	TaskDispatcher.cancelTask(self._realDestroy, self)

	if self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_realDestroy()

		return
	end

	TaskDispatcher.runDelay(self._realDestroy, self, self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryVideoItem:_realDestroy()
	self:onDestroy()
end

function StoryVideoItem:onDestroy()
	if self._videoFadeTweenId then
		ZProj.TweenHelper.KillById(self._videoFadeTweenId)

		self._videoFadeTweenId = nil
	end

	TaskDispatcher.cancelTask(self._realDestroy, self)
	TaskDispatcher.cancelTask(self._playVideo, self)
	StoryModel.instance:setSpecialVideoEnd(self._videoName)

	if self._videoPlayer then
		self._videoPlayer:stop()
	end

	gohelper.destroy(self._videoGo)
end

return StoryVideoItem
