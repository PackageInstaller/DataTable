-- chunkname: @modules/logic/rouge/view/RougeCollectionCompositeViewContainer.lua

module("modules.logic.rouge.view.RougeCollectionCompositeViewContainer", package.seeall)

local RougeCollectionCompositeViewContainer = class("RougeCollectionCompositeViewContainer", BaseViewContainer)

function RougeCollectionCompositeViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "left/#go_list/ListView"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "left/#go_list/ListView/Viewport/Content/#go_listitem"
	scrollParam.cellClass = RougeCollectionCompositeListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 2
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 170
	scrollParam.cellSpaceH = 20
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 20
	scrollParam.endSpace = 0

	local views = {}

	table.insert(views, RougeCollectionCompositeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "#go_rougemapdetailcontainer"))
	table.insert(views, LuaListScrollView.New(RougeCollectionCompositeListModel.instance, scrollParam))

	return views
end

function RougeCollectionCompositeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return RougeCollectionCompositeViewContainer
