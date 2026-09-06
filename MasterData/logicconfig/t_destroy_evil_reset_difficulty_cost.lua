-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_destroy_evil_reset_difficulty_cost.lua

module("logicconfig.config.t_destroy_evil_reset_difficulty_cost", package.seeall)

local title = {
	resetDifficultyCostPlanId = 1,
	cost = 3,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"105:6098:100"
	},
	{
		1,
		2,
		"105:6098:100"
	},
	{
		1,
		3,
		"105:6098:100"
	},
	{
		1,
		4,
		"105:6098:100"
	},
	{
		1,
		5,
		"105:6098:100"
	},
	{
		1,
		6,
		"105:6098:100"
	},
	{
		1,
		7,
		"105:6098:100"
	},
	{
		1,
		8,
		"105:6098:100"
	},
	{
		1,
		9,
		"105:6098:100"
	},
	{
		1,
		10,
		"105:6098:100"
	},
	{
		1,
		11,
		"105:6098:200"
	},
	{
		1,
		12,
		"105:6098:200"
	},
	{
		1,
		13,
		"105:6098:200"
	},
	{
		1,
		14,
		"105:6098:200"
	},
	{
		1,
		15,
		"105:6098:200"
	},
	{
		1,
		16,
		"105:6098:200"
	},
	{
		1,
		17,
		"105:6098:200"
	},
	{
		1,
		18,
		"105:6098:200"
	},
	{
		1,
		19,
		"105:6098:200"
	},
	{
		1,
		20,
		"105:6098:200"
	},
	{
		1,
		21,
		"105:6098:300"
	},
	{
		1,
		22,
		"105:6098:300"
	},
	{
		1,
		23,
		"105:6098:300"
	},
	{
		1,
		24,
		"105:6098:300"
	},
	{
		1,
		25,
		"105:6098:300"
	},
	{
		1,
		26,
		"105:6098:300"
	},
	{
		1,
		27,
		"105:6098:300"
	},
	{
		1,
		28,
		"105:6098:300"
	},
	{
		1,
		29,
		"105:6098:300"
	},
	{
		1,
		30,
		"105:6098:300"
	}
}
local t_destroy_evil_reset_difficulty_cost = {
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
		dataList[29],
		dataList[30]
	}
}

t_destroy_evil_reset_difficulty_cost.dataList = dataList

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

return t_destroy_evil_reset_difficulty_cost
