-- chunkname: @modules/logic/rouge/map/view/collectionabandon/RougeMapCollectionExchangeViewContainer.lua

module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionExchangeViewContainer", package.seeall)

local RougeMapCollectionExchangeViewContainer = class("RougeMapCollectionExchangeViewContainer", BaseViewContainer)

function RougeMapCollectionExchangeViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeMapCollectionExchangeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))
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

function RougeMapCollectionExchangeViewContainer:buildTabViews(tabContainerId)
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

function RougeMapCollectionExchangeViewContainer:onContainerInit()
	self.listRemoveComp = ListScrollAnimRemoveItem.Get(self.scrollView)

	self.listRemoveComp:setMoveInterval(0)
end

function RougeMapCollectionExchangeViewContainer:getListRemoveComp()
	return self.listRemoveComp
end

return RougeMapCollectionExchangeViewContainer
