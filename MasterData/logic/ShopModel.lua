-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/model/ShopModel.lua

module("logic.extensions.shop.model.ShopModel", package.seeall)

local ShopModel = class("ShopModel", BaseModel)

ShopModel.moneyIndex = {
	coin = 1,
	diamond = 0
}
ShopModel.moneyType = {
	coin = "金币",
	diamond = "钻石"
}

function ShopModel:ctor()
	ShopModel.super.ctor(self)
end

function ShopModel:onInit()
	self:onReset()
end

function ShopModel:onReset()
	local str = GameUtil.getLocalString("lastTimeShowShop")

	self._lastTimeShowShop = GameUtil.isEmptyString(str) and ServerTime.formatNow("%Y/%m/%d") or str
	self._activeShopBuyItemsInfo = {}
	self._goods = {}
end

function ShopModel:initAllGoods(buyTimes)
	ShopModel.instance.isCountInited = true
	self._goods = PayShopConfig.instance:getGoodsCfgsByShopType(GameEnum.PayShopShopType.Shop)
	self._goodsCountList = {}

	local KVList = {}

	for i, v in ipairs(buyTimes) do
		KVList[v.id] = v
	end

	for type, list in pairs(self._goods) do
		for k, v in pairs(list) do
			self._goodsCountList[v.id] = KVList[v.id] and KVList[v.id].times or 0
		end
	end

	self._selectGoodId = -1
end

function ShopModel:select(id)
	self._selectGoodId = id
end

function ShopModel:getSelect()
	return self._selectGoodId
end

function ShopModel:onBuyGood(id, times)
	if self._goodsCountList[id] then
		self._goodsCountList[id] = times
	end
end

function ShopModel:getGoodInfo(id)
	for i, v in ipairs(self._goods) do
		if v.id == id then
			return v
		end
	end
end

function ShopModel:getGoodsCount(id)
	return checknumber(self._goodsCountList[id])
end

function ShopModel:getGoodsByType(goodType)
	local ret = {}
	local tempList = self._goods[goodType]

	if tempList then
		for k, cfg in pairs(tempList) do
			local timeEnough = GameUtil.checkIsInTimePeriod(cfg.onlineTime, cfg.offlineTime)

			if timeEnough then
				table.insert(ret, cfg)
			end
		end
	end

	ArraySort.sortOn(ret, "rank")

	return ret
end

function ShopModel:getGifts()
	return self:getGoodsByType(1)
end

function ShopModel:getMessGoods()
	return self:getGoodsByType(2)
end

function ShopModel:hasShowShopToday()
	return self._lastTimeShowShop == ServerTime.formatNow("%Y/%m/%d")
end

function ShopModel:updateLastTimeShow()
	self._lastTimeShowShop = ServerTime.formatNow("%Y/%m/%d")

	GameUtil.setLocalString("lastTimeShowShop", self._lastTimeShowShop)
end

function ShopModel:getLastTimeShow()
	return self._lastTimeShowShop
end

ShopModel.instance = ShopModel.New()

return ShopModel
