-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dark_mm_challenge_stage.lua

module("logicconfig.config.t_holy_dark_mm_challenge_stage", package.seeall)

local title = {
	stageId = 2,
	formPlanIds = 5,
	afterUnlock = 3,
	passNum = 7,
	creepsMasterId = 6,
	prize = 8,
	activityId = 1,
	times = 4
}
local dataList = {
	{
		284001,
		1,
		0,
		2,
		{
			1,
			2,
			3,
			5
		},
		101,
		9,
		"8:1:500000"
	},
	{
		284001,
		2,
		0,
		2,
		{
			1,
			4,
			6,
			7
		},
		102,
		9,
		"4:510184:20"
	},
	{
		284001,
		3,
		0,
		2,
		{
			1,
			3,
			6,
			7
		},
		103,
		9,
		"4:90057:1"
	},
	{
		284001,
		4,
		0,
		2,
		{
			1,
			4,
			5,
			6
		},
		104,
		9,
		"4:510184:30"
	},
	{
		284001,
		5,
		0,
		2,
		{
			2,
			3,
			5,
			7
		},
		105,
		9,
		"4:510184:50"
	},
	{
		284002,
		1,
		0,
		2,
		{
			1,
			2,
			3,
			5
		},
		201,
		9,
		"4:36:2"
	},
	{
		284002,
		2,
		0,
		2,
		{
			1,
			4,
			6,
			7
		},
		202,
		9,
		"4:36:3"
	},
	{
		284002,
		3,
		0,
		2,
		{
			1,
			3,
			6,
			7
		},
		203,
		9,
		"8:1:500000"
	},
	{
		284002,
		4,
		0,
		2,
		{
			1,
			4,
			5,
			6
		},
		204,
		9,
		"4:36:5"
	},
	{
		284002,
		5,
		0,
		2,
		{
			2,
			3,
			5,
			7
		},
		205,
		9,
		"100:11026:1:1"
	}
}
local t_holy_dark_mm_challenge_stage = {
	[284001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[284002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_holy_dark_mm_challenge_stage.dataList = dataList

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

return t_holy_dark_mm_challenge_stage
