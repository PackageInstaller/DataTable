-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_psychiced_tower_activity.lua

module("logicconfig.config.t_psychiced_tower_activity", package.seeall)

local title = {
	activityId = 1,
	showBar = 2,
	jumpTo = 3
}
local dataList = {
	{
		388001,
		"10:388001",
		"func#191#388#388001"
	},
	{
		388002,
		"10:388002",
		"func#191#388#388002"
	},
	{
		388003,
		"10:388003",
		"func#191#388#388003"
	},
	{
		388004,
		"10:388004",
		"func#191#388#388004"
	},
	{
		388005,
		"10:388005",
		"func#191#388#388005"
	},
	{
		388006,
		"10:388006",
		"func#191#388#388006"
	},
	{
		388007,
		"10:388007",
		"func#191#388#388007"
	},
	{
		388008,
		"10:388008",
		"func#191#388#388008"
	},
	{
		388009,
		"10:388009",
		"func#191#388#388009"
	},
	{
		388010,
		"10:388010",
		"func#191#388#388010"
	},
	{
		388011,
		"10:388011",
		"func#191#388#388011"
	},
	{
		388012,
		"10:388012",
		"func#191#388#388012"
	},
	{
		388013,
		"10:388013",
		"func#191#388#388013"
	},
	{
		388014,
		"10:388014",
		"func#191#388#388014"
	},
	{
		388015,
		"10:388015",
		"func#191#388#388015"
	},
	{
		388016,
		"10:388016",
		"func#191#388#388016"
	}
}
local t_psychiced_tower_activity = {
	[388001] = dataList[1],
	[388002] = dataList[2],
	[388003] = dataList[3],
	[388004] = dataList[4],
	[388005] = dataList[5],
	[388006] = dataList[6],
	[388007] = dataList[7],
	[388008] = dataList[8],
	[388009] = dataList[9],
	[388010] = dataList[10],
	[388011] = dataList[11],
	[388012] = dataList[12],
	[388013] = dataList[13],
	[388014] = dataList[14],
	[388015] = dataList[15],
	[388016] = dataList[16]
}

t_psychiced_tower_activity.dataList = dataList

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

return t_psychiced_tower_activity
