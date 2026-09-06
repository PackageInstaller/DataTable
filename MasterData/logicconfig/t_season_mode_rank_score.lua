-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_rank_score.lua

module("logicconfig.config.t_season_mode_rank_score", package.seeall)

local title = {
	rankStart = 2,
	scorePlanId = 1,
	rankEnd = 3,
	score = 4
}
local dataList = {
	{
		1,
		1,
		1,
		2000
	},
	{
		1,
		2,
		10,
		1800
	},
	{
		1,
		11,
		50,
		1700
	},
	{
		1,
		51,
		100,
		1600
	},
	{
		1,
		101,
		500,
		1500
	},
	{
		1,
		501,
		1000,
		1400
	},
	{
		1,
		1001,
		5000,
		1300
	},
	{
		1,
		5001,
		10000,
		1200
	},
	{
		2,
		1,
		1,
		2000
	},
	{
		2,
		2,
		10,
		1800
	},
	{
		2,
		11,
		50,
		1700
	},
	{
		2,
		51,
		100,
		1600
	},
	{
		2,
		101,
		500,
		1500
	},
	{
		2,
		501,
		1000,
		1400
	},
	{
		2,
		1001,
		5000,
		1300
	},
	{
		2,
		5001,
		10000,
		1200
	},
	{
		3,
		1,
		1,
		2000
	},
	{
		3,
		2,
		10,
		1800
	},
	{
		3,
		11,
		50,
		1700
	},
	{
		3,
		51,
		100,
		1600
	},
	{
		3,
		101,
		500,
		1500
	},
	{
		3,
		501,
		1000,
		1400
	},
	{
		3,
		1001,
		5000,
		1300
	},
	{
		3,
		5001,
		10000,
		1200
	},
	{
		3,
		10001,
		15000,
		1100
	},
	{
		3,
		15001,
		20000,
		1000
	},
	{
		3,
		20001,
		30000,
		900
	},
	{
		3,
		30001,
		40000,
		800
	},
	{
		3,
		40001,
		50000,
		700
	},
	{
		3,
		50001,
		70000,
		600
	},
	{
		3,
		70001,
		100000,
		500
	}
}
local t_season_mode_rank_score = {
	{
		dataList[1],
		dataList[2],
		[11] = dataList[3],
		[51] = dataList[4],
		[101] = dataList[5],
		[501] = dataList[6],
		[1001] = dataList[7],
		[5001] = dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		[11] = dataList[11],
		[51] = dataList[12],
		[101] = dataList[13],
		[501] = dataList[14],
		[1001] = dataList[15],
		[5001] = dataList[16]
	},
	{
		dataList[17],
		dataList[18],
		[11] = dataList[19],
		[51] = dataList[20],
		[101] = dataList[21],
		[501] = dataList[22],
		[1001] = dataList[23],
		[5001] = dataList[24],
		[10001] = dataList[25],
		[15001] = dataList[26],
		[20001] = dataList[27],
		[30001] = dataList[28],
		[40001] = dataList[29],
		[50001] = dataList[30],
		[70001] = dataList[31]
	}
}

t_season_mode_rank_score.dataList = dataList

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

return t_season_mode_rank_score
