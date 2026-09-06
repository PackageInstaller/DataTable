-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_arena_buy_fight_times.lua

module("logicconfig.config.t_king_arena_buy_fight_times", package.seeall)

local title = {
	buyFightTimePlanId = 1,
	cost = 3,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"105:6100:20"
	},
	{
		1,
		2,
		"105:6100:20"
	},
	{
		1,
		3,
		"105:6100:50"
	},
	{
		1,
		4,
		"105:6100:50"
	},
	{
		1,
		5,
		"105:6100:100"
	},
	{
		1,
		6,
		"105:6100:100"
	},
	{
		1,
		7,
		"105:6100:200"
	},
	{
		1,
		8,
		"105:6100:200"
	},
	{
		1,
		9,
		"105:6100:300"
	},
	{
		1,
		10,
		"105:6100:300"
	},
	{
		1,
		11,
		"204:205:5"
	},
	{
		1,
		12,
		"204:205:5"
	},
	{
		1,
		13,
		"204:205:5"
	},
	{
		1,
		14,
		"204:205:5"
	},
	{
		1,
		15,
		"204:205:5"
	}
}
local t_king_arena_buy_fight_times = {
	{
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

t_king_arena_buy_fight_times.dataList = dataList

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

return t_king_arena_buy_fight_times
