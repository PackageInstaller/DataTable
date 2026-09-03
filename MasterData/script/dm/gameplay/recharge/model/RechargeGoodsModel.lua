-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recharge/model/RechargeGoodsModel.lua

RechargeGoodsModel = class("RechargeGoodsModel", objectlua.Object, _M)

RechargeGoodsModel:has("_id", {
	is = "r"
})
RechargeGoodsModel:has("_payId", {
	is = "r"
})
RechargeGoodsModel:has("_productId", {
	is = "r"
})
RechargeGoodsModel:has("_position", {
	is = "r"
})
RechargeGoodsModel:has("_price", {
	is = "r"
})
RechargeGoodsModel:has("_tag", {
	is = "r"
})
RechargeGoodsModel:has("_getnumber", {
	is = "r"
})
RechargeGoodsModel:has("_firstbuynumber", {
	is = "r"
})
RechargeGoodsModel:has("_giftnumber", {
	is = "r"
})
RechargeGoodsModel:has("_giftnumber2", {
	is = "r"
})
RechargeGoodsModel:has("_iconAnim", {
	is = "r"
})
RechargeGoodsModel:has("_isFirstRecharge", {
	is = "rw"
})
RechargeGoodsModel:has("_bgType", {
	is = "rw"
})

mcType = {
	kWelfare = 1,
	kSupremacy = 2
}

function RechargeGoodsModel:initialize(id)
	super.initialize(self)

	self._id = id
	self._productId = ""
	self._position = 1
	self._price = 0
	self._tag = 0
	self._getnumber = 0
	self._firstbuynumber = 0
	self._giftnumber = 0
	self._giftnumber2 = 0
	self._iconAnim = ""
	self._isFirstRecharge = true
	self._bgType = 1
	self._sdkSource = {}
end

function RechargeGoodsModel:dispose()
	super.dispose(self)
end

function RechargeGoodsModel:synchronizeModel(data)
	local payInfo = ConfigReader:getRecordById("Pay", data.Pay)

	self._payId = data.Pay

	if payInfo then
		self._productId = payInfo.ProductId
		self._price = payInfo.Price
		self._sdkSource = payInfo.SDKSource
	end

	self._position = data.Position
	self._tag = data.Tag
	self._getnumber = data.Getnumber or 0
	self._firstbuynumber = data.Firstbuynumber or 0
	self._giftnumber = data.Giftnumber or 0
	self._iconAnim = data.Pic .. ".png"
	self._bgType = data.Picture
	self._giftnumber2 = data.Giftnumber2 or 0
end

function RechargeGoodsModel:getName()
	return self:getGetnumber() - self:getGiftnumber2()
end

function RechargeGoodsModel:getCostType()
	return IconFactory.kRMBDefaultFile
end

function RechargeGoodsModel:getShopId()
	return ShopSpecialId.kShopMall
end

function RechargeGoodsModel:getTimeTag()
	return self._tag == 1 and "Recommend" or self._tag
end

function RechargeGoodsModel:getTag()
	return nil
end

function RechargeGoodsModel:getCostOff()
	return 1
end

function RechargeGoodsModel:getPaySymbolAndPrice()
	local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)

	return payOffSystem:getPaySymbolAndPrice(self._payId)
end

MonthCardModel = class("MonthCardModel", objectlua.Object, _M)

MonthCardModel:has("_id", {
	is = "r"
})
MonthCardModel:has("_type", {
	is = "r"
})
MonthCardModel:has("_price", {
	is = "r"
})
MonthCardModel:has("_lastDuration", {
	is = "r"
})
MonthCardModel:has("_payId", {
	is = "r"
})
MonthCardModel:has("_endTimes", {
	is = "rw"
})
MonthCardModel:has("_lastRewardTimes", {
	is = "rw"
})
MonthCardModel:has("_config", {
	is = "r"
})
MonthCardModel:has("_name", {
	is = "r"
})
MonthCardModel:has("_icon", {
	is = "r"
})
MonthCardModel:has("_buyIcon", {
	is = "r"
})
MonthCardModel:has("_desc", {
	is = "r"
})
MonthCardModel:has("_sort", {
	is = "r"
})
MonthCardModel:has("_dangerTime", {
	is = "r"
})
MonthCardModel:has("_time", {
	is = "r"
})
MonthCardModel:has("_renewalTimes", {
	is = "r"
})

function MonthCardModel:initialize(id)
	super.initialize(self)

	self._config = ConfigReader:getRecordById("MonthCard", id)
	self._id = id
	self._type = -1
	self._price = 0
	self._lastDuration = 0
	self._endTimes = -1
	self._lastRewardTimes = -1
	self._name = Strings:get(self._config.Name)
	self._icon = self._config.Picture .. ".png"
	self._buyIcon = self._config.Title
	self._desc = Strings:get(self._config.Desc)
	self._sort = self._config.Sort
	self._time = self._config.Time
	self._renewalTimes = self._config.RenewalTimes
	self._dangerTime = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "MonthCard_1_DangerTime", "content")
end

function MonthCardModel:dispose()
	super.dispose(self)
end

function MonthCardModel:initModel(data)
	self._price = data.Price
	self._lastDuration = data.Time
	self._payId = data.Pay
end

function MonthCardModel:synchronizeModel(data)
	if data.endTs then
		self._endTimes = data.endTs
	end

	if data.lastRewardTs then
		self._lastRewardTimes = data.lastRewardTs
	end
end

function MonthCardModel:delData()
	self._endTimes = -1
	self._lastRewardTimes = -1
end

function MonthCardModel:getPaySymbolAndPrice()
	local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)

	return payOffSystem:getPaySymbolAndPrice(self._payId)
end
