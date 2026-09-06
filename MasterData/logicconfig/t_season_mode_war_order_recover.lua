-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_war_order_recover.lua

module("logicconfig.config.t_season_mode_war_order_recover", package.seeall)

local title = {
	cost = 4,
	recoverPlan = 1,
	energy = 3,
	days = 2
}
local dataList = {
	{
		1,
		1,
		320,
		"105:6048:200"
	},
	{
		1,
		2,
		640,
		"105:6048:400"
	},
	{
		2,
		1,
		320,
		"105:6048:200"
	},
	{
		2,
		2,
		640,
		"105:6048:400"
	},
	{
		3,
		1,
		320,
		"105:6048:200"
	},
	{
		3,
		2,
		640,
		"105:6048:400"
	}
}
local t_season_mode_war_order_recover = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6]
	}
}

t_season_mode_war_order_recover.dataList = dataList

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

return t_season_mode_war_order_recover
