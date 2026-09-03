-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/model/ShopPackage.lua

ShopPackage = class("ShopPackage", objectlua.Object)

ShopPackage:has("_id", {
	is = "rw"
})
ShopPackage:has("_productId", {
	is = "rw"
})
ShopPackage:has("_name", {
	is = "rw"
})
ShopPackage:has("_sort", {
	is = "rw"
})
ShopPackage:has("_price", {
	is = "rw"
})
ShopPackage:has("_desc", {
	is = "rw"
})
ShopPackage:has("_icon", {
	is = "rw"
})
ShopPackage:has("_quality", {
	is = "rw"
})
ShopPackage:has("_tag", {
	is = "rw"
})
ShopPackage:has("_costOffTag", {
	is = "rw"
})
ShopPackage:has("_timeTag", {
	is = "rw"
})
ShopPackage:has("_timeType", {
	is = "rw"
})
ShopPackage:has("_coolDown", {
	is = "rw"
})
ShopPackage:has("_clientCondition", {
	is = "rw"
})
ShopPackage:has("_isHide", {
	is = "rw"
})
ShopPackage:has("_leftCount", {
	is = "rw"
})
ShopPackage:has("_lastBuyMills", {
	is = "rw"
})
ShopPackage:has("_lastUpdateMills", {
	is = "rw"
})
ShopPackage:has("_itemId", {
	is = "rw"
})
ShopPackage:has("_payId", {
	is = "rw"
})
ShopPackage:has("_isFree", {
	is = "rw"
})
ShopPackage:has("_isReset", {
	is = "rw"
})

function ShopPackage:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("PackageShop", self._id)
	self._isReset = nil
	self._leftCount = 0
	self._payId = self._config.Pay
	self._sort = self._config.Sort
end

function ShopPackage:sync(data)
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

function ShopPackage:getPaySymbolAndPrice()
	local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)

	return payOffSystem:getPaySymbolAndPrice(self._payId)
end

function ShopPackage:getProductId()
	return self._config.ProductId
end

function ShopPackage:getIsFree()
	return self._config.IsFree
end

function ShopPackage:getName()
	return Strings:get(self._config.Name)
end

function ShopPackage:getItem()
	return self._config.ItemShow
end

function ShopPackage:getSort()
	return self._config.Sort
end

function ShopPackage:getPrice()
	return self._config.Price
end

function ShopPackage:getDesc()
	return Strings:get(self._config.Desc)
end

function ShopPackage:getIcon()
	return "asset/ui/shop/" .. self._config.Icon .. ".png"
end

function ShopPackage:getBuyIcon()
	local path = self._config.WindowIcon

	if path ~= "" then
		return "asset/ui/shop/" .. path .. ".png"
	end

	return self:getIcon()
end

function ShopPackage:getQuality()
	return self._config.Quality
end

function ShopPackage:getTag()
	return self._config.Tag
end

function ShopPackage:getCostOff()
	return self._config.CostOffTag
end

function ShopPackage:getTimeTag()
	return self._config.TimeTag
end

function ShopPackage:getTimeType()
	return self._config.TimeType
end

function ShopPackage:getTimeTypeType()
	return self:getTimeType().type
end

function ShopPackage:getIsReset()
	return nil
end

function ShopPackage:getStorage()
	return self:getTimeType().amount
end

function ShopPackage:getStartMills()
	local typeData = self:getTimeType()

	if typeData.merge and typeData.merge == 1 then
		local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
		local mergeTime = developSystem:getServerMergeTime()

		return mergeTime + 86400 * (typeData.start - 1)
	end

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

function ShopPackage:getEndMills()
	local typeData = self:getTimeType()

	if typeData.merge and typeData.merge == 1 then
		local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
		local mergeTime = developSystem:getServerMergeTime()

		return mergeTime + 86400 * (typeData["end"] - 1)
	end

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

function ShopPackage:getEndMillsByCondition()
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

function ShopPackage:getCDTime()
	return self._config.CoolDown
end

function ShopPackage:getClientCondition()
	return self._config.ClientCondition or {}
end

function ShopPackage:getIsHide()
	return self._config.Hide == 0
end

function ShopPackage:getCanBuy()
	return self._config.Vanish ~= 1 or self._leftCount ~= 0
end

function ShopPackage:getPlatform()
	return self._config.Platform
end

function ShopPackage:getCostType()
	return IconFactory.kRMBDefaultFile
end

function ShopPackage:getShopId()
	return ShopSpecialId.kShopPackage
end

function ShopPackage:getPrepose()
	return self._config.Prepose or {}
end

function ShopPackage:getVersion()
	return self._config.Version
end

function ShopPackage:getShopSubType()
	return self._config.ShopSubType
end

function ShopPackage:getShopSort()
	if self._config.ShopSort == "PackageShop" then
		return ShopSpecialId.kShopPackage
	elseif self._config.ShopSort == "SurfacePackageShop" then
		return ShopSpecialId.kShopSurfacePackage
	elseif self._config.ShopSort == "TimeLimitShop" then
		return ShopSpecialId.kShopTimeLimit
	elseif self._config.ShopSort == "TimeLimitShop2" then
		return ShopSpecialId.kShopTimeLimit2
	end

	return self._config.ShopSort
end

function ShopPackage:getGameCoin()
	return self._config.GameCoin
end

function ShopPackage:getCondition()
	return self._config.Condition
end
