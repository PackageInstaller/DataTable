-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_matches_game_item_supply.lua

module("logicconfig.config.t_three_matches_game_item_supply", package.seeall)

local title = {
	number = 3,
	blockId = 2,
	itemPlanId = 1
}
local dataList = {
	{
		1,
		18,
		14
	},
	{
		1,
		19,
		14
	},
	{
		1,
		21,
		14
	},
	{
		2,
		18,
		9
	},
	{
		2,
		19,
		9
	},
	{
		2,
		21,
		9
	},
	{
		3,
		18,
		4
	},
	{
		3,
		19,
		4
	},
	{
		3,
		21,
		4
	}
}
local t_three_matches_game_item_supply = {
	{
		[18] = dataList[1],
		[19] = dataList[2],
		[21] = dataList[3]
	},
	{
		[18] = dataList[4],
		[19] = dataList[5],
		[21] = dataList[6]
	},
	{
		[18] = dataList[7],
		[19] = dataList[8],
		[21] = dataList[9]
	}
}

t_three_matches_game_item_supply.dataList = dataList

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

return t_three_matches_game_item_supply
