-- chunkname: @modules/logic/settings/view/SettingsRoleVoiceViewContainer.lua

module("modules.logic.settings.view.SettingsRoleVoiceViewContainer", package.seeall)

local SettingsRoleVoiceViewContainer = class("SettingsRoleVoiceViewContainer", BaseViewContainer)

function SettingsRoleVoiceViewContainer:buildViews()
	self._scrollParam = ListScrollParam.New()
	self._scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	self._scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	self._scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	self._scrollParam.cellClass = SettingsRoleVoiceListItem
	self._scrollParam.scrollDir = ScrollEnum.ScrollDirV
	self._scrollParam.lineCount = 6
	self._scrollParam.cellWidth = 250
	self._scrollParam.cellHeight = 555
	self._scrollParam.cellSpaceH = 18
	self._scrollParam.cellSpaceV = 10
	self._scrollParam.startSpace = 10
	self._scrollParam.frameUpdateMs = 100
	self._scrollParam.minUpdateCountInFrame = 100
	self._scrollParam.multiSelect = false

	local cardAnimationDelayTimes = {}

	for i = 1, 12 do
		cardAnimationDelayTimes[i] = math.ceil((i - 1) % 6) * 0.06
	end

	self._cardScrollView = LuaListScrollViewWithAnimator.New(CharacterBackpackCardListModel.instance, self._scrollParam, cardAnimationDelayTimes)

	local views = {}

	self._mainSettingView = SettingsRoleVoiceView.New()
	self._filterView = SettingsRoleVoiceSearchFilterView.New()

	table.insert(views, self._mainSettingView)
	table.insert(views, self._filterView)
	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, self._cardScrollView)

	return views
end

function SettingsRoleVoiceViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

function SettingsRoleVoiceViewContainer:isBatchEditMode()
	return self._mainSettingView:isBatchEditMode()
end

function SettingsRoleVoiceViewContainer:setBatchEditMode(mulitEdit)
	self._scrollParam.multiSelect = mulitEdit
end

function SettingsRoleVoiceViewContainer:getCardScorllView()
	return self._cardScrollView
end

function SettingsRoleVoiceViewContainer:clearSelectedItems()
	self._cardScrollView:setSelectList()
end

function SettingsRoleVoiceViewContainer:selectedAllItems()
	local allItemMos = CharacterBackpackCardListModel.instance:getCharacterCardList()

	self._cardScrollView:setSelectList(allItemMos)
end

return SettingsRoleVoiceViewContainer
