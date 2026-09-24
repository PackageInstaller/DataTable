-- chunkname: @modules/logic/story/view/StoryVideoItem.lua

module("modules.logic.story.view.StoryVideoItem", package.seeall)

local StoryVideoItem = class("StoryVideoItem")

function StoryVideoItem:init(go, name, co)
	self._videoName = name

	self:reset(go, co)
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

	local delayTime = self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if delayTime < 0.1 then
		self:_build()

		return
	end

	TaskDispatcher.runDelay(self._build, self, delayTime)
end

function StoryVideoItem:_build()
	if gohelper.isNil(self._videoGo) then
		self._videoPlayer, self._videoGo = VideoPlayerMgr.instance:createGoAndVideoPlayer(self.viewGO, "videoTest")
	end

	if string.find(self._videoName, "3_7_xran_jh") then
		gohelper.setAsFirstSibling(self._videoGo)
	end

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

	self:_playVideo()
end

function StoryVideoItem:_playVideo()
	StoryModel.instance:setSpecialVideoPlaying(self._videoName)

	if self._videoPlayer then
		self._videoPlayer:play(self._videoName, self._loop, self._onVideoEvent, self)
	end

	self:playInEffect()
end

function StoryVideoItem:destroyVideo(co)
	self._videoCo = co

	if self._videoName == "3_7_xran_jh" then
		self.fadeTween(self, 1, 0, 2, self._realDestroy, self)

		return
	end

	TaskDispatcher.cancelTask(self._build, self)
	TaskDispatcher.cancelTask(self._realDestroy, self)

	if self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_realDestroy()

		return
	end

	TaskDispatcher.runDelay(self._realDestroy, self, self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryVideoItem:playInEffect()
	local effectTime = self._videoCo.effectTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or 0

	if self._videoCo.effectType == StoryEnum.VideoEffectType.FadeIn then
		self:fadeTween(0, 1, effectTime)
	end

	if self._videoCo.effectType == StoryEnum.VideoEffectType.LoopFade then
		if self._videoFadeOutTweenId then
			effectTime = tonumber(self._videoCo.effectParam) or 0
		end

		self:fadeTween(0, 1, effectTime)
	end
end

function StoryVideoItem:fadeTween(startAlpha, endAlpha, duration, finishCallback, finishCallbackObj)
	if self._videoFadeTweenId then
		ZProj.TweenHelper.KillById(self._videoFadeTweenId)

		self._videoFadeTweenId = nil
	end

	self._videoFadeTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(self._videoGo, startAlpha, endAlpha, duration, finishCallback, finishCallbackObj)
end

function StoryVideoItem:_onVideoEvent(path, status, errorCode)
	if self.isDestorying then
		return
	end

	if status == AvProEnum.PlayerStatus.Started and self._loop and self._videoCo.effectType == StoryEnum.VideoEffectType.LoopFade then
		local effectTime = tonumber(self._videoCo.effectParam) or 0
		local startTime, duration, curTime = self._videoPlayer:getTimeRange()
		local delayTime = duration - curTime - effectTime

		TaskDispatcher.cancelTask(self.playLoopFade, self)
		TaskDispatcher.runDelay(self.playLoopFade, self, delayTime)
	end
end

function StoryVideoItem:playLoopFade()
	if self.isDestorying then
		return
	end

	local effectTime = tonumber(self._videoCo.effectParam) or 0

	self:onLoopFadeOutFinish()

	self._loopFadeOutVideo = self._videoPlayer
	self._loopFadeOutVideoGO = self._videoGo
	self._videoPlayer = nil
	self._videoGo = nil
	self._videoFadeOutTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(self._loopFadeOutVideoGO, 1, 0, effectTime, self.onLoopFadeOutFinish, self)

	self:_build()
end

function StoryVideoItem:onLoopFadeOutFinish()
	if self._videoFadeOutTweenId then
		ZProj.TweenHelper.KillById(self._videoFadeOutTweenId)

		self._videoFadeOutTweenId = nil
	end

	if self._loopFadeOutVideo then
		self._loopFadeOutVideo:stop()

		self._loopFadeOutVideo = nil
	end

	gohelper.destroy(self._loopFadeOutVideoGO)

	self._loopFadeOutVideoGO = nil
end

function StoryVideoItem:_realDestroy()
	self.isDestorying = true

	local effectTime = self._videoCo.effectTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or 0

	if self._videoCo.effectType == StoryEnum.VideoEffectType.FadeOut or self._videoCo.effectType == StoryEnum.VideoEffectType.LoopFade then
		self.fadeTween(self, 1, 0, effectTime, self.onDestroy, self)

		return
	end

	self:onDestroy()
end

function StoryVideoItem:onDestroy()
	if self._videoFadeTweenId then
		ZProj.TweenHelper.KillById(self._videoFadeTweenId)

		self._videoFadeTweenId = nil
	end

	TaskDispatcher.cancelTask(self.playLoopFade, self)
	TaskDispatcher.cancelTask(self._realDestroy, self)
	TaskDispatcher.cancelTask(self._build, self)
	StoryModel.instance:setSpecialVideoEnd(self._videoName)

	if self._videoPlayer then
		self._videoPlayer:stop()
	end

	gohelper.destroy(self._videoGo)
	self:onLoopFadeOutFinish()
end

return StoryVideoItem
