-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_best_dragon_soul_game_stage.lua

module("logicconfig.config.t_best_dragon_soul_game_stage", package.seeall)

local title = {
	propSettingStr = 6,
	areaInterval = 8,
	rowNum = 4,
	stageIdx = 2,
	colNum = 5,
	rowInterval = 7,
	gamePlanId = 1,
	areaIdx = 3,
	moveDuration = 9
}
local dataList = {
	{
		1,
		1,
		1,
		10,
		7,
		"1:5#2:5#3:8",
		0.6,
		0.6,
		4
	},
	{
		1,
		1,
		2,
		10,
		7,
		"1:10#2:10#3:9",
		0.6,
		0.6,
		3.5
	},
	{
		1,
		1,
		3,
		10,
		7,
		"1:15#2:15#3:10",
		0.6,
		0.6,
		3
	},
	{
		1,
		1,
		4,
		10,
		7,
		"1:20#2:20#3:12",
		0.6,
		0.6,
		3
	},
	{
		1,
		2,
		1,
		12,
		8,
		"1:5#2:5#3:8",
		0.6,
		0.6,
		3
	},
	{
		1,
		2,
		2,
		12,
		8,
		"1:10#2:10#3:9",
		0.4,
		0.6,
		3
	},
	{
		1,
		2,
		3,
		12,
		9,
		"1:15#2:15#3:10",
		0.4,
		0.6,
		2.5
	},
	{
		1,
		2,
		4,
		12,
		9,
		"1:20#2:20#3:12",
		0.4,
		0.6,
		2.5
	},
	{
		1,
		3,
		1,
		14,
		10,
		"1:5#2:5#3:8",
		0.6,
		0.6,
		2.5
	},
	{
		1,
		3,
		2,
		14,
		10,
		"1:10#2:10#3:9",
		0.6,
		0.6,
		2.5
	},
	{
		1,
		3,
		3,
		14,
		11,
		"1:15#2:15#3:10",
		0.4,
		0.6,
		2
	},
	{
		1,
		3,
		4,
		14,
		11,
		"1:20#2:20#3:12",
		0.4,
		0.6,
		2
	}
}
local t_best_dragon_soul_game_stage = {
	{
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_best_dragon_soul_game_stage.dataList = dataList

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

return t_best_dragon_soul_game_stage
