-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/setting/SoundSettingView.lua

module("logic.extensions.mainui.view.setting.SoundSettingView", package.seeall)

local M = class("SoundSettingView", ViewComponent)

function M:buildUI()
	self._toggleAllSound = self:getUIComponent("main_setting_tips_-411502280", UIComponentType.SpaceXToggle)

	local soundPanel = self:getGo("main_setting_tips_-395742732")
	local bgm = Astral.LuaComponentContainer.Add(goutil.findChild(soundPanel, "viewPort/content/element12/bgm"), SoundItem)
	local sound = Astral.LuaComponentContainer.Add(goutil.findChild(soundPanel, "viewPort/content/element12/sound"), SoundItem)
	local dub = Astral.LuaComponentContainer.Add(goutil.findChild(soundPanel, "viewPort/content/element12/dub"), SoundItem)

	bgm:setAudioType(CriwareAudioFacade.AudioType.BGM)
	sound:setAudioType(CriwareAudioFacade.AudioType.SE)
	dub:setAudioType(CriwareAudioFacade.AudioType.VOICE)
	bgm:setValueChangeCallback(self.onItemValueChange, self)
	sound:setValueChangeCallback(self.onItemValueChange, self)
	dub:setValueChangeCallback(self.onItemValueChange, self)

	self._allSoundItems = {
		bgm,
		sound,
		dub
	}
end

function M:onItemValueChange()
	local isSoundOn = false

	for k, v in pairs(self._allSoundItems) do
		isSoundOn = isSoundOn or v:getValue() > 0
	end

	PlayerLocalStorageModel.instance:setSoundMainSwitch(isSoundOn)
	self._toggleAllSound:ForceSetOn(isSoundOn)
end

function M:destroyUI()
	self._toggleAllSound = nil
end

function M:bindEvents()
	self._toggleAllSound:AddListener(self._onToggleAllSound, self)
end

function M:unbindEvents()
	self._toggleAllSound:RemoveListener()
end

function M:onEnter()
	self:setEvent(true)
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.SETTING_TAB_CHANGE, self._onSettingTabChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SETTING_TAB_CHANGE, self._onSettingTabChange, self)
	end
end

function M:_onSettingTabChange()
	self:syncSetting()
end

function M:syncSetting()
	local bgmVolume = PlayerLocalStorageModel.instance:getBgmVolume()

	self._allSoundItems[1]:setValue(bgmVolume)

	local soundEffVolume = PlayerLocalStorageModel.instance:getSoundEffVolume()

	self._allSoundItems[2]:setValue(soundEffVolume)

	local dubVolume = PlayerLocalStorageModel.instance:getDubVolume()

	self._allSoundItems[3]:setValue(dubVolume)

	local soundMainSwitch = PlayerLocalStorageModel.instance:getSoundMainSwitch()

	self._toggleAllSound:ForceSetOn(soundMainSwitch)
end

function M:_onToggleAllSound(index, isOn)
	local isAllZero = true

	for k, v in pairs(self._allSoundItems) do
		if isOn then
			isAllZero = isAllZero and v:getValue() == 0
		else
			v:setValue(0)
		end
	end

	if isOn and isAllZero then
		for k, v in pairs(self._allSoundItems) do
			local bgmVolume = PlayerLocalStorageModel.instance:getBgmVolumeHistory()

			self._allSoundItems[1]:setValue(bgmVolume)

			local soundEffVolume = PlayerLocalStorageModel.instance:getSoundEffVolumeHistory()

			self._allSoundItems[2]:setValue(soundEffVolume)

			local dubVolume = PlayerLocalStorageModel.instance:getDubVolumeHistory()

			self._allSoundItems[3]:setValue(dubVolume)
		end
	end

	PlayerLocalStorageModel.instance:setSoundMainSwitch(isOn)
end

return M
