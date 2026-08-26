-- chunkname: @modules/logic/settings/view/SettingsCdkeyViewContainer.lua

module("modules.logic.settings.view.SettingsCdkeyViewContainer", package.seeall)

local SettingsCdkeyViewContainer = class("SettingsCdkeyViewContainer", BaseViewContainer)

function SettingsCdkeyViewContainer:buildViews()
	local views = {}

	table.insert(views, SettingsCdkeyView.New())

	return views
end

function SettingsCdkeyViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return SettingsCdkeyViewContainer
