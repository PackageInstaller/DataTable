-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_buy_refresh_times.lua

module("logicconfig.config.t_show_down_buy_refresh_times", package.seeall)

local title = {
	refreshTimesPlanId = 1,
	cost = 4,
	count = 3,
	buyId = 2
}
local dataList = {
	{
		1,
		1,
		1,
		"105:6096:100"
	},
	{
		1,
		2,
		2,
		"105:6096:200"
	},
	{
		1,
		3,
		3,
		"105:6096:500"
	},
	{
		2,
		1,
		0,
		""
	}
}
local t_show_down_buy_refresh_times = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4]
	}
}

t_show_down_buy_refresh_times.dataList = dataList

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

return t_show_down_buy_refresh_times
