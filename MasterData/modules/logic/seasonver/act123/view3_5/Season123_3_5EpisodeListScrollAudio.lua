-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EpisodeListScrollAudio.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EpisodeListScrollAudio", package.seeall)

local Season123_3_5EpisodeListScrollAudio = class("Season123_3_5EpisodeListScrollAudio", LuaCompBase)

function Season123_3_5EpisodeListScrollAudio:ctor(param)
	self.scroll = param
	self._contentWidth = recthelper.getHeight(self.scroll.content)
	self._intervalSampleOffset = 0.1
	self._intervalSampleStop = 0.1
	self._startPlayOffset = 0.81
	self._startPlayOffsetDraging = 0.08
	self._stopPlayOffset = 0.8
	self._stopPlayOffsetDraging = 0.075
	self._defaultSfxRepeatTime = 6
	self._speedUpTweenTime = 2
	self._pixelOffsetMoveFactor = 0.03
	self._normalizeOffsetMoveFactor = 280
	self._speedFactor = 0.7
	self._scrollSfxDuration = self._defaultSfxRepeatTime
	self._isDraging = true
	self._isDisposed = false
end

function Season123_3_5EpisodeListScrollAudio:onDragBegin()
	self._isDraging = true

	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
	self:_resetPlayingStatus()
end

function Season123_3_5EpisodeListScrollAudio:onDragEnd()
	self:onUpdate()

	self._isDraging = false
end

function Season123_3_5EpisodeListScrollAudio:onClickDown()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_start)
end

function Season123_3_5EpisodeListScrollAudio:onUpdate()
	if self.scroll and not self._isDisposed then
		local curY = recthelper.getAnchorY(self.scroll.content) * self._pixelOffsetMoveFactor

		self:_onValueChangeForStartOrStop(curY)
		self:_onValueChangeCheckReplay(curY)
		self:_onValueChangeSampleOffset(curY)
	end
end

function Season123_3_5EpisodeListScrollAudio:_onValueChangeSampleOffset(y)
	if self._scrollAudioTime and self._scrollSampleOffset then
		local deltaTime = Time.realtimeSinceStartup - self._scrollAudioTime

		if deltaTime >= self._intervalSampleOffset then
			self:_onUpdateRTPCSpeed(y)

			self._scrollAudioTime = Time.realtimeSinceStartup
			self._scrollSampleOffset = y
		end
	else
		self._scrollAudioTime = Time.realtimeSinceStartup
		self._scrollSampleOffset = y
	end
end

function Season123_3_5EpisodeListScrollAudio:_onUpdateRTPCSpeed(y)
	local deltaPosY = math.abs(y - self._scrollSampleOffset)

	self._scrollSfxDuration = (self._scrollSfxDuration + self._defaultSfxRepeatTime + (deltaPosY - 0.5) * self._speedUpTweenTime) * 0.5

	local value = deltaPosY * self._speedFactor

	if self._lastRtpcValue == value then
		return
	end

	self._lastRtpcValue = value

	AudioMgr.instance:setRTPCValue(AudioEnum.UI.RTPC_ui_checkpoint_movespeed, self._lastRtpcValue)
end

function Season123_3_5EpisodeListScrollAudio:_onValueChangeForStartOrStop(y)
	if self._scrollingPlayY and self._scrollAudioStopTime then
		local deltaTime = Time.realtimeSinceStartup - self._scrollAudioStopTime

		if deltaTime > self._intervalSampleStop then
			local deltaPosX = math.abs(y - self._scrollingPlayY)
			local startOffset = self._startPlayOffset
			local stopOffset = self._stopPlayOffset

			if self._isDraging then
				startOffset = self._startPlayOffsetDraging
				stopOffset = self._stopPlayOffsetDraging
			end

			if startOffset <= deltaPosX and not self._isScrollPlaying then
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain)
				self:_onUpdateRTPCSpeed(y)

				self._scrollPlayingStartTime = Time.realtimeSinceStartup
				self._isScrollPlaying = true
				self._isFirstTimeDragPlay = false
			end

			if deltaPosX < stopOffset and self._isScrollPlaying then
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
				self:_resetPlayingStatus(y)
			end

			self._scrollingPlayY = y
			self._scrollAudioStopTime = Time.realtimeSinceStartup
		end
	else
		self._scrollAudioStopTime = Time.realtimeSinceStartup
		self._scrollingPlayY = y
	end
end

function Season123_3_5EpisodeListScrollAudio:_onValueChangeCheckReplay(y)
	if self._isScrollPlaying and self._scrollPlayingStartTime and self._scrollSampleOffset then
		local passTime = Time.realtimeSinceStartup - self._scrollPlayingStartTime

		if passTime >= self._scrollSfxDuration then
			self:_resetPlayingStatus(y)
		end
	end
end

function Season123_3_5EpisodeListScrollAudio:_resetPlayingStatus(y)
	self._isScrollPlaying = false
	self._scrollingPlayY = y
end

function Season123_3_5EpisodeListScrollAudio:dispose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)

	self._isDisposed = true
	self.scroll = nil
end

function Season123_3_5EpisodeListScrollAudio:onDestroy()
	self.scroll = nil
end

return Season123_3_5EpisodeListScrollAudio
