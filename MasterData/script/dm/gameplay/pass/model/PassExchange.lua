-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/model/PassExchange.lua

PassExchange = class("PassExchange", objectlua.Object)

PassExchange:has("_exchangeId", {
	is = "r"
})
PassExchange:has("_isRemind", {
	is = "r"
})
PassExchange:has("_order", {
	is = "r"
})
PassExchange:has("_costItem", {
	is = "r"
})
PassExchange:has("_targetRewardId", {
	is = "r"
})
PassExchange:has("_targetItem", {
	is = "r"
})
PassExchange:has("_exchangeCount", {
	is = "r"
})
PassExchange:has("_leftExchangeCount", {
	is = "r"
})
PassExchange:has("_targetItemId", {
	is = "r"
})
PassExchange:has("_costItemId", {
	is = "r"
})
PassExchange:has("_updateTime", {
	is = "w"
})
PassExchange:has("_itemConfig", {
	is = "r"
})

function PassExchange:initialize(data)
	super.initialize(self)

	self._exchangeId = ""
	self._isRemind = 0
	self._costItem = {}
	self._targetRewardId = ""
	self._targetItem = {}
	self._exchangeCount = 0
	self._leftExchangeCount = 0
	self._updateTime = 1
	self._targetItemId = ""
	self._costItemId = ""
	self._order = 0

	self:initData(data)
end

function PassExchange:initData(data)
	self._exchangeId = data.Id
	self._isRemind = data.isRemind
	self._costItem = data.Cost[1]
	self._targetRewardId = data.Target
	self._exchangeCount = data.Times
	self._order = data.Order or 1

	local reward = self:getReward(self._targetRewardId)

	if reward then
		self._targetItem = reward.Content[1]
	end

	if self._costItem then
		self._costItemId = self._costItem.code
	end

	if self._targetItem then
		self._targetItemId = self._targetItem.code
	end

	if self._targetItemId then
		local config = ConfigReader:getRecordById("ItemConfig", self._targetItemId)

		config = config or ConfigReader:getRecordById("Surface", self._targetItemId)
		config = config or ConfigReader:getRecordById("HeroEquipBase", self._targetItemId)
		config = config or ConfigReader:getRecordById("HeroBase", self._targetItemId)
		config = config or ConfigReader:getRecordById("ResourcesIcon", self._targetItemId)
		config = config or ConfigReader:getRecordById("PlayerHeadFrame", self._targetItemId)
		self._itemConfig = config
	end
end

function PassExchange:syncData(data)
	if data.recoverTime then
		self._updateTime = data.recoverTime + 2
	end

	if data.leftCount then
		self._leftExchangeCount = data.leftCount
	end
end

function PassExchange:getCostType()
	return self._costItem.type
end

function PassExchange:getTargetType()
	return self._targetItem.type
end

function PassExchange:getName()
	return Strings:get(self._itemConfig.Name)
end

function PassExchange:getQuality()
	return self._itemConfig.Quality
end

function PassExchange:getAmount()
	return self._exchangeCount
end

function PassExchange:getPrice()
	return self._costItem.amount
end

function PassExchange:getUpdateTime()
	if not self._updateTime then
		return 1
	end

	return self._updateTime
end

function PassExchange:getReward(rewardsId)
	return ConfigReader:getRecordById("Reward", rewardsId)
end

local HeroEquipExp = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipExp", "content")
local HeroEquipStar = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipStar", "content")

function PassExchange:getEquipInfo()
	if self:getTargetType() == RewardType.kEquip or self:getTargetType() == RewardType.kEquipExplore then
		if not self._itemConfig.Rareity then
			return nil
		end

		local rarity = self._itemConfig.Rareity
		local star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", HeroEquipStar[tostring(rarity)], "StarLevel")
		local level = ConfigReader:getDataByNameIdAndKey("HeroEquipExp", HeroEquipExp[tostring(rarity)], "ShowLevel")

		return {
			id = self._targetItemId,
			rarity = rarity,
			star = star,
			level = level
		}
	end

	return nil
end
