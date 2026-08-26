-- chunkname: @modules/logic/rouge/view/RougeCollectionHandBookViewContainer.lua

module("modules.logic.rouge.view.RougeCollectionHandBookViewContainer", package.seeall)

local RougeCollectionHandBookViewContainer = class("RougeCollectionHandBookViewContainer", BaseViewContainer)

function RougeCollectionHandBookViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Left/#scroll_collection"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "Left/#scroll_collection/Viewport/Content/#go_collectionitem"
	scrollParam.cellClass = RougeCollectionHandBookItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 224
	scrollParam.cellHeight = 224
	scrollParam.cellSpaceH = 10
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 20
	scrollParam.endSpace = 0

	local views = {}

	table.insert(views, RougeCollectionHandBookView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, LuaListScrollView.New(RougeCollectionHandBookListModel.instance, scrollParam))

	return views
end

function RougeCollectionHandBookViewContainer:buildTabViews(tabContainerId)
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

return RougeCollectionHandBookViewContainer
