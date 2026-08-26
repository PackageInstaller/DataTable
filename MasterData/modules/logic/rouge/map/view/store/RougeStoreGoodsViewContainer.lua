-- chunkname: @modules/logic/rouge/map/view/store/RougeStoreGoodsViewContainer.lua

module("modules.logic.rouge.map.view.store.RougeStoreGoodsViewContainer", package.seeall)

local RougeStoreGoodsViewContainer = class("RougeStoreGoodsViewContainer", BaseViewContainer)

function RougeStoreGoodsViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeStoreGoodsView.New())
	table.insert(views, RougeMapCoinView.New())
	table.insert(views, TabViewGroup.New(1, "#go_rougemapdetailcontainer"))

	return views
end

function RougeStoreGoodsViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return RougeStoreGoodsViewContainer
