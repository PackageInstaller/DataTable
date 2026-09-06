-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ci_yuan_holy_dragon_clg_daily_balance.lua

module("logicconfig.config.t_ci_yuan_holy_dragon_clg_daily_balance", package.seeall)

local title = {
	id = 2,
	dateRange = 3,
	activityId = 1,
	des = 4
}
local dataList = {
	{
		306001,
		1,
		"2025-04-11 05:00:00#2025-04-18 05:00:00",
		"首周上榜前300名获得奖励"
	},
	{
		306001,
		2,
		"2026-04-10 05:00:00#2026-04-17 05:00:00",
		"上榜前500名获得奖励"
	}
}
local t_ci_yuan_holy_dragon_clg_daily_balance = {
	[306001] = {
		dataList[1],
		dataList[2]
	}
}

t_ci_yuan_holy_dragon_clg_daily_balance.dataList = dataList

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

return t_ci_yuan_holy_dragon_clg_daily_balance
