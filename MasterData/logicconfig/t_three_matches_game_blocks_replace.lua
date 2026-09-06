-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_matches_game_blocks_replace.lua

module("logicconfig.config.t_three_matches_game_blocks_replace", package.seeall)

local title = {
	blockIconPlanId = 1,
	blockId = 2,
	name = 3,
	icon = 4
}
local dataList = {
	{
		1,
		8,
		"红色圆形",
		"icon_bsr"
	},
	{
		1,
		9,
		"黄色圆形",
		"icon_bsy"
	},
	{
		1,
		10,
		"蓝色圆形",
		"icon_bsb"
	},
	{
		1,
		11,
		"绿色圆形",
		"icon_bsg"
	},
	{
		1,
		12,
		"紫色圆形",
		"icon_bs1"
	}
}
local t_three_matches_game_blocks_replace = {
	{
		[8] = dataList[1],
		[9] = dataList[2],
		[10] = dataList[3],
		[11] = dataList[4],
		[12] = dataList[5]
	}
}

t_three_matches_game_blocks_replace.dataList = dataList

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

return t_three_matches_game_blocks_replace
