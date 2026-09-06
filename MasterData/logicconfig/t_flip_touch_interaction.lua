-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_flip_touch_interaction.lua

module("logicconfig.config.t_flip_touch_interaction", package.seeall)

local title = {
	cardNum = 8,
	touchEnergy = 4,
	time = 7,
	iconNum2 = 11,
	stageId = 2,
	bgPath = 9,
	planId = 1,
	iconNum1 = 10,
	iconNum4 = 13,
	defaultTime = 5,
	cost = 6,
	touchNum = 3,
	iconNum5 = 14,
	iconNum3 = 12
}
local dataList = {
	{
		1,
		1,
		1,
		5,
		45,
		"105:160:10",
		30,
		{
			2,
			5
		},
		"operationsummary/bg_nsds",
		4,
		4,
		2,
		0,
		0
	},
	{
		1,
		2,
		1,
		5,
		45,
		"105:160:10",
		30,
		{
			2,
			6
		},
		"operationsummary/bg_nsds",
		4,
		4,
		4,
		0,
		0
	},
	{
		1,
		3,
		1,
		5,
		50,
		"105:160:10",
		30,
		{
			3,
			6
		},
		"operationsummary/bg_nsds",
		4,
		4,
		4,
		6,
		0
	},
	{
		1,
		4,
		1,
		5,
		60,
		"105:160:10",
		30,
		{
			3,
			8
		},
		"operationsummary/bg_nsds",
		4,
		4,
		6,
		6,
		4
	},
	{
		1,
		5,
		1,
		5,
		65,
		"105:160:10",
		30,
		{
			4,
			7
		},
		"operationsummary/bg_nsds",
		6,
		6,
		6,
		6,
		4
	},
	{
		2,
		1,
		1,
		10,
		90,
		"105:160:20",
		10,
		{
			3,
			8
		},
		"operationsummary/bg_nsds",
		4,
		4,
		6,
		4,
		6
	},
	{
		2,
		2,
		1,
		10,
		90,
		"105:160:20",
		10,
		{
			4,
			6
		},
		"operationsummary/bg_nsds",
		4,
		6,
		4,
		6,
		4
	},
	{
		3,
		1,
		1,
		5,
		30,
		"105:160:20",
		10,
		{
			4,
			4
		},
		"operationsummary/bg_nsds",
		4,
		4,
		4,
		4,
		0
	},
	{
		3,
		2,
		1,
		5,
		40,
		"105:160:20",
		10,
		{
			4,
			6
		},
		"operationsummary/bg_nsds",
		6,
		6,
		6,
		6,
		0
	},
	{
		4,
		1,
		1,
		5,
		40,
		"105:160:20",
		10,
		{
			4,
			6
		},
		"operationsummary/bg_lingshenneizhan_02",
		6,
		6,
		6,
		6,
		0
	},
	{
		5,
		1,
		1,
		5,
		40,
		"",
		0,
		{
			4,
			6
		},
		"views/farnas/bg_fanasi_01",
		6,
		6,
		6,
		6,
		0
	},
	{
		6,
		1,
		1,
		5,
		40,
		"",
		0,
		{
			4,
			4
		},
		"shenyaolongzunshengzhu/bg_shenyaolongzun_01",
		4,
		4,
		4,
		4,
		0
	},
	{
		6,
		2,
		1,
		5,
		50,
		"",
		0,
		{
			4,
			6
		},
		"shenyaolongzunshengzhu/bg_shenyaolongzun_01",
		6,
		6,
		6,
		6,
		0
	},
	{
		7,
		1,
		1,
		5,
		40,
		"",
		0,
		{
			4,
			6
		},
		"views/farnas/bg_fanasi_01",
		6,
		6,
		6,
		6,
		0
	}
}
local t_flip_touch_interaction = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7]
	},
	{
		dataList[8],
		dataList[9]
	},
	{
		dataList[10]
	},
	{
		dataList[11]
	},
	{
		dataList[12],
		dataList[13]
	},
	{
		dataList[14]
	}
}

t_flip_touch_interaction.dataList = dataList

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

return t_flip_touch_interaction
