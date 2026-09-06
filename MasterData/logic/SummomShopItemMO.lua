-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/model/SummomShopItemMO.lua

module("logic.extensions.summontower.model.SummomShopItemMO", package.seeall)

local SummomShopItemMO = class("SummomShopItemMO")

function SummomShopItemMO:ctor()
	self.shopItemId = 0
	self.shopId = 0
	self.randomValue = 0
	self.buyTimes = 0
end

function SummomShopItemMO:getPrice()
	local itemCo = SummontowerConfig.instance:getShopItemCo(self.shopId, self.shopItemId)

	return itemCo.costCoinBase + self.buyTimes * itemCo.accBuyRatio
end

function SummomShopItemMO:getMaxBuyCount()
	local itemCo = SummontowerConfig.instance:getShopItemCo(self.shopId, self.shopItemId)

	return itemCo.count
end

function SummomShopItemMO:getGoodsName()
	local itemCo = SummontowerConfig.instance:getShopItemCo(self.shopId, self.shopItemId)

	if itemCo.itemType == SummonTowerItemsModel.ItemType.Pet then
		local petCo = SummontowerConfig.instance:getPetCo(self.randomValue)

		return petCo.creepsName
	else
		local gameItemCo = SummontowerConfig.instance:getGameItemCo(itemCo.itemType)
		local itemCo = ItemConfig.instance:getFakeCfgById(gameItemCo.itemId)

		return itemCo.name
	end
end

return SummomShopItemMO
