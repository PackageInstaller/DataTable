-- chunkname: @IQIGame\\Net\\NetShopResponse.lua

function net_shop.buyResult(code, itemShowPODS, commodityBuyRecords)
	ShopModule.BuyItemResultSucceed(itemShowPODS, commodityBuyRecords)
end

function net_shop.refreshResult(code)
	return
end

function net_shop.notifyUpdateShop(shopPODs)
	return
end

function net_shop.upgradShopResult(code)
	ShopModule.UpgradeShopResult()
end

function net_shop.markShowResult(code, shopItemPOD)
	ShopModule.MarkShowResult(shopItemPOD)
end
