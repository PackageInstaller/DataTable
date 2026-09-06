-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_aruishi_clg_stage.lua

module("logicconfig.config.t_origin_aruishi_clg_stage", package.seeall)

local title = {
	stageId = 2,
	openTime = 5,
	floorId = 3,
	prize = 7,
	creepsMasterId = 6,
	floorName = 4,
	activityId = 1
}
local dataList = {
	{
		550001,
		1,
		1,
		"萌芽",
		"2026-01-16T05:00:00",
		1001,
		"4:510679:5"
	},
	{
		550001,
		2,
		1,
		"萌芽",
		"2026-01-16T05:00:00",
		1002,
		"4:510679:5"
	},
	{
		550001,
		3,
		2,
		"繁荣",
		"2026-01-16T05:00:00",
		1003,
		"4:510679:5"
	},
	{
		550001,
		4,
		2,
		"繁荣",
		"2026-01-16T05:00:00",
		1004,
		"4:510679:5"
	},
	{
		550001,
		5,
		3,
		"枯荣",
		"2026-01-17T05:00:00",
		1005,
		"4:510679:10"
	},
	{
		550001,
		6,
		3,
		"枯荣",
		"2026-01-17T05:00:00",
		1006,
		"4:510679:10"
	},
	{
		550001,
		7,
		4,
		"轮回",
		"2026-01-17T05:00:00",
		1007,
		"4:510679:10"
	},
	{
		550001,
		8,
		4,
		"轮回",
		"2026-01-17T05:00:00",
		1008,
		"4:510679:10"
	},
	{
		550001,
		9,
		4,
		"轮回",
		"2026-01-17T05:00:00",
		1009,
		"4:510679:10"
	},
	{
		550001,
		10,
		5,
		"本源",
		"2026-01-18T05:00:00",
		1010,
		"4:510679:10"
	},
	{
		550001,
		11,
		5,
		"本源",
		"2026-01-18T05:00:00",
		1011,
		"4:510679:10"
	},
	{
		550001,
		12,
		5,
		"本源",
		"2026-01-18T05:00:00",
		1012,
		"4:510679:10"
	}
}
local t_origin_aruishi_clg_stage = {
	[550001] = {
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
		dataList[12]
	}
}

t_origin_aruishi_clg_stage.dataList = dataList

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

return t_origin_aruishi_clg_stage
