-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_halo_game_buy_times.lua

module("logicconfig.config.t_divine_halo_game_buy_times", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	buyTimes = 2
}
local dataList = {
	{
		476001,
		1,
		"204:250372:20"
	},
	{
		476001,
		2,
		"204:250372:20"
	},
	{
		476001,
		3,
		"204:250372:20"
	},
	{
		476001,
		4,
		"204:250372:20"
	},
	{
		476001,
		5,
		"204:250372:20"
	},
	{
		476001,
		6,
		"204:250372:20"
	},
	{
		476001,
		7,
		"204:250372:20"
	},
	{
		476001,
		8,
		"204:250372:20"
	},
	{
		476001,
		9,
		"204:250372:20"
	},
	{
		476001,
		10,
		"204:250372:20"
	},
	{
		476001,
		11,
		"204:250372:20"
	},
	{
		476001,
		12,
		"204:250372:20"
	},
	{
		476001,
		13,
		"204:250372:20"
	},
	{
		476001,
		14,
		"204:250372:20"
	},
	{
		476001,
		15,
		"204:250372:20"
	}
}
local t_divine_halo_game_buy_times = {
	[476001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_divine_halo_game_buy_times.dataList = dataList

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

return t_divine_halo_game_buy_times
