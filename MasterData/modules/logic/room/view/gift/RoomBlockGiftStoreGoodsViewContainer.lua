-- chunkname: @modules/logic/room/view/gift/RoomBlockGiftStoreGoodsViewContainer.lua

module("modules.logic.room.view.gift.RoomBlockGiftStoreGoodsViewContainer", package.seeall)

local RoomBlockGiftStoreGoodsViewContainer = class("RoomBlockGiftStoreGoodsViewContainer", BaseViewContainer)

function RoomBlockGiftStoreGoodsViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topright"))
	table.insert(views, RoomBlockGiftStoreGoodsView.New())

	return views
end

function RoomBlockGiftStoreGoodsViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function RoomBlockGiftStoreGoodsViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({})

		return {
			self._currencyView
		}
	end
end

function RoomBlockGiftStoreGoodsViewContainer:setCurrencyType(currencyTypeParam)
	if self._currencyView then
		self._currencyView:setCurrencyType(currencyTypeParam)
	end
end

return RoomBlockGiftStoreGoodsViewContainer
