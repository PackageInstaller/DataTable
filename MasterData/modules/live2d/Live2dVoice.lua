-- chunkname: @modules/live2d/Live2dVoice.lua

module("modules.live2d.Live2dVoice", package.seeall)

local Live2dVoice = class("Live2dVoice", SpineVoice)

function Live2dVoice:_init()
	self._normalVoiceMouth = self:_addComponent(Live2dVoiceMouth, true)
	self._spineVoiceMouth = self._normalVoiceMouth
	self._voiceFace = self:_addComponent(Live2dVoiceFace, true)
end

function Live2dVoice:getMouth(voiceCo)
	local shortcut = self:getVoiceLang()

	if shortcut == "zh" then
		return voiceCo.mouth
	else
		return voiceCo[shortcut .. "mouth"] or voiceCo.mouth
	end
end

function Live2dVoice:_initSpineVoiceMouth(voiceConfig, spine)
	local mouth = self:getMouth(voiceConfig)

	self._useAutoMouth = string.find(mouth, Live2dVoiceMouthAuto.AutoActionName)

	local prevMouth = self._spineVoiceMouth

	if self._useAutoMouth then
		self._autoVoiceMouth = self._autoVoiceMouth or Live2dVoiceMouthAuto.New()
		self._spineVoiceMouth = self._autoVoiceMouth
	else
		self._spineVoiceMouth = self._normalVoiceMouth
	end

	if prevMouth and prevMouth ~= self._spineVoiceMouth then
		prevMouth:suspend()

		if self:getInStory() and prevMouth == self._autoVoiceMouth then
			local mouth = self._autoVoiceMouth:getMouth(voiceConfig)

			if string.nilorempty(mouth) then
				prevMouth:_setBiZui()
			end
		end
	end

	self._spineVoiceMouth:init(self, voiceConfig, spine)
end

function Live2dVoice:onSpineVoiceAudioStop()
	self._spineVoiceText:onVoiceStop()

	if self._useAutoMouth then
		self._spineVoiceMouth:onVoiceStop()
	end

	self:_doCallback()
end

function Live2dVoice:playVoice(spine, voiceConfig, callback, txtContent, txtEnContent, bgGo)
	self._spine = spine

	spine:setParameterStoreEnabled(true)

	if self:getInStory() then
		self._spine:setAlwaysFade(true)
	end

	Live2dVoice.super.playVoice(self, spine, voiceConfig, callback, txtContent, txtEnContent, bgGo)
end

function Live2dVoice:_onComponentStop(component)
	if component == self._spineVoiceBody and self._spine and self:getInStory() then
		self._spine:setAlwaysFade(false)
	end

	Live2dVoice.super._onComponentStop(self, component)
end

function Live2dVoice:playing()
	if self._spineVoiceMouth._setComponentStop then
		return Live2dVoice.super.playing(self)
	end

	if self._useAutoMouth then
		return self._stopVoiceCount < self._componentStopVoiceCount - 1
	end

	return self._stopVoiceCount < self._componentStopVoiceCount - 1 or not self._spineVoiceMouth._playLastOne
end

function Live2dVoice:onDestroy()
	if self._normalVoiceMouth then
		self._normalVoiceMouth:onDestroy()

		self._normalVoiceMouth = nil
	end

	if self._autoVoiceMouth then
		self._autoVoiceMouth:onDestroy()

		self._autoVoiceMouth = nil
	end

	self._spineVoiceMouth = nil

	Live2dVoice.super.onDestroy(self)
end

return Live2dVoice
