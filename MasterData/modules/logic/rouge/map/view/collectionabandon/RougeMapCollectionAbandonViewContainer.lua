-- chunkname: @modules/logic/rouge/map/view/collectionabandon/RougeMapCollectionAbandonViewContainer.lua

module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionAbandonViewContainer", package.seeall)

local RougeMapCollectionAbandonViewContainer = class("RougeMapCollectionAbandonViewContainer", BaseViewContainer)

function RougeMapCollectionAbandonViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeMapCollectionAbandonView.New())
	table.insert(views, TabViewGroup.New(2, "#go_rougemapdetailcontainer"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Left/#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = RougeMapEnum.CollectionLeftItemRes
	scrollParam.cellClass = RougeMapCollectionLossLeftItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 850
	scrollParam.cellHeight = 180
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 8
	scrollParam.startSpace = 0
	self.scrollView = LuaListScrollView.New(RougeLossCollectionListModel.instance, scrollParam)

	table.insert(views, self.scrollView)

	return views
end

function RougeMapCollectionAbandonViewContainer:buildTabViews(tabContainerId)
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

function RougeMapCollectionAbandonViewContainer:onContainerInit()
	self.listRemoveComp = ListScrollAnimRemoveItem.Get(self.scrollView)

	self.listRemoveComp:setMoveInterval(0)
end

function RougeMapCollectionAbandonViewContainer:getListRemoveComp()
	return self.listRemoveComp
end

return RougeMapCollectionAbandonViewContainer
