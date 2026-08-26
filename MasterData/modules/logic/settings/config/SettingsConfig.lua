-- chunkname: @modules/logic/settings/config/SettingsConfig.lua

module("modules.logic.settings.config.SettingsConfig", package.seeall)

local SettingsConfig = class("SettingsConfig", BaseConfig)

function SettingsConfig:ctor()
	self.SettingsConfig = nil
end

function SettingsConfig:reqConfigNames()
	return {
		"setting_lang",
		"setting_voice"
	}
end

function SettingsConfig:onConfigLoaded(configName, configTable)
	if configName == "setting_lang" then
		self.SettingLangConfig = configTable
	elseif configName == "setting_voice" then
		self.SettingVoiceConfig = configTable
	end
end

function SettingsConfig:getSettingLang(shortcuts)
	return self.SettingLangConfig.configDict[shortcuts].lang
end

function SettingsConfig:getVoiceTips(shortcuts)
	if self.SettingVoiceConfig.configDict[shortcuts] then
		return self.SettingVoiceConfig.configDict[shortcuts].tips
	end

	return ""
end

SettingsConfig.instance = SettingsConfig.New()

return SettingsConfig
