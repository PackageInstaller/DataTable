-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fishing_game_plan.lua

module("logicconfig.config.t_fishing_game_plan", package.seeall)

local title = {
	score = 6,
	fishPlanId = 1,
	effectNum = 7,
	height = 5,
	fishId = 2,
	weight = 3,
	width = 4
}
local dataList = {
	{
		1001,
		1,
		1,
		100,
		100,
		10,
		0
	},
	{
		1001,
		2,
		1270,
		100,
		100,
		9,
		0
	},
	{
		1001,
		3,
		2000,
		100,
		100,
		8,
		0
	},
	{
		1001,
		4,
		1200,
		100,
		100,
		7,
		0
	},
	{
		1001,
		5,
		400,
		100,
		100,
		6,
		0
	},
	{
		1001,
		6,
		1000,
		100,
		100,
		5,
		0
	},
	{
		1001,
		7,
		780,
		100,
		100,
		0,
		-1
	},
	{
		1001,
		8,
		350,
		100,
		100,
		0,
		5
	}
}
local t_fishing_game_plan = {
	[1001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_fishing_game_plan.dataList = dataList

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

return t_fishing_game_plan
