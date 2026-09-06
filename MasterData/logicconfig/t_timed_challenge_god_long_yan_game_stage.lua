-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_god_long_yan_game_stage.lua

module("logicconfig.config.t_timed_challenge_god_long_yan_game_stage", package.seeall)

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
		"1:10#2:5",
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
		"1:15#2:6",
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
		"1:20#2:7",
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
		"1:25#2:8",
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
		"1:25#2:8",
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
		"1:30#2:10",
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
		"1:30#2:15",
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
		"1:35#2:20",
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
		"1:35#2:25",
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
		"1:40#2:25",
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
		"1:45#2:30",
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
		"1:45#2:40",
		0.4,
		0.6,
		2
	}
}
local t_timed_challenge_god_long_yan_game_stage = {
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

t_timed_challenge_god_long_yan_game_stage.dataList = dataList

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

return t_timed_challenge_god_long_yan_game_stage
