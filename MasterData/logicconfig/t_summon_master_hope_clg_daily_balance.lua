-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_hope_clg_daily_balance.lua

module("logicconfig.config.t_summon_master_hope_clg_daily_balance", package.seeall)

local title = {
	id = 2,
	dateRange = 3,
	activityId = 1,
	des = 4
}
local dataList = {
	{
		403001,
		1,
		"2026-04-03 05:00:00#2026-04-10 05:00:00",
		"每日前500名"
	}
}
local t_summon_master_hope_clg_daily_balance = {
	[403001] = {
		dataList[1]
	}
}

t_summon_master_hope_clg_daily_balance.dataList = dataList

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

return t_summon_master_hope_clg_daily_balance
