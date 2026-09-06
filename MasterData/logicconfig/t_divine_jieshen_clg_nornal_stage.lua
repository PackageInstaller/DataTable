-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_jieshen_clg_nornal_stage.lua

module("logicconfig.config.t_divine_jieshen_clg_nornal_stage", package.seeall)

local title = {
	stageId = 2,
	openTime = 4,
	name = 3,
	puzzleImgUrl = 6,
	creepsMasterId = 5,
	puzzlePos = 7,
	activityId = 1
}
local dataList = {
	{
		387001,
		1,
		"关卡1",
		"2024-07-26T05:00:00",
		2001,
		"divinejieshen/board_shenyaojieshen_02",
		{
			-156,
			108
		}
	},
	{
		387001,
		2,
		"关卡2",
		"2024-07-27T05:00:00",
		2002,
		"divinejieshen/board_shenyaojieshen_03",
		{
			-55,
			141.3
		}
	},
	{
		387001,
		3,
		"关卡3",
		"2024-07-28T05:00:00",
		2003,
		"divinejieshen/board_shenyaojieshen_04",
		{
			34.3,
			105.8
		}
	},
	{
		387001,
		4,
		"关卡4",
		"2024-07-29T05:00:00",
		2004,
		"divinejieshen/board_shenyaojieshen_05",
		{
			104.1,
			165
		}
	},
	{
		387001,
		5,
		"关卡5",
		"2024-07-30T05:00:00",
		2005,
		"divinejieshen/board_shenyaojieshen_06",
		{
			76,
			50
		}
	},
	{
		387001,
		6,
		"关卡6",
		"2024-07-31T05:00:00",
		2006,
		"divinejieshen/board_shenyaojieshen_07",
		{
			38,
			-123
		}
	},
	{
		387001,
		7,
		"关卡7",
		"2024-08-01T05:00:00",
		2007,
		"divinejieshen/board_shenyaojieshen_08",
		{
			-64,
			-263.2
		}
	},
	{
		387001,
		8,
		"关卡8",
		"2024-08-02T05:00:00",
		2008,
		"divinejieshen/board_shenyaojieshen_09",
		{
			-79,
			-132
		}
	},
	{
		387001,
		9,
		"关卡9",
		"2024-08-03T05:00:00",
		2009,
		"divinejieshen/board_shenyaojieshen_10",
		{
			-203,
			-30
		}
	},
	{
		387001,
		10,
		"关卡10",
		"2024-08-04T05:00:00",
		2010,
		"divinejieshen/board_shenyaojieshen_11",
		{
			100.2,
			-55.2
		}
	}
}
local t_divine_jieshen_clg_nornal_stage = {
	[387001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_divine_jieshen_clg_nornal_stage.dataList = dataList

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

return t_divine_jieshen_clg_nornal_stage
