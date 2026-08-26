-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_AlchemyListViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_AlchemyListViewContainer", package.seeall)

local Rouge2_AlchemyListViewContainer = class("Rouge2_AlchemyListViewContainer", BaseViewContainer)

function Rouge2_AlchemyListViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_AlchemyListView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Left/#scroll_collection"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Rouge2_AlchemyListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 224
	scrollParam.cellHeight = 224
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	table.insert(views, LuaListScrollView.New(Rouge2_AlchemyItemListModel.instance, scrollParam))
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function Rouge2_AlchemyListViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return Rouge2_AlchemyListViewContainer
