-- chunkname: @modules/common/others/scrollaudio/ScrollAudioComp.lua

module("modules.common.others.scrollaudio.ScrollAudioComp", package.seeall)

local ScrollAudioComp = class("ScrollAudioComp", LuaCompBase)

function ScrollAudioComp:ctor(param)
	self.param = param or ScrollAudioParam.New()
	self._scrollSfxDuration = self.param.defaultSfxRepeatTime
	self._isDraging = true
	self._isDisposed = false
end

function ScrollAudioComp:init(go)
	self._scroll = gohelper.findChildScrollRect(go, "")
	self._drag = SLFramework.UGUI.UIDragListener.Get(go)

	self._drag:AddDragBeginListener(self.onDragBegin, self)
	self._drag:AddDragEndListener(self.onDragEnd, self)

	self._click = SLFramework.UGUI.UIClickListener.Get(go)

	self._click:AddClickDownListener(self.onClickDown, self)
end

function ScrollAudioComp:onDragBegin()
	self._isDraging = true

	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
	self:_resetPlayingStatus()
end

function ScrollAudioComp:onDragEnd()
	self:onUpdate()

	self._isDraging = false
end

function ScrollAudioComp:onClickDown()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_start)
end

function ScrollAudioComp:onUpdate()
	if self._scroll and not self._isDisposed then
		local curPos = self.param.scrollDir == ScrollEnum.ScrollDirH and recthelper.getAnchorX(self._scroll.content) * self.param.pixelOffsetMoveFactor or recthelper.getAnchorY(self._scroll.content) * self.param.pixelOffsetMoveFactor

		self:_onValueChangeForStartOrStop(curPos)
		self:_onValueChangeCheckReplay(curPos)
		self:_onValueChangeSampleOffset(curPos)
	end
end

function ScrollAudioComp:_onValueChangeSampleOffset(x)
	if self._scrollAudioTime and self._scrollSampleOffset then
		local deltaTime = Time.realtimeSinceStartup - self._scrollAudioTime

		if deltaTime >= self.param.intervalSampleOffset then
			self:_onUpdateRTPCSpeed(x)

			self._scrollAudioTime = Time.realtimeSinceStartup
			self._scrollSampleOffset = x
		end
	else
		self._scrollAudioTime = Time.realtimeSinceStartup
		self._scrollSampleOffset = x
	end
end

function ScrollAudioComp:_onUpdateRTPCSpeed(x)
	local deltaPosX = math.abs(x - self._scrollSampleOffset)

	self._scrollSfxDuration = (self._scrollSfxDuration + self.param.defaultSfxRepeatTime + (deltaPosX - 0.5) * self.param.speedUpTweenTime) * 0.5

	local value = deltaPosX * self.param.speedFactor

	if self._lastRtpcValue == value then
		return
	end

	self._lastRtpcValue = value

	AudioMgr.instance:setRTPCValue(AudioEnum.UI.RTPC_ui_checkpoint_movespeed, self._lastRtpcValue)
end

function ScrollAudioComp:_onValueChangeForStartOrStop(value)
	if self._scrollingPlayPos and self._scrollAudioStopTime then
		local deltaTime = Time.realtimeSinceStartup - self._scrollAudioStopTime

		if deltaTime > self.param.intervalSampleStop then
			local deltaPos = math.abs(value - self._scrollingPlayPos)
			local startOffset = self.param.startPlayOffset
			local stopOffset = self.param.stopPlayOffset

			if self._isDraging then
				startOffset = self.param.startPlayOffsetDraging
				stopOffset = self.param.stopPlayOffsetDraging
			end

			if startOffset <= deltaPos and not self._isScrollPlaying then
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain)
				self:_onUpdateRTPCSpeed(value)

				self._scrollPlayingStartTime = Time.realtimeSinceStartup
				self._isScrollPlaying = true
				self._isFirstTimeDragPlay = false
			end

			if deltaPos < stopOffset and self._isScrollPlaying then
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
				self:_resetPlayingStatus(value)
			end

			self._scrollingPlayPos = value
			self._scrollAudioStopTime = Time.realtimeSinceStartup
		end
	else
		self._scrollAudioStopTime = Time.realtimeSinceStartup
		self._scrollingPlayPos = value
	end
end

function ScrollAudioComp:_onValueChangeCheckReplay(value)
	if self._isScrollPlaying and self._scrollPlayingStartTime and self._scrollSampleOffset then
		local passTime = Time.realtimeSinceStartup - self._scrollPlayingStartTime

		if passTime >= self._scrollSfxDuration then
			self:_resetPlayingStatus(value)
		end
	end
end

function ScrollAudioComp:_resetPlayingStatus(value)
	self._isScrollPlaying = false
	self._scrollingPlayPos = value
end

function ScrollAudioComp:dispose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)

	self._isDisposed = true
	self._scroll = nil
end

function ScrollAudioComp:onDestroy()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()

	self._drag = nil

	self._click:RemoveClickDownListener()

	self._click = nil
	self._scroll = nil
end

return ScrollAudioComp
