-- chunkname: @modules/logic/settings/view/SettingsVoiceDownloadViewContainer.lua

module("modules.logic.settings.view.SettingsVoiceDownloadViewContainer", package.seeall)

local SettingsVoiceDownloadViewContainer = class("SettingsVoiceDownloadViewContainer", BaseViewContainer)

function SettingsVoiceDownloadViewContainer:buildViews()
	local views = {}

	table.insert(views, SettingsVoiceDownloadView.New())

	return views
end

return SettingsVoiceDownloadViewContainer
