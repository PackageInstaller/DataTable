-- chunkname: @modules/logic/settings/view/SettingsCurrencyViewContainer.lua

module("modules.logic.settings.view.SettingsCurrencyViewContainer", package.seeall)

local SettingsCurrencyViewContainer = class("SettingsCurrencyViewContainer", BaseViewContainer)

function SettingsCurrencyViewContainer:buildViews()
	local views = {}

	table.insert(views, SettingsCurrencyView.New())

	return views
end

return SettingsCurrencyViewContainer
