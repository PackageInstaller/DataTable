-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityTpurchase.lua

ActivityTpurchase = class("ActivityTpurchase", BaseActivity, _M)

ActivityTpurchase:has("_packageShopConfig", {
	is = "r"
})

function ActivityTpurchase:initialize()
	super.initialize(self)
end

function ActivityTpurchase:dispose()
	super.dispose(self)
end

function ActivityTpurchase:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)
end

function ActivityTpurchase:reset()
	super.reset(self)
end

function ActivityTpurchase:getTimePurchaseId()
	local activityConfig = self:getActivityConfig()

	return activityConfig.TimePurchaseId[1]
end

function ActivityTpurchase:hasRedPoint()
	return false
end

function ActivityTpurchase:isBuy()
	return self._isBuy
end

function ActivityTpurchase:getConfigStartEndTime()
	if self._timeinfo == nil then
		local tiemData = {}

		if self._config and self._config.TimeFactor then
			local timeStamp = self._config.TimeFactor
			local _, _, y, mon, d, h, m, s = string.find(timeStamp.start[1], "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
			local table = {
				year = y,
				month = mon,
				day = d,
				hour = h,
				min = m,
				sec = s
			}
			local startTime = TimeUtil:timeByRemoteDate(table)
			local _, _, y, mon, d, h, m, s = string.find(timeStamp["end"], "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
			local table = {
				year = y,
				month = mon,
				day = d,
				hour = h,
				min = m,
				sec = s
			}

			tiemData.startTime = startTime
			tiemData.endTime = TimeUtil:timeByRemoteDate(table)
			self._timeinfo = tiemData
		end
	end

	return self._timeinfo
end

function ActivityTpurchase:getShopPackageConfig()
	self._packageShopConfig = self._packageShopConfig or ShopPackage:new(self:getTimePurchaseId())

	return self._packageShopConfig
end
