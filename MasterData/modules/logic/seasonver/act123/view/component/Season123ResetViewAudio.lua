-- chunkname: @modules/logic/seasonver/act123/view/component/Season123ResetViewAudio.lua

module("modules.logic.seasonver.act123.view.component.Season123ResetViewAudio", package.seeall)

local Season123ResetViewAudio = class("Season123ResetViewAudio", LuaCompBase)

function Season123ResetViewAudio:ctor(param)
	self.scroll = param
	self._contentWidth = self.scroll.content and recthelper.getWidth(self.scroll.content) or recthelper.getWidth(self.scroll.transform)
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

function Season123ResetViewAudio:onDragBegin()
	self._isDraging = true

	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
	self:_resetPlayingStatus()
end

function Season123ResetViewAudio:onDragEnd()
	self:onUpdate()

	self._isDraging = false
end

function Season123ResetViewAudio:onClickDown()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_start)
end

function Season123ResetViewAudio:onUpdate()
	if self.scroll and not self._isDisposed then
		local curX = recthelper.getAnchorX(self.scroll.content) * self._pixelOffsetMoveFactor

		self:_onValueChangeForStartOrStop(curX)
		self:_onValueChangeCheckReplay(curX)
		self:_onValueChangeSampleOffset(curX)
	end
end

function Season123ResetViewAudio:_onValueChangeSampleOffset(x)
	if self._scrollAudioTime and self._scrollSampleOffset then
		local deltaTime = Time.realtimeSinceStartup - self._scrollAudioTime

		if deltaTime >= self._intervalSampleOffset then
			self:_onUpdateRTPCSpeed(x)

			self._scrollAudioTime = Time.realtimeSinceStartup
			self._scrollSampleOffset = x
		end
	else
		self._scrollAudioTime = Time.realtimeSinceStartup
		self._scrollSampleOffset = x
	end
end

function Season123ResetViewAudio:_onUpdateRTPCSpeed(x)
	local deltaPosX = math.abs(x - self._scrollSampleOffset)

	self._scrollSfxDuration = (self._scrollSfxDuration + self._defaultSfxRepeatTime + (deltaPosX - 0.5) * self._speedUpTweenTime) * 0.5

	local value = deltaPosX * self._speedFactor

	if self._lastRtpcValue == value then
		return
	end

	self._lastRtpcValue = value

	AudioMgr.instance:setRTPCValue(AudioEnum.UI.RTPC_ui_checkpoint_movespeed, self._lastRtpcValue)
end

function Season123ResetViewAudio:_onValueChangeForStartOrStop(x)
	if self._scrollingPlayX and self._scrollAudioStopTime then
		local deltaTime = Time.realtimeSinceStartup - self._scrollAudioStopTime

		if deltaTime > self._intervalSampleStop then
			local deltaPosX = math.abs(x - self._scrollingPlayX)
			local startOffset = self._startPlayOffset
			local stopOffset = self._stopPlayOffset

			if self._isDraging then
				startOffset = self._startPlayOffsetDraging
				stopOffset = self._stopPlayOffsetDraging
			end

			if startOffset <= deltaPosX and not self._isScrollPlaying then
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain)
				self:_onUpdateRTPCSpeed(x)

				self._scrollPlayingStartTime = Time.realtimeSinceStartup
				self._isScrollPlaying = true
				self._isFirstTimeDragPlay = false
			end

			if deltaPosX < stopOffset and self._isScrollPlaying then
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
				self:_resetPlayingStatus(x)
			end

			self._scrollingPlayX = x
			self._scrollAudioStopTime = Time.realtimeSinceStartup
		end
	else
		self._scrollAudioStopTime = Time.realtimeSinceStartup
		self._scrollingPlayX = x
	end
end

function Season123ResetViewAudio:_onValueChangeCheckReplay(x)
	if self._isScrollPlaying and self._scrollPlayingStartTime and self._scrollSampleOffset then
		local passTime = Time.realtimeSinceStartup - self._scrollPlayingStartTime

		if passTime >= self._scrollSfxDuration then
			self:_resetPlayingStatus(x)
		end
	end
end

function Season123ResetViewAudio:_resetPlayingStatus(x)
	self._isScrollPlaying = false
	self._scrollingPlayX = x
end

function Season123ResetViewAudio:dispose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)

	self._isDisposed = true
	self.scroll = nil
end

function Season123ResetViewAudio:onDestroy()
	self.scroll = nil
end

return Season123ResetViewAudio
