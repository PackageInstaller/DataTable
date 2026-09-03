-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recharge/model/RechargeInfo.lua

RechargeInfo = class("RechargeInfo", objectlua.Object, _M)

RechargeInfo:has("_config", {
	is = "r"
})
RechargeInfo:has("_rechargeList", {
	is = "r"
})
RechargeInfo:has("_rechargeHistory", {
	is = "r"
})

function RechargeInfo:initialize()
	self._rechargeList = {}
	self._rechargeHistory = {}
	self._config = ConfigReader:getDataTable("Mall")
end

function RechargeInfo:synchronize(rechargeInfo)
	for k, v in pairs(rechargeInfo) do
		if k ~= "$" then
			table.insert(self._rechargeList, v)
		end
	end

	table.sort(self._rechargeList, function(a, b)
		if a.Position <= b.Position then
			return true
		else
			return false
		end
	end)
end

function RechargeInfo:synchronizeHistory(rechargeHistory)
	self._rechargeHistory.firstRechargeTime = rechargeHistory.firstRechargeTime
	self._rechargeHistory.rechargeTotal = rechargeHistory.rechargeTotal
	self._rechargeHistory.vipGiftBuyHistory = rechargeHistory.vipGiftBuyHistory
end
