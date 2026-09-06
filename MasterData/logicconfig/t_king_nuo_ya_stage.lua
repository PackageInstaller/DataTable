-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_nuo_ya_stage.lua

module("logicconfig.config.t_king_nuo_ya_stage", package.seeall)

local title = {
	stageId = 2,
	showAttr = 5,
	buffPlans = 4,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		321001,
		1,
		10101,
		{
			1,
			2,
			3
		},
		"3"
	},
	{
		321001,
		2,
		10102,
		{
			1,
			2,
			3
		},
		"0"
	},
	{
		321001,
		3,
		10103,
		{
			4,
			5,
			6
		},
		"1"
	},
	{
		321001,
		4,
		10104,
		{
			4,
			5,
			6
		},
		"2"
	},
	{
		321001,
		5,
		10105,
		{
			4,
			5,
			6
		},
		"3"
	},
	{
		321001,
		6,
		10106,
		{
			7,
			8,
			9
		},
		"0#1"
	},
	{
		321001,
		7,
		10107,
		{
			7,
			8,
			9
		},
		"2#3"
	},
	{
		321001,
		8,
		10108,
		{
			7,
			8,
			9
		},
		"0#2"
	},
	{
		321001,
		9,
		10109,
		{
			7,
			8,
			9
		},
		"1#3"
	},
	{
		321001,
		10,
		20101,
		{
			10,
			11,
			12
		},
		"5"
	},
	{
		321001,
		11,
		20102,
		{
			10,
			11,
			12
		},
		"4"
	},
	{
		321001,
		12,
		20103,
		{
			13,
			14,
			15
		},
		"5"
	},
	{
		321001,
		13,
		20104,
		{
			13,
			14,
			15
		},
		"4"
	},
	{
		321001,
		14,
		20105,
		{
			13,
			14,
			15
		},
		"6"
	},
	{
		321001,
		15,
		20106,
		{
			16,
			17,
			18
		},
		"5#4"
	},
	{
		321001,
		16,
		20107,
		{
			16,
			17,
			18
		},
		"5#6"
	},
	{
		321001,
		17,
		20108,
		{
			16,
			17,
			18
		},
		"4#6"
	},
	{
		321001,
		18,
		20109,
		{
			16,
			17,
			18
		},
		"5#4"
	}
}
local t_king_nuo_ya_stage = {
	[321001] = {
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
		dataList[18]
	}
}

t_king_nuo_ya_stage.dataList = dataList

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

return t_king_nuo_ya_stage
