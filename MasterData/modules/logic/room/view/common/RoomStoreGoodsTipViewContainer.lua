-- chunkname: @modules/logic/room/view/common/RoomStoreGoodsTipViewContainer.lua

module("modules.logic.room.view.common.RoomStoreGoodsTipViewContainer", package.seeall)

local RoomStoreGoodsTipViewContainer = class("RoomStoreGoodsTipViewContainer", BaseViewContainer)

function RoomStoreGoodsTipViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomStoreGoodsTipView.New())
	table.insert(views, RoomStroreGoodsTipViewBanner.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#go_buyContent/scroll_blockpackage"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "right/#go_buyContent/#go_blockInfoItem"
	scrollParam.cellClass = RoomStoreGoodsTipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 470
	scrollParam.cellHeight = 50
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 1.44
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(RoomStoreItemListModel.instance, scrollParam))
	table.insert(views, TabViewGroup.New(1, "#go_topright"))

	return views
end

function RoomStoreGoodsTipViewContainer:buildTabViews(tabContainerId)
	local currencyType = CurrencyEnum.CurrencyType
	local currencyParam = {
		currencyType.FreeDiamondCoupon,
		23
	}

	if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 then
		table.insert(currencyParam, {
			isCurrencySprite = true,
			id = StoreEnum.NormalRoomTicket,
			type = MaterialEnum.MaterialType.Item
		})
	end

	if ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
		table.insert(currencyParam, {
			isCurrencySprite = true,
			id = StoreEnum.TopRoomTicket,
			type = MaterialEnum.MaterialType.Item
		})
	end

	return {
		CurrencyView.New(currencyParam)
	}
end

function RoomStoreGoodsTipViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(ViewName.RoomStoreGoodsTipView, nil, true)
end

return RoomStoreGoodsTipViewContainer
