-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dual_dragon_extreme_stage.lua

module("logicconfig.config.t_dual_dragon_extreme_stage", package.seeall)

local title = {
	stageId = 3,
	name = 7,
	buffId = 5,
	debuffId = 6,
	creepsMasterId = 4,
	groupId = 2,
	activityId = 1
}
local dataList = {
	{
		258001,
		1,
		1,
		1001,
		1,
		2,
		"神判-I"
	},
	{
		258001,
		1,
		2,
		1002,
		3,
		4,
		"神判-II"
	},
	{
		258001,
		1,
		3,
		1003,
		5,
		6,
		"神判-III"
	},
	{
		258001,
		1,
		4,
		1004,
		7,
		8,
		"神判-IV"
	},
	{
		258001,
		2,
		1,
		2001,
		11,
		12,
		"裁决-I"
	},
	{
		258001,
		2,
		2,
		2002,
		13,
		14,
		"裁决-II"
	},
	{
		258001,
		2,
		3,
		2003,
		15,
		16,
		"裁决-III"
	},
	{
		258001,
		2,
		4,
		2004,
		17,
		18,
		"裁决-IV"
	},
	{
		258002,
		1,
		1,
		1001,
		1,
		2,
		"神判-I"
	},
	{
		258002,
		1,
		2,
		1002,
		3,
		4,
		"神判-II"
	},
	{
		258002,
		1,
		3,
		1003,
		5,
		6,
		"神判-III"
	},
	{
		258002,
		1,
		4,
		1004,
		7,
		8,
		"神判-IV"
	},
	{
		258002,
		2,
		1,
		2001,
		11,
		12,
		"裁决-I"
	},
	{
		258002,
		2,
		2,
		2002,
		13,
		14,
		"裁决-II"
	},
	{
		258002,
		2,
		3,
		2003,
		15,
		16,
		"裁决-III"
	},
	{
		258002,
		2,
		4,
		2004,
		17,
		18,
		"裁决-IV"
	}
}
local t_dual_dragon_extreme_stage = {
	[258001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		}
	},
	[258002] = {
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16]
		}
	}
}

t_dual_dragon_extreme_stage.dataList = dataList

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

return t_dual_dragon_extreme_stage
