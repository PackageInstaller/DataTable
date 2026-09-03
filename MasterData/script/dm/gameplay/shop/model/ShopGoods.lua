-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/model/ShopGoods.lua

ShopGoods = class("ShopGoods", objectlua.Object)

ShopGoods:has("_recoverValue", {
	is = "rw"
})
ShopGoods:has("_stock", {
	is = "rw"
})
ShopGoods:has("_shopId", {
	is = "rw"
})
ShopGoods:has("_updateTime", {
	is = "w"
})
ShopGoods:has("_rewardId", {
	is = "rw"
})
ShopGoods:has("_costPrice", {
	is = "rw"
})
ShopGoods:has("_cd", {
	is = "rw"
})
ShopGoods:has("_amount", {
	is = "rw"
})
ShopGoods:has("_storage", {
	is = "rw"
})
ShopGoods:has("_costType", {
	is = "rw"
})
ShopGoods:has("_itemId", {
	is = "rw"
})
ShopGoods:has("_itemConfig", {
	is = "rw"
})
ShopGoods:has("_index", {
	is = "r"
})
ShopGoods:has("_rewardInfo", {
	is = "r"
})

function ShopGoods:initialize(shopId)
	super.initialize(self)

	self._shopId = shopId
	self._positionId = ""
	self._recoverValue = 0
	self._stock = -1
	self._updateTime = 1
	self._rewardId = ""
	self._costPrice = 100
	self._cd = 0
	self._amount = 10
	self._storage = -1
	self._costType = 0
	self._itemId = 0
	self._costOff = 1
	self._tag = ""
	self._itemConfig = nil
	self._shopId = ""
	self._index = 1
	self._condition = {}
	self._scale = {
		Zoom = 1,
		YOffset = 0,
		XOffst = 0
	}
	self._sort = 0
end

function ShopGoods:syncGoods(positionId, data)
	if positionId then
		self._positionId = positionId
	end

	if data.recoverValue then
		self._recoverValue = data.recoverValue
	end

	if data.stock then
		self._stock = data.stock
	end

	if data.recoverTime then
		self._updateTime = data.recoverTime + 2
	end

	if data.index then
		self._index = data.index
	end

	if data.rewardId then
		self._rewardId = data.rewardId
	end

	if data.rewardInfo then
		self._rewardInfo = data.rewardInfo
	end

	if data.costPrice then
		self._costPrice = data.costPrice
	end

	if data.cd then
		self._cd = data.cd
	end

	if data.amount then
		self._amount = data.amount
	end

	if data.storage then
		self._storage = data.storage
	end

	if data.costType then
		self._costType = data.costType
	end

	if data.costOff then
		self._costOff = data.costOff
	end

	if data.tag then
		self._tag = data.tag
	end

	if data.itemId then
		self._itemId = data.itemId

		local config = ConfigReader:getRecordById("ItemConfig", self._itemId)

		config = config or ConfigReader:getRecordById("Surface", self._itemId)
		config = config or ConfigReader:getRecordById("HeroEquipBase", self._itemId)
		self._itemConfig = config
	end
end

function ShopGoods:getCDTime()
	local time
	local rewards = RewardSystem:getRewardsById(self._rewardId)

	return (rewards[1].resetMode and rewards[1].resetMode == "CD" or nil) and rewards[1].cd
end

function ShopGoods:getResetMode()
	local rewards = RewardSystem:getRewardsById(self._rewardId)

	if rewards[1].resetMode then
		return rewards[1].resetMode
	end

	return nil
end

function ShopGoods:getOriginalPrice()
	local rewards = RewardSystem:getRewardsById(self._rewardId)

	if rewards[1].originalPrice then
		return rewards[1].originalPrice
	end

	return nil
end

function ShopGoods:getUpdateTime()
	if not self._updateTime then
		return 1
	end

	return self._updateTime
end

function ShopGoods:getName()
	return Strings:get(self._itemConfig.Name)
end

function ShopGoods:getStock()
	return self._stock
end

function ShopGoods:setStock(stock)
	self._stock = stock
end

function ShopGoods:getStorage()
	return self._storage
end

function ShopGoods:getAmount()
	return self._amount
end

function ShopGoods:getCostType()
	return self._costType
end

function ShopGoods:getPrice()
	return self._costPrice
end

function ShopGoods:getItemId()
	return self._itemId
end

function ShopGoods:getCostOff()
	return self._costOff
end

function ShopGoods:getTag()
	return self._tag
end

function ShopGoods:getPositionId()
	return self._positionId
end

function ShopGoods:setShopId(shopId)
	self._shopId = shopId
	self._shopConfig = ConfigReader:getRecordById("Shop", self._shopId)
end

function ShopGoods:getShopId()
	return self._shopId
end

function ShopGoods:setCondition(condition)
	self._condition = condition
end

function ShopGoods:getTime()
	return self._condition.TIME
end

function ShopGoods:getCondition()
	local systemKeeper = DmGame:getInstance()._injector:getInstance(SystemKeeper)

	if not self._condition then
		return true
	end

	local isOpen, lockTip, unLockLevel = systemKeeper:isUnlockByCondition(self._condition)

	return isOpen, lockTip, unLockLevel
end

function ShopGoods:setScale(scale)
	if scale then
		self._scale = scale
	end
end

function ShopGoods:getScale()
	return self._scale
end

function ShopGoods:setSort(sort)
	self._sort = sort
end

function ShopGoods:getSort()
	return self._sort
end

function ShopGoods:getQuality()
	return self._itemConfig.Quality
end

function ShopGoods:getTargetHeroId()
	return self._itemConfig.Hero
end

function ShopGoods:getTimeTag()
	return nil
end

local HeroEquipExp = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipExp", "content")
local HeroEquipStar = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipStar", "content")

function ShopGoods:getEquipInfo()
	if not self._itemConfig.Rareity then
		return nil
	end

	local rarity = self._itemConfig.Rareity
	local star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", HeroEquipStar[tostring(rarity)], "StarLevel")
	local level = ConfigReader:getDataByNameIdAndKey("HeroEquipExp", HeroEquipExp[tostring(rarity)], "ShowLevel")

	return {
		id = self._itemId,
		rarity = rarity,
		star = star,
		level = level
	}
end
