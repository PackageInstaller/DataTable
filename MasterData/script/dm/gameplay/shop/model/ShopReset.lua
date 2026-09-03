-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/model/ShopReset.lua

ShopReset = class("ShopReset", objectlua.Object)

ShopReset:has("_id", {
	is = "rw"
})
ShopReset:has("_productId", {
	is = "rw"
})
ShopReset:has("_name", {
	is = "rw"
})
ShopReset:has("_sort", {
	is = "rw"
})
ShopReset:has("_price", {
	is = "rw"
})
ShopReset:has("_desc", {
	is = "rw"
})
ShopReset:has("_icon", {
	is = "rw"
})
ShopReset:has("_quality", {
	is = "rw"
})
ShopReset:has("_tag", {
	is = "rw"
})
ShopReset:has("_costOffTag", {
	is = "rw"
})
ShopReset:has("_timeTag", {
	is = "rw"
})
ShopReset:has("_timeType", {
	is = "rw"
})
ShopReset:has("_coolDown", {
	is = "rw"
})
ShopReset:has("_clientCondition", {
	is = "rw"
})
ShopReset:has("_isHide", {
	is = "rw"
})
ShopReset:has("_leftCount", {
	is = "rw"
})
ShopReset:has("_lastBuyMills", {
	is = "rw"
})
ShopReset:has("_lastUpdateMills", {
	is = "rw"
})
ShopReset:has("_itemId", {
	is = "rw"
})
ShopReset:has("_payId", {
	is = "rw"
})
ShopReset:has("isFree", {
	is = "rw"
})
ShopReset:has("isReset", {
	is = "rw"
})

function ShopReset:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("ShopReset", self._id)
	self._isReset = ""
	self._leftCount = 0
	self._payId = self._config.Pay
end

function ShopReset:sync(data)
	if data.itemId then
		self._itemId = data.itemId
	end

	if data.leftCount then
		self._leftCount = data.leftCount
	end

	if data.lastBuyMills then
		self._lastBuyMills = data.lastBuyMills
	end

	if data.lastUpdateMills then
		self._lastUpdateMills = data.lastUpdateMills
	end
end

function ShopReset:getPaySymbolAndPrice()
	local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)

	return payOffSystem:getPaySymbolAndPrice(self._payId)
end

function ShopReset:getProductId()
	return self._config.ProductId
end

function ShopReset:getIsFree()
	return self._config.IsFree
end

function ShopReset:getName()
	return Strings:get(self._config.Name)
end

function ShopReset:getItem()
	return self._config.ItemShow
end

function ShopReset:getSort()
	return self._config.Sort
end

function ShopReset:getPrice()
	return self._config.Price
end

function ShopReset:getDesc()
	return Strings:get(self._config.Desc)
end

function ShopReset:getIcon()
	return "asset/ui/shop/" .. self._config.Icon .. ".png"
end

function ShopReset:getBuyIcon()
	local path = self._config.WindowIcon

	if path ~= "" then
		return "asset/ui/shop/" .. path .. ".png"
	end

	return self:getIcon()
end

function ShopReset:getQuality()
	return self._config.Quality
end

function ShopReset:getTag()
	return self._config.Tag
end

function ShopReset:getCostOff()
	return self._config.CostOffTag
end

function ShopReset:getTimeTag()
	return self._config.TimeTag
end

function ShopReset:getTimeType()
	return self._config.TimeType
end

function ShopReset:getTimeTypeType()
	return self:getTimeType().type
end

function ShopReset:getIsReset()
	return self:getTimeType().type
end

function ShopReset:getStorage()
	return self:getTimeType().amount
end

function ShopReset:getStartMills()
	if self:getTimeTypeType() == kShopResetType.KResetUnlimit then
		local gameServerAgent = DmGame:getInstance()._injector:getInstance("GameServerAgent")
		local curTime = gameServerAgent:remoteTimestamp()

		return curTime - 86400
	end

	local start = self:getTimeType().start
	local _, _, y, mon, d, h, m, s = string.find(start, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

	return (TimeUtil:timeByRemoteDate({
		year = y,
		month = mon,
		day = d,
		hour = h,
		min = m,
		sec = s
	}))
end

function ShopReset:getEndMills()
	if self:getTimeTypeType() == kShopResetType.KResetUnlimit then
		local gameServerAgent = DmGame:getInstance()._injector:getInstance("GameServerAgent")
		local curTime = gameServerAgent:remoteTimestamp()

		return curTime + 2592000
	end

	local start = self:getTimeType()["end"]
	local _, _, y, mon, d, h, m, s = string.find(start, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
	local table = {
		year = y,
		month = mon,
		day = d,
		hour = h,
		min = m,
		sec = s
	}

	return (TimeUtil:timeByRemoteDate(table))
end

function ShopReset:getEndMillsByCondition()
	local condition = self:getClientCondition()

	if condition and condition[1] and condition[1].PLEYERREG then
		local beginDay = tonumber(condition[1].PLEYERREG[1])
		local endDay = tonumber(condition[1].PLEYERREG[2])
		local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
		local createTime = developSystem:getPlayer():getCreateTime()

		createTime = createTime / 1000 + (endDay - 1) * 24 * 60 * 60

		local tb = TimeUtil:remoteDate("*t", createTime)
		local shopReset_RefreshTime = ConfigReader:getDataByNameIdAndKey("Reset", "ShopReset_RefreshTime", "ResetSystem")
		local resetTime = shopReset_RefreshTime.resetTime[1]
		local _, _, h, m, s = string.find(resetTime, "(%d+):(%d+):(%d+)")
		local target = {
			year = tb.year,
			month = tb.month,
			day = tb.day,
			hour = h,
			min = m,
			sec = s
		}
		local dayMil = TimeUtil:getTimeByDateForTargetTime(target)

		return tb.hour < tonumber(h) and dayMil or dayMil + 86400
	end

	return self:getEndMills()
end

function ShopReset:getCDTime()
	return self._config.CoolDown
end

function ShopReset:getClientCondition()
	return self._config.ClientCondition or {}
end

function ShopReset:getIsHide()
	return self._config.Hide == 0
end

function ShopReset:getCanBuy()
	return self._config.Vanish ~= 1 or self._leftCount ~= 0
end

function ShopReset:getPlatform()
	return self._config.Platform
end

function ShopReset:getCostType()
	return IconFactory.kRMBDefaultFile
end

function ShopReset:getShopId()
	return ShopSpecialId.kShopReset
end

function ShopReset:getPrepose()
	return self._config.Prepose or {}
end

function ShopReset:getVersion()
	return self._config.Version
end

function ShopReset:getShopSort()
	return self._config.ShopSort
end

function ShopReset:getShopSubType()
	return self._config.ShopSubType
end

function ShopReset:getGameCoin()
	return self._config.GameCoin
end

function ShopReset:getSpecialType()
	return self._config.SpecialType
end
