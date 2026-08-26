-- chunkname: @modules/logic/character/view/CharacterSwitchViewContainer.lua

module("modules.logic.character.view.CharacterSwitchViewContainer", package.seeall)

local CharacterSwitchViewContainer = class("CharacterSwitchViewContainer", BaseViewContainer)

function CharacterSwitchViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterSwitchView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/mask/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = CharacterSwitchItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 208
	scrollParam.cellSpaceH = 5
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 5
	scrollParam.endSpace = 0
	self._characterScrollView = LuaListScrollView.New(CharacterSwitchListModel.instance, scrollParam)

	table.insert(views, self._characterScrollView)
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function CharacterSwitchViewContainer:getCharacterScrollView()
	return self._characterScrollView
end

function CharacterSwitchViewContainer:buildTabViews(tabContainerId)
	self.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	}, 101)

	return {
		self.navigationView
	}
end

function CharacterSwitchViewContainer:on()
	self.navigationView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_OperaHouse)
end

return CharacterSwitchViewContainer
