-- chunkname: @modules/logic/settings/view/SettingsViewContainer.lua

module("modules.logic.settings.view.SettingsViewContainer", package.seeall)

local SettingsViewContainer = class("SettingsViewContainer", BaseViewContainer)

function SettingsViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_category"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SettingsCategoryListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 300
	scrollParam.cellHeight = 120
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0

	return {
		LuaListScrollView.New(SettingsCategoryListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_settingscontent"),
		SettingsView.New()
	}
end

function SettingsViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			}, nil, self.clickClose, nil, nil, self)
		}
	elseif tabContainerId == 2 then
		return {
			SettingsKeyMapView.New(),
			SettingsAccountView.New(),
			SettingsGraphicsView.New(),
			SettingsSoundView.New(),
			SettingsPushView.New(),
			SettingsLanguageView.New(),
			MultiView.New({
				SettingsGameView.New(),
				SettingsLoginPageView.New()
			}),
			SettingsFightView.New()
		}
	end
end

function SettingsViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabId)
end

function SettingsViewContainer:clickClose()
	ViewMgr.instance:openView(ViewName.MainThumbnailView)
end

return SettingsViewContainer
