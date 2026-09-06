-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_defend_carrot_stage.lua

module("logicconfig.config.t_defend_carrot_stage", package.seeall)

local title = {
	stagePlanId = 4,
	stageId = 2,
	openDate = 6,
	passStoryId = 5,
	activityId = 1,
	stageName = 3
}
local dataList = {
	{
		517001,
		1,
		"第1关",
		1,
		0,
		"2025-09-26T05:00:00"
	},
	{
		517001,
		2,
		"第2关",
		2,
		0,
		"2025-09-26T05:00:00"
	},
	{
		517001,
		3,
		"第3关",
		3,
		4820013,
		"2025-09-26T05:00:00"
	},
	{
		517001,
		4,
		"第4关",
		4,
		0,
		"2025-09-27T05:00:00"
	},
	{
		517001,
		5,
		"第5关",
		5,
		0,
		"2025-09-27T05:00:00"
	},
	{
		517001,
		6,
		"第6关",
		6,
		0,
		"2025-09-27T05:00:00"
	},
	{
		517001,
		7,
		"第7关",
		7,
		4820014,
		"2025-09-28T05:00:00"
	},
	{
		517001,
		8,
		"第8关",
		8,
		0,
		"2025-09-28T05:00:00"
	},
	{
		517001,
		9,
		"第9关",
		9,
		0,
		"2025-09-28T05:00:00"
	},
	{
		517001,
		10,
		"第10关",
		10,
		0,
		"2025-09-28T05:00:00"
	},
	{
		517001,
		11,
		"第11关",
		11,
		4820015,
		"2025-09-28T05:00:00"
	},
	{
		517001,
		12,
		"第12关",
		12,
		0,
		"2025-09-28T05:00:00"
	},
	{
		517001,
		13,
		"第13关",
		13,
		0,
		"2025-09-28T05:00:00"
	},
	{
		517001,
		14,
		"第14关",
		14,
		0,
		"2025-09-28T05:00:00"
	},
	{
		517001,
		15,
		"第15关",
		15,
		4820016,
		"2025-09-28T05:00:00"
	}
}
local t_defend_carrot_stage = {
	[517001] = {
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
		dataList[15]
	}
}

t_defend_carrot_stage.dataList = dataList

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

return t_defend_carrot_stage
