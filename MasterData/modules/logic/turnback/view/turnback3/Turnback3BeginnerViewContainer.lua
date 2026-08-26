-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BeginnerViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3BeginnerViewContainer", package.seeall)

local Turnback3BeginnerViewContainer = class("Turnback3BeginnerViewContainer", BaseViewContainer)

function Turnback3BeginnerViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_category/#scroll_categoryitem"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Turnback3CategoryItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 300
	scrollParam.cellHeight = 125
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 9.8
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(TurnbackBeginnerCategoryListModel.instance, scrollParam))
	table.insert(views, Turnback3BeginnerView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Turnback3BeginnerViewContainer:buildTabViews(tabContainerId)
	self.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigationView
	}
end

return Turnback3BeginnerViewContainer
