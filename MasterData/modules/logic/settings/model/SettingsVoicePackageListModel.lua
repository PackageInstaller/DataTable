-- chunkname: @modules/logic/settings/model/SettingsVoicePackageListModel.lua

module("modules.logic.settings.model.SettingsVoicePackageListModel", package.seeall)

local SettingsVoicePackageListModel = class("SettingsVoicePackageListModel", ListScrollModel)

function SettingsVoicePackageListModel:onInit()
	return
end

function SettingsVoicePackageListModel:reInit()
	return
end

SettingsVoicePackageListModel.instance = SettingsVoicePackageListModel.New()

return SettingsVoicePackageListModel
