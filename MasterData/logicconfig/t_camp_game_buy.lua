-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_game_buy.lua

module("logicconfig.config.t_camp_game_buy", package.seeall)

local title = {
	buyNum = 2,
	buyPlanId = 1,
	price = 3
}
local dataList = {
	{
		1,
		1,
		"105:2:50"
	},
	{
		1,
		2,
		"105:2:50"
	},
	{
		1,
		3,
		"105:2:50"
	},
	{
		1,
		4,
		"105:2:50"
	},
	{
		1,
		5,
		"105:2:50"
	},
	{
		1,
		6,
		"105:2:50"
	},
	{
		1,
		7,
		"105:2:50"
	},
	{
		1,
		8,
		"105:2:50"
	},
	{
		1,
		9,
		"105:2:50"
	},
	{
		1,
		10,
		"105:2:50"
	},
	{
		2,
		1,
		"105:2:50"
	},
	{
		2,
		2,
		"105:2:50"
	},
	{
		2,
		3,
		"105:2:50"
	},
	{
		2,
		4,
		"105:2:50"
	},
	{
		2,
		5,
		"105:2:50"
	},
	{
		2,
		6,
		"105:2:50"
	},
	{
		2,
		7,
		"105:2:50"
	},
	{
		2,
		8,
		"105:2:50"
	},
	{
		2,
		9,
		"105:2:50"
	},
	{
		2,
		10,
		"105:2:50"
	}
}
local t_camp_game_buy = {
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
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_camp_game_buy.dataList = dataList

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

return t_camp_game_buy
