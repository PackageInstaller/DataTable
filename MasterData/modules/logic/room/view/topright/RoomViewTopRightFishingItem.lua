-- chunkname: @modules/logic/room/view/topright/RoomViewTopRightFishingItem.lua

module("modules.logic.room.view.topright.RoomViewTopRightFishingItem", package.seeall)

local RoomViewTopRightFishingItem = class("RoomViewTopRightFishingItem", RoomViewTopRightMaterialItem)

function RoomViewTopRightFishingItem:_onClick()
	local quantity = ItemModel.instance:getItemQuantity(self._item.type, self._item.id)
	local maxCount = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxHasFishingCurrency, true) or 0

	if maxCount <= quantity then
		GameFacade.showToast(ToastEnum.FishingCurrencyFull)

		return
	end

	FishingController.instance:openFishingExchange()
end

function RoomViewTopRightFishingItem:_setQuantity(quantity)
	quantity = math.floor(quantity)

	local maxCount = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxHasFishingCurrency, true)

	self._resourceItem.txtquantity.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_wholesale_weekly_revenue"), quantity, maxCount or 0)
	self._quantity = quantity
end

function RoomViewTopRightFishingItem:_tweenFinishCallback()
	local quantity = ItemModel.instance:getItemQuantity(self._item.type, self._item.id)
	local maxCount = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxHasFishingCurrency, true)

	self._resourceItem.txtquantity.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_wholesale_weekly_revenue"), quantity, maxCount or 0)
	self._quantity = quantity
end

return RoomViewTopRightFishingItem
