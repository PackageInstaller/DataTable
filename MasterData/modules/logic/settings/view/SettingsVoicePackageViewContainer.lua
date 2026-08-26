-- chunkname: @modules/logic/settings/view/SettingsVoicePackageViewContainer.lua

module("modules.logic.settings.view.SettingsVoicePackageViewContainer", package.seeall)

local SettingsVoicePackageViewContainer = class("SettingsVoicePackageViewContainer", BaseViewContainer)

function SettingsVoicePackageViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "view/#scroll_content"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SettingsVoicePackageListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1430
	scrollParam.cellHeight = 90
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 2
	scrollParam.startSpace = 0
	scrollParam.sortMode = ScrollEnum.ScrollSortDown

	table.insert(views, LuaListScrollView.New(SettingsVoicePackageListModel.instance, scrollParam))
	table.insert(views, SettingsVoicePackageView.New())

	return views
end

function SettingsVoicePackageViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return SettingsVoicePackageViewContainer
