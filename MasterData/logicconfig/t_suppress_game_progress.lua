-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_suppress_game_progress.lua

module("logicconfig.config.t_suppress_game_progress", package.seeall)

local title = {
	progressIdx = 2,
	progress = 4,
	gameScore = 3,
	progressPlanId = 1
}
local dataList = {
	{
		1,
		1,
		1000,
		18
	},
	{
		1,
		2,
		2000,
		36
	},
	{
		1,
		3,
		3000,
		54
	},
	{
		1,
		4,
		4000,
		72
	},
	{
		1,
		5,
		5000,
		90
	},
	{
		1,
		6,
		6000,
		108
	},
	{
		1,
		7,
		7000,
		126
	},
	{
		1,
		8,
		8000,
		144
	},
	{
		1,
		9,
		9000,
		162
	},
	{
		1,
		10,
		10000,
		180
	},
	{
		2,
		1,
		2,
		60
	},
	{
		2,
		2,
		3,
		120
	},
	{
		2,
		3,
		4,
		180
	},
	{
		3,
		1,
		120,
		35
	},
	{
		3,
		2,
		240,
		70
	},
	{
		3,
		3,
		360,
		105
	},
	{
		3,
		4,
		480,
		140
	},
	{
		3,
		5,
		600,
		180
	},
	{
		4,
		1,
		40,
		35
	},
	{
		4,
		2,
		60,
		70
	},
	{
		4,
		3,
		80,
		105
	},
	{
		4,
		4,
		100,
		140
	},
	{
		4,
		5,
		120,
		180
	},
	{
		5,
		1,
		10,
		35
	},
	{
		5,
		2,
		20,
		70
	},
	{
		5,
		3,
		30,
		105
	},
	{
		5,
		4,
		40,
		140
	},
	{
		5,
		5,
		50,
		180
	}
}
local t_suppress_game_progress = {
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
		dataList[13]
	},
	{
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	},
	{
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23]
	},
	{
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28]
	}
}

t_suppress_game_progress.dataList = dataList

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

return t_suppress_game_progress
