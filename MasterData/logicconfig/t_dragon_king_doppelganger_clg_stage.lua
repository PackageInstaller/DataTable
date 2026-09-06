-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_king_doppelganger_clg_stage.lua

module("logicconfig.config.t_dragon_king_doppelganger_clg_stage", package.seeall)

local title = {
	stageId = 2,
	openTime = 4,
	activityId = 1,
	creepsMasterId = 3
}
local dataList = {
	{
		315001,
		1,
		1001,
		"2023-09-09T05:00:00"
	},
	{
		315001,
		2,
		1002,
		"2023-11-04T05:00:00"
	},
	{
		315001,
		3,
		1003,
		"2023-11-04T05:00:00"
	},
	{
		315001,
		4,
		1004,
		"2023-11-04T05:00:00"
	},
	{
		315001,
		5,
		1005,
		"2023-11-04T05:00:00"
	},
	{
		315001,
		6,
		1006,
		"2023-11-04T05:00:00"
	},
	{
		315001,
		7,
		1007,
		"2023-11-04T05:00:00"
	},
	{
		315001,
		8,
		1008,
		"2023-11-05T05:00:00"
	},
	{
		315001,
		9,
		1009,
		"2023-11-12T05:00:00"
	},
	{
		315001,
		10,
		1010,
		"2023-11-13T05:00:00"
	},
	{
		315001,
		11,
		1011,
		"2023-11-13T05:00:00"
	},
	{
		315001,
		12,
		1012,
		"2023-11-13T05:00:00"
	},
	{
		315001,
		13,
		1013,
		"2023-11-14T05:00:00"
	},
	{
		315001,
		14,
		1014,
		"2023-11-14T05:00:00"
	},
	{
		315001,
		15,
		1015,
		"2023-11-14T05:00:00"
	}
}
local t_dragon_king_doppelganger_clg_stage = {
	[315001] = {
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

t_dragon_king_doppelganger_clg_stage.dataList = dataList

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

return t_dragon_king_doppelganger_clg_stage
