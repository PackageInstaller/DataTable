-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fight_pick_up_idea_game_plan.lua

module("logicconfig.config.t_origin_fight_pick_up_idea_game_plan", package.seeall)

local title = {
	id = 1,
	index = 2,
	noNeedLowNums = 4,
	lowNums = 3,
	highNums = 5
}
local dataList = {
	{
		1,
		1,
		6,
		0,
		1
	},
	{
		1,
		2,
		6,
		0,
		2
	},
	{
		1,
		3,
		4,
		0,
		1
	},
	{
		1,
		4,
		6,
		0,
		2
	},
	{
		1,
		5,
		8,
		0,
		1
	},
	{
		1,
		6,
		8,
		0,
		2
	},
	{
		1,
		7,
		6,
		0,
		1
	},
	{
		1,
		8,
		6,
		0,
		2
	},
	{
		1,
		9,
		10,
		0,
		1
	},
	{
		1,
		10,
		8,
		0,
		2
	},
	{
		1,
		11,
		10,
		0,
		1
	},
	{
		1,
		12,
		12,
		0,
		2
	}
}
local t_origin_fight_pick_up_idea_game_plan = {
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
		dataList[12]
	}
}

t_origin_fight_pick_up_idea_game_plan.dataList = dataList

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

return t_origin_fight_pick_up_idea_game_plan
