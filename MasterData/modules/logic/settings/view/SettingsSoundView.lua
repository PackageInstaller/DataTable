-- chunkname: @modules/logic/settings/view/SettingsSoundView.lua

module("modules.logic.settings.view.SettingsSoundView", package.seeall)

local SettingsSoundView = class("SettingsSoundView", BaseView)

function SettingsSoundView:onInitView()
	local content = gohelper.findChild(self.viewGO, "SoundScroll/Viewport/Content")

	self._gomusic = gohelper.findChild(content, "#go_music")
	self._govoice = gohelper.findChild(content, "#go_voice")
	self._goeffect = gohelper.findChild(content, "#go_effect")
	self._goglobal = gohelper.findChild(content, "#go_global")
	self._gobackgroundsound = gohelper.findChild(content, "backgroundsound")
	self._btnbackgroundsoundswitch = gohelper.findChildButtonWithAudio(content, "backgroundsound/text/#btn_backgroundsoundswitch")
	self._gobackgroundsoundoff = gohelper.findChild(content, "backgroundsound/text/#btn_backgroundsoundswitch/#go_backgroundsoundoff")
	self._gobackgroundsoundon = gohelper.findChild(content, "backgroundsound/text/#btn_backgroundsoundswitch/#go_backgroundsoundon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsSoundView:addEvents()
	self._btnbackgroundsoundswitch:AddClickListener(self.__btnbackgroundsoundswitchOnClick, self)
end

function SettingsSoundView:removeEvents()
	self._btnbackgroundsoundswitch:RemoveClickListener()
end

SettingsSoundView.VoiceKeyEnum = {
	Global = 4,
	Effect = 3,
	Voice = 2,
	Music = 1
}

function SettingsSoundView:_editableInitView()
	self._itemTables = {}
	self._itemTables[SettingsSoundView.VoiceKeyEnum.Music] = self:_initItem(self._gomusic, SettingsSoundView.VoiceKeyEnum.Music)
	self._itemTables[SettingsSoundView.VoiceKeyEnum.Voice] = self:_initItem(self._govoice, SettingsSoundView.VoiceKeyEnum.Voice)
	self._itemTables[SettingsSoundView.VoiceKeyEnum.Effect] = self:_initItem(self._goeffect, SettingsSoundView.VoiceKeyEnum.Effect)
	self._itemTables[SettingsSoundView.VoiceKeyEnum.Global] = self:_initItem(self._goglobal, SettingsSoundView.VoiceKeyEnum.Global)

	gohelper.setActive(self._gobackgroundsound, BootNativeUtil.isWindows())
end

function SettingsSoundView:_initItem(go, key)
	local itemTable = self:getUserDataTb_()

	itemTable.slider = gohelper.findChildSlider(go, "slider")
	itemTable.sliderClick = gohelper.getClick(itemTable.slider.gameObject)

	itemTable.sliderClick:AddClickDownListener(function()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	end, self)
	itemTable.slider:SetValue(self:getVoiceValue(key))
	itemTable.slider:AddOnValueChanged(self.onSliderValueChanged, self, key)

	itemTable.txtvalue = gohelper.findChildText(go, "slider/area/handle/#txt_value")
	itemTable.key = key
	itemTable.txtvalue.text = self:getVoiceValue(key)

	return itemTable
end

function SettingsSoundView:onSliderValueChanged(voiceKey, value)
	if voiceKey == SettingsSoundView.VoiceKeyEnum.Music then
		SettingsModel.instance:setMusicValue(value)
	elseif voiceKey == SettingsSoundView.VoiceKeyEnum.Voice then
		SettingsModel.instance:setVoiceValue(value)
	elseif voiceKey == SettingsSoundView.VoiceKeyEnum.Effect then
		SettingsModel.instance:setEffectValue(value)
	elseif voiceKey == SettingsSoundView.VoiceKeyEnum.Global then
		SettingsModel.instance:setGlobalAudioVolume(value)
	end

	self._itemTables[voiceKey].txtvalue.text = value
end

function SettingsSoundView:getVoiceValue(voiceKey)
	if voiceKey == SettingsSoundView.VoiceKeyEnum.Music then
		return SettingsModel.instance:getMusicValue()
	elseif voiceKey == SettingsSoundView.VoiceKeyEnum.Voice then
		return SettingsModel.instance:getVoiceValue()
	elseif voiceKey == SettingsSoundView.VoiceKeyEnum.Effect then
		return SettingsModel.instance:getEffectValue()
	elseif voiceKey == SettingsSoundView.VoiceKeyEnum.Global then
		return SettingsModel.instance:getGlobalAudioVolume()
	else
		return 0
	end
end

function SettingsSoundView:__btnbackgroundsoundswitchOnClick()
	local activateDuringFocusLoss = PlayerPrefsHelper.getNumber(PlayerPrefsKey.WWise_SL_ActivateDuringFocusLoss, 0)

	activateDuringFocusLoss = activateDuringFocusLoss == 0 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.WWise_SL_ActivateDuringFocusLoss, activateDuringFocusLoss)
	self:_refreshgroundsound()
end

function SettingsSoundView:_refreshgroundsound()
	local activateDuringFocusLoss = PlayerPrefsHelper.getNumber(PlayerPrefsKey.WWise_SL_ActivateDuringFocusLoss, 0)

	gohelper.setActive(self._gobackgroundsoundoff, activateDuringFocusLoss == 0)
	gohelper.setActive(self._gobackgroundsoundon, activateDuringFocusLoss == 1)
end

function SettingsSoundView:onUpdateParam()
	self:_refreshgroundsound()
end

function SettingsSoundView:onOpen()
	self:_refreshgroundsound()
end

function SettingsSoundView:onClose()
	return
end

function SettingsSoundView:onDestroyView()
	for _, itemTable in ipairs(self._itemTables) do
		itemTable.sliderClick:RemoveClickDownListener()
		itemTable.slider:RemoveOnValueChanged()
	end
end

return SettingsSoundView
