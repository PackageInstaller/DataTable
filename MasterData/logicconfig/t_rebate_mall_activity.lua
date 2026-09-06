-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rebate_mall_activity.lua

module("logicconfig.config.t_rebate_mall_activity", package.seeall)

local title = {
	deduceTo = 5,
	bubbleDesc2 = 8,
	redPointId = 3,
	days = 2,
	deduceFrom = 4,
	bubbleDesc1 = 7,
	activityId = 1,
	raceId = 6
}
local dataList = {
	{
		277001,
		14,
		155,
		"204:22000118:1",
		"10:277001:1",
		12017,
		"6.30-7.14期间充值100元可累计获得1000金条",
		"未使用的金条过期后会<color=#FFFB8AFF>1:1转化为\n钻石</color>返还哦！"
	},
	{
		277002,
		14,
		155,
		"204:22000118:1",
		"10:277002:1",
		11024,
		"6.28-7.12期间充值1000神钻可累计获得\n1000金条，7.12 5点后开启兑换",
		"未使用的金条过期后会<color=#FFFB8AFF>1:1转化为\n钻石</color>返还哦！"
	}
}
local t_rebate_mall_activity = {
	[277001] = dataList[1],
	[277002] = dataList[2]
}

t_rebate_mall_activity.dataList = dataList

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

return t_rebate_mall_activity
