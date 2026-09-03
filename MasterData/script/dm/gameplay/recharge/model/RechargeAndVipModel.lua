-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recharge/model/RechargeAndVipModel.lua

require("dm.gameplay.recharge.model.RechargeGoodsModel")

RechargeAndVipModel = class("RechargeAndVipModel", objectlua.Object, _M)

RechargeAndVipModel:has("_rechargeGoodsList", {
	is = "rw"
})
RechargeAndVipModel:has("_rechargeGoodsMap", {
	is = "rw"
})
RechargeAndVipModel:has("_rechargeHistory", {
	is = "rw"
})
RechargeAndVipModel:has("_vipRewards", {
	is = "rw"
})
RechargeAndVipModel:has("_monthCardList", {
	is = "rw"
})
RechargeAndVipModel:has("_monthCardMap", {
	is = "rw"
})
RechargeAndVipModel:has("_fCardWeekFlag", {
	is = "rw"
})
RechargeAndVipModel:has("_fCardBuyFlag", {
	is = "rw"
})
RechargeAndVipModel:has("_fCardStamina", {
	is = "rw"
})
RechargeAndVipModel:has("_isPurchased", {
	is = "rw"
})
RechargeAndVipModel:has("_endTime", {
	is = "rw"
})
RechargeAndVipModel:has("_type", {
	is = "rw"
})
RechargeAndVipModel:has("_rechargedIds", {
	is = "rw"
})

function RechargeAndVipModel:initialize()
	super.initialize(self)

	self._rechargeHistory = 0
	self._vipRewards = {}
	self._fCardWeekFlag = {}
	self._fCardBuyFlag = false
	self._fCardStamina = 0
	self._rechargedIds = {}
	self._isPurchased = false
	self._endTime = -1
	self._type = "SUBSCRIBE"

	self:initRechargeModel()
	self:initMonthCard()
end

function RechargeAndVipModel:initRechargeModel()
	self._rechargeGoodsList = {}
	self._rechargeGoodsMap = {}

	local mallConfig = ConfigReader:getDataTable("Mall")
	local osPlatform = "ios"

	for id, goods in pairs(mallConfig) do
		if goods and goods.Platform == osPlatform then
			local rechargeGoodsModel = RechargeGoodsModel:new(id)

			rechargeGoodsModel:synchronizeModel(goods)

			self._rechargeGoodsList[#self._rechargeGoodsList + 1] = rechargeGoodsModel
			self._rechargeGoodsMap[rechargeGoodsModel:getProductId()] = rechargeGoodsModel
		end
	end

	table.sort(self._rechargeGoodsList, function(a, b)
		return self:compareRechargeGoodsList(a, b)
	end)
end

function RechargeAndVipModel:initMonthCard()
	self._monthCardList = {}
	self._monthCardMap = {}

	local monthCardConfig = ConfigReader:getDataTable("MonthCard")

	for id, goods in pairs(monthCardConfig) do
		local monthCardModel = MonthCardModel:new(id)

		monthCardModel:initModel(goods)

		self._monthCardList[#self._monthCardList + 1] = monthCardModel
		self._monthCardMap[id] = monthCardModel
	end
end

function RechargeAndVipModel:getMonthCardMap()
	local list = {}

	for key, value in pairs(self._monthCardMap) do
		if key == KMonthCardType.KMonthCardSubscribe then
			if self:getSubscribeStatus() then
				list[key] = value
			end
		else
			list[key] = value
		end
	end

	return list
end

function RechargeAndVipModel:getSubscribeStatus()
	local sub = self._monthCardMap[KMonthCardType.KMonthCardSubscribe]

	if sub then
		local systemKeeper = DmGame:getInstance()._injector:getInstance("SystemKeeper")
		local unlock, tips = systemKeeper:isUnlock("Subscribe")
		local canShow = systemKeeper:canShow("Subscribe")

		if unlock and canShow then
			return true
		end
	end

	return false
end

function RechargeAndVipModel:synchronizeModel(data)
	if data.rechargeDiamond then
		self._rechargeHistory = data.rechargeDiamond
	end

	if data.vipRewards then
		self:synchronizeVipRewards(data.vipRewards)
	end

	if data.rechargedIds then
		self._rechargedIds = data.rechargedIds

		for k, v in pairs(data.rechargedIds) do
			if self._rechargeGoodsMap[v] then
				self._rechargeGoodsMap[v]:setIsFirstRecharge(false)
			end
		end
	end

	if data.monthCards then
		for k, v in pairs(data.monthCards) do
			if self._monthCardMap[k] then
				self._monthCardMap[k]:synchronizeModel(v)
			end
		end
	end

	if data.fCardWeekFlag then
		self._fCardWeekFlag.value = data.fCardWeekFlag.value
		self._fCardWeekFlag.updateTime = data.fCardWeekFlag.updateTime
	end

	if data.fCardBuyFlag then
		self._fCardBuyFlag = data.fCardBuyFlag
	end

	if data.fCardStamina then
		self._fCardStamina = data.fCardStamina
	end

	if data.SUBSCRIBE then
		self._isPurchased = data.SUBSCRIBE.isPurchased
		self._endTime = data.SUBSCRIBE.endTime
		self._type = data.SUBSCRIBE.type
	end
end

function RechargeAndVipModel:getRechargedStatus(payId)
	local config = ConfigReader:getRecordById("Pay", payId)

	if config then
		local productId = config.ProductId

		for k, v in pairs(self._rechargedIds) do
			if v == productId then
				return true
			end
		end
	end

	return false
end

function RechargeAndVipModel:synchronizeVipRewards(data)
	for k, v in pairs(data) do
		self._vipRewards[v] = true
	end
end

function RechargeAndVipModel:compareRechargeGoodsList(a, b)
	return tonumber(a:getPosition()) < tonumber(b:getPosition())
end

function RechargeAndVipModel:delMonthCard(cardId)
	if self._monthCardMap[cardId] then
		self._monthCardMap[cardId]:delData()
	end
end
