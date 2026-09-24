-- chunkname: @modules/logic/settings/view/SettingsDelUnusedResViewContainer.lua

module("modules.logic.settings.view.SettingsDelUnusedResViewContainer", package.seeall)

local SettingsDelUnusedResViewContainer = class("SettingsDelUnusedResViewContainer", BaseViewContainer)

function SettingsDelUnusedResViewContainer:buildViews()
	local views = {}

	table.insert(views, SettingsDelUnusedResView.New())

	return views
end

function SettingsDelUnusedResViewContainer:setListData(data)
	return
end

function SettingsDelUnusedResViewContainer:selectCell(index)
	return
end

function SettingsDelUnusedResViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return SettingsDelUnusedResViewContainer
