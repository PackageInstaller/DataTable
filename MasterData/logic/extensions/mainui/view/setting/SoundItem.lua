-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/setting/SoundItem.lua

module("logic.extensions.mainui.view.setting.SoundItem", package.seeall)

local M = class("SoundItem")

function M:ctor(container)
	local go = container.gameObject

	self._slider = UIComponentType.SliderAdapter(goutil.findChild(go, "slider"))
	self._btnMute = UIComponentType.ButtonAdapter(goutil.findChild(go, "muteType"))
	self._btnVoice = UIComponentType.ButtonAdapter(goutil.findChild(go, "voicedType"))
	self._goMuteType1 = goutil.findChild(go, "muteType/type1")
	self._goMuteType2 = goutil.findChild(go, "muteType/type2")
	self._goVoiceType1 = goutil.findChild(go, "voicedType/type1")
	self._goVoiceType2 = goutil.findChild(go, "voicedType/type2")

	self._btnMute:AddClickListener(self.onMute, self)
	self._btnVoice:AddClickListener(self.onVoiced, self)
	self._slider:AddOnValueChanged(self._onSliderChange, self)
	goutil.setActive(self._goMuteType1, true)
	goutil.setActive(self._goMuteType2, false)
	goutil.setActive(self._goVoiceType1, true)
	goutil.setActive(self._goVoiceType2, false)
end

function M:setAudioType(audioType)
	self._audioType = audioType
end

function M:setValueChangeCallback(callback, handler)
	self._valueChangeCallback = callback
	self._valueChangeCallbackHandler = handler
end

function M:onMute()
	self._slider:SetValue(0)
end

function M:setValue(value)
	self._slider:SetValue(value)
end

function M:getValue()
	return self._slider:GetValue()
end

function M:setHistoryValue()
	local value = 1

	if self._audioType == CriwareAudioFacade.AudioType.BGM then
		value = PlayerLocalStorageModel.instance:getBgmVolumeHistory()
	elseif self._audioType == CriwareAudioFacade.AudioType.SE then
		value = PlayerLocalStorageModel.instance:getSoundEffVolumeHistory()
	elseif self._audioType == CriwareAudioFacade.AudioType.VOICE then
		value = PlayerLocalStorageModel.instance:getDubVolumeHistory()
	end

	self:setValue(value)
end

function M:onVoiced()
	self._slider:SetValue(1)
end

function M:_onSliderChange(sliderValue)
	self._lastSoundValue = sliderValue
	self._isSliderChange = true

	if self._audioType == CriwareAudioFacade.AudioType.BGM then
		PlayerLocalStorageModel.instance:setBgmVolume(sliderValue)
	elseif self._audioType == CriwareAudioFacade.AudioType.SE then
		PlayerLocalStorageModel.instance:setSoundEffVolume(sliderValue)
	elseif self._audioType == CriwareAudioFacade.AudioType.VOICE then
		PlayerLocalStorageModel.instance:setDubVolume(sliderValue)
	end

	CriwareAudioFacade.instance:setVolume(self._audioType, sliderValue)

	if self._valueChangeCallback then
		self._valueChangeCallback(self._valueChangeCallbackHandler)
	end
end

function M:OnDestroy()
	self._btnMute:RemoveClickListener()
	self._btnVoice:RemoveClickListener()
	self._slider:RemoveOnValueChanged()
end

return M
