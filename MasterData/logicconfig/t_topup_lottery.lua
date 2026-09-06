-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_topup_lottery.lua

module("logicconfig.config.t_topup_lottery", package.seeall)

local title = {
	bigPrizeTime = 3,
	dailyLimit = 4,
	money = 2,
	prizePlanId = 6,
	redPointId = 7,
	lotteryPlanId = 5,
	activityId = 1,
	gotoCharge = 8
}
local dataList = {
	{
		236001,
		600,
		5,
		20,
		1,
		1,
		437,
		"mibao#GodDiamond"
	}
}
local t_topup_lottery = {
	[236001] = dataList[1]
}

t_topup_lottery.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_topup_lottery
