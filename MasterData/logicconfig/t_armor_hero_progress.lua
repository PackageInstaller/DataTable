-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_armor_hero_progress.lua

module("logicconfig.config.t_armor_hero_progress", package.seeall)

local title = {
	progressId = 2,
	progressPlan = 1,
	prize = 4,
	progress = 3
}
local dataList = {
	{
		1,
		1,
		"5000000",
		"10:540008:10"
	},
	{
		1,
		2,
		"10000000",
		"10:540008:10"
	},
	{
		1,
		3,
		"30000000",
		"10:540008:20"
	},
	{
		1,
		4,
		"60000000",
		"10:540008:20"
	},
	{
		1,
		5,
		"100000000",
		"10:540008:20"
	},
	{
		1,
		6,
		"150000000",
		"10:540008:20"
	},
	{
		1,
		7,
		"200000000",
		"10:540007:1"
	},
	{
		2,
		1,
		"5000000",
		"10:540009:10"
	},
	{
		2,
		2,
		"10000000",
		"10:540009:10"
	},
	{
		2,
		3,
		"30000000",
		"10:540009:20"
	},
	{
		2,
		4,
		"60000000",
		"10:540009:20"
	},
	{
		2,
		5,
		"100000000",
		"10:540009:20"
	},
	{
		2,
		6,
		"150000000",
		"10:540009:20"
	},
	{
		2,
		7,
		"200000000",
		"10:540010:1"
	}
}
local t_armor_hero_progress = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_armor_hero_progress.dataList = dataList

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

return t_armor_hero_progress
