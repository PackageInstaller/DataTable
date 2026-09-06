-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_defend_carrot_stage_progress.lua

module("logicconfig.config.t_defend_carrot_stage_progress", package.seeall)

local title = {
	prizeId = 2,
	stageId = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		517001,
		1,
		1,
		"10:517001:1000"
	},
	{
		517001,
		2,
		2,
		"10:517001:1000"
	},
	{
		517001,
		3,
		3,
		"10:517001:1000"
	},
	{
		517001,
		4,
		4,
		"10:517001:1000"
	},
	{
		517001,
		5,
		5,
		"10:517001:1000"
	},
	{
		517001,
		6,
		6,
		"10:517001:1000"
	},
	{
		517001,
		7,
		7,
		"10:517001:1000"
	},
	{
		517001,
		8,
		8,
		"10:517001:1000"
	},
	{
		517001,
		9,
		9,
		"10:517001:1000"
	},
	{
		517001,
		10,
		10,
		"10:517001:1000"
	},
	{
		517001,
		11,
		11,
		"10:517001:1000"
	},
	{
		517001,
		12,
		12,
		"10:517001:1000"
	},
	{
		517001,
		13,
		13,
		"10:517001:1000"
	},
	{
		517001,
		14,
		14,
		"10:517001:1000"
	},
	{
		517001,
		15,
		15,
		"10:517001:1000"
	}
}
local t_defend_carrot_stage_progress = {
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

t_defend_carrot_stage_progress.dataList = dataList

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

return t_defend_carrot_stage_progress
