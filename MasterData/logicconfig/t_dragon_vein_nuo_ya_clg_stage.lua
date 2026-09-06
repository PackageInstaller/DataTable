-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_vein_nuo_ya_clg_stage.lua

module("logicconfig.config.t_dragon_vein_nuo_ya_clg_stage", package.seeall)

local title = {
	stageId = 2,
	openTime = 3,
	mapGridCount = 4,
	bossPrize = 7,
	bossTeamId = 6,
	itemCount = 5,
	activityId = 1,
	colCount = 8
}
local dataList = {
	{
		427001,
		1,
		"2026-04-03T05:00:00",
		9,
		8,
		2001,
		"4:419:12",
		3
	},
	{
		427001,
		2,
		"2026-04-03T05:00:00",
		16,
		12,
		2002,
		"4:419:24",
		4
	},
	{
		427001,
		3,
		"2026-04-03T05:00:00",
		25,
		20,
		2003,
		"4:419:36",
		5
	},
	{
		427002,
		1,
		"2024-11-22T05:00:00",
		9,
		8,
		2001,
		"8:1:1",
		3
	},
	{
		427002,
		2,
		"2024-11-22T05:00:00",
		16,
		12,
		2002,
		"8:1:1",
		4
	},
	{
		427002,
		3,
		"2024-11-22T05:00:00",
		25,
		20,
		2003,
		"8:1:1",
		5
	}
}
local t_dragon_vein_nuo_ya_clg_stage = {
	[427001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[427002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_dragon_vein_nuo_ya_clg_stage.dataList = dataList

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

return t_dragon_vein_nuo_ya_clg_stage
