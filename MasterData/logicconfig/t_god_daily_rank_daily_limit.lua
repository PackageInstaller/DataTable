-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_daily_rank_daily_limit.lua

module("logicconfig.config.t_god_daily_rank_daily_limit", package.seeall)

local title = {
	id = 2,
	limitPlanId = 1,
	effectTime = 3,
	dailyRankLimit = 4
}
local dataList = {
	{
		1,
		1,
		"2026-03-13#2026-03-27",
		500
	},
	{
		2,
		1,
		"2026-04-10#2026-04-24",
		500
	},
	{
		3,
		1,
		"2025-04-10#2025-04-24",
		500
	}
}
local t_god_daily_rank_daily_limit = {
	{
		dataList[1]
	},
	{
		dataList[2]
	},
	{
		dataList[3]
	}
}

t_god_daily_rank_daily_limit.dataList = dataList

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

return t_god_daily_rank_daily_limit
