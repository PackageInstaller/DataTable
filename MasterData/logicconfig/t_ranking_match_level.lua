-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ranking_match_level.lua

module("logicconfig.config.t_ranking_match_level", package.seeall)

local title = {
	bigLevel = 3,
	levelName = 2,
	subLevel = 4,
	star = 5,
	level = 1
}
local dataList = {
	{
		1,
		"青铜4",
		1,
		4,
		1
	},
	{
		2,
		"青铜3",
		1,
		3,
		4
	},
	{
		3,
		"青铜2",
		1,
		2,
		7
	},
	{
		4,
		"青铜1",
		1,
		1,
		10
	},
	{
		5,
		"白银4",
		2,
		4,
		13
	},
	{
		6,
		"白银3",
		2,
		3,
		16
	},
	{
		7,
		"白银2",
		2,
		2,
		19
	},
	{
		8,
		"白银1",
		2,
		1,
		22
	},
	{
		9,
		"黄金4",
		3,
		4,
		25
	},
	{
		10,
		"黄金3",
		3,
		3,
		28
	},
	{
		11,
		"黄金2",
		3,
		2,
		31
	},
	{
		12,
		"黄金1",
		3,
		1,
		34
	},
	{
		13,
		"铂金4",
		4,
		4,
		37
	},
	{
		14,
		"铂金3",
		4,
		3,
		40
	},
	{
		15,
		"铂金2",
		4,
		2,
		43
	},
	{
		16,
		"铂金1",
		4,
		1,
		46
	},
	{
		17,
		"钻石4",
		5,
		4,
		49
	},
	{
		18,
		"钻石3",
		5,
		3,
		52
	},
	{
		19,
		"钻石2",
		5,
		2,
		55
	},
	{
		20,
		"钻石1",
		5,
		1,
		58
	},
	{
		21,
		"星耀4",
		6,
		4,
		61
	},
	{
		22,
		"星耀3",
		6,
		3,
		64
	},
	{
		23,
		"星耀2",
		6,
		2,
		67
	},
	{
		24,
		"星耀1",
		6,
		1,
		70
	},
	{
		25,
		"王者4",
		7,
		4,
		73
	},
	{
		26,
		"王者3",
		7,
		3,
		76
	},
	{
		27,
		"王者2",
		7,
		2,
		79
	},
	{
		28,
		"王者1",
		7,
		1,
		82
	},
	{
		29,
		"传说",
		8,
		0,
		85
	}
}
local t_ranking_match_level = {
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
	dataList[21],
	dataList[22],
	dataList[23],
	dataList[24],
	dataList[25],
	dataList[26],
	dataList[27],
	dataList[28],
	dataList[29]
}

t_ranking_match_level.dataList = dataList

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

return t_ranking_match_level
