-- chunkname: @IQIGame\\Net\\NetShopResponse.lua

function net_shop.buyResult(code, shopCid, index)
	ShopModule.ResponseBuyItemMsg(shopCid, index)
end

function net_shop.refreshResult(code, shopCid, type)
	return
end

function net_shop.updateShop(shopData)
	ShopModule.updateShopItem(shopData)
end
