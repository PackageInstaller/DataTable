-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyinjiade_clg_score.lua

module("logicconfig.config.t_luyinjiade_clg_score", package.seeall)

local title = {
	score = 4,
	damage = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		465001,
		1,
		"0",
		0
	},
	{
		465001,
		2,
		"10000000",
		1
	},
	{
		465001,
		3,
		"20000000",
		2
	},
	{
		465001,
		4,
		"30000000",
		3
	},
	{
		465001,
		5,
		"40000000",
		4
	},
	{
		465001,
		6,
		"50000000",
		5
	},
	{
		465001,
		7,
		"60000000",
		6
	},
	{
		465001,
		8,
		"70000000",
		7
	},
	{
		465001,
		9,
		"80000000",
		8
	},
	{
		465001,
		10,
		"90000000",
		9
	},
	{
		465001,
		11,
		"100000000",
		10
	},
	{
		465001,
		12,
		"110000000",
		11
	},
	{
		465001,
		13,
		"120000000",
		12
	},
	{
		465001,
		14,
		"130000000",
		13
	},
	{
		465001,
		15,
		"140000000",
		14
	},
	{
		465001,
		16,
		"150000000",
		15
	},
	{
		465001,
		17,
		"160000000",
		16
	},
	{
		465001,
		18,
		"170000000",
		17
	},
	{
		465001,
		19,
		"180000000",
		18
	},
	{
		465001,
		20,
		"190000000",
		19
	},
	{
		465001,
		21,
		"200000000",
		20
	}
}
local t_luyinjiade_clg_score = {
	[465001] = {
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
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_luyinjiade_clg_score.dataList = dataList

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

return t_luyinjiade_clg_score
