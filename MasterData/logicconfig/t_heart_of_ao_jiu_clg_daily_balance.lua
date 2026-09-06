-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_heart_of_ao_jiu_clg_daily_balance.lua

module("logicconfig.config.t_heart_of_ao_jiu_clg_daily_balance", package.seeall)

local title = {
	id = 2,
	dateRange = 3,
	activityId = 1,
	des = 4
}
local dataList = {
	{
		505001,
		1,
		"2025-09-26 05:00:00#2025-10-03 05:00:00",
		"每日无离阳敖九前100名之前的玩家"
	},
	{
		505001,
		2,
		"2025-09-05 05:00:00#2025-09-12 05:00:00",
		"次周每日前100名"
	}
}
local t_heart_of_ao_jiu_clg_daily_balance = {
	[505001] = {
		dataList[1],
		dataList[2]
	}
}

t_heart_of_ao_jiu_clg_daily_balance.dataList = dataList

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

return t_heart_of_ao_jiu_clg_daily_balance
