-- chunkname: @modules/logic/turnback/view/TurnbackBeginnerViewContainer.lua

module("modules.logic.turnback.view.TurnbackBeginnerViewContainer", package.seeall)

local TurnbackBeginnerViewContainer = class("TurnbackBeginnerViewContainer", BaseViewContainer)

function TurnbackBeginnerViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_category/#scroll_categoryitem"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = TurnbackCategoryItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 300
	scrollParam.cellHeight = 125
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 9.8
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(TurnbackBeginnerCategoryListModel.instance, scrollParam))
	table.insert(views, TurnbackBeginnerView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function TurnbackBeginnerViewContainer:buildTabViews(tabContainerId)
	self.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigationView
	}
end

return TurnbackBeginnerViewContainer
