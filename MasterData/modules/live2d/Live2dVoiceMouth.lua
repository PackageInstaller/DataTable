-- chunkname: @modules/live2d/Live2dVoiceMouth.lua

module("modules.live2d.Live2dVoiceMouth", package.seeall)

local Live2dVoiceMouth = class("Live2dVoiceMouth", SpineVoiceMouth)

function Live2dVoiceMouth:removeTaskActions()
	Live2dVoiceMouth.super.removeTaskActions(self)
	TaskDispatcher.cancelTask(self._delayPlayMouthActionList, self)
end

function Live2dVoiceMouth:_checkPlayMouthActionList(mouth)
	TaskDispatcher.cancelTask(self._delayPlayMouthActionList, self)

	self._mouthConfig = mouth

	if self._stopTime and Time.time - self._stopTime < 0.1 then
		TaskDispatcher.runDelay(self._delayPlayMouthActionList, self, 0.1 - (Time.time - self._stopTime))

		return
	end

	self:_playMouthActionList(mouth)
end

function Live2dVoiceMouth:_delayPlayMouthActionList()
	self:_playMouthActionList(self._mouthConfig)
end

function Live2dVoiceMouth:stopMouthCallback(force)
	self:stopMouth()
end

function Live2dVoiceMouth:_setBiZui()
	if self._isVoiceStop and self._pauseMouth and self._pauseMouth ~= self._spine:getCurMouth() then
		self._curMouth = "t_" .. self._pauseMouth
		self._pauseMouth = nil

		self._spine:setMouthAnimation(self._curMouth, false, 0)

		return
	end

	if self._spine:hasAnimation(StoryAnimName.T_BiZui) then
		self._curMouth = StoryAnimName.T_BiZui

		self._spine:setMouthAnimation(self._curMouth, true, 0)
	else
		logError("no animation:t_bizui")
	end
end

function Live2dVoiceMouth:onVoiceStop()
	self._isVoiceStop = true
	self._stopTime = Time.time

	self:stopMouth()
	self:removeTaskActions()

	self._isVoiceStop = false
end

function Live2dVoiceMouth:suspend()
	self:removeTaskActions()
end

return Live2dVoiceMouth
