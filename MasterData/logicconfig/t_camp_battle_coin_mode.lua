-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_coin_mode.lua

module("logicconfig.config.t_camp_battle_coin_mode", package.seeall)

local title = {
	cost = 4,
	prize = 5,
	progress = 6,
	type = 2,
	id = 3,
	reward = 7,
	activityId = 1
}
local dataList = {
	{
		187001,
		1,
		1,
		"8:1:50000",
		"10:187002:60",
		5,
		"10:187002:60#4:510075:5"
	},
	{
		187001,
		1,
		2,
		"8:1:100000",
		"10:187002:90",
		10,
		"10:187002:90#4:510075:10"
	},
	{
		187001,
		1,
		3,
		"8:1:250000",
		"10:187002:120",
		25,
		"10:187002:120#4:510075:25"
	},
	{
		187001,
		2,
		1,
		"8:1:100000",
		"10:187002:75",
		75,
		"10:187002:75#4:510076:75"
	},
	{
		187001,
		2,
		2,
		"8:1:200000",
		"10:187002:100",
		100,
		"10:187002:100#4:510076:100"
	},
	{
		187001,
		2,
		3,
		"8:1:500000",
		"10:187002:125",
		125,
		"10:187002:125#4:510076:125"
	},
	{
		187002,
		1,
		1,
		"8:1:50000",
		"10:187002:60",
		5,
		"10:187002:60#4:510075:5"
	},
	{
		187002,
		1,
		2,
		"8:1:100000",
		"10:187002:90",
		10,
		"10:187002:90#4:510075:10"
	},
	{
		187002,
		1,
		3,
		"8:1:250000",
		"10:187002:120",
		25,
		"10:187002:120#4:510075:25"
	},
	{
		187002,
		2,
		1,
		"8:1:100000",
		"10:187002:75",
		75,
		"10:187002:75#4:510076:75"
	},
	{
		187002,
		2,
		2,
		"8:1:200000",
		"10:187002:100",
		100,
		"10:187002:100#4:510076:100"
	},
	{
		187002,
		2,
		3,
		"8:1:500000",
		"10:187002:125",
		125,
		"10:187002:125#4:510076:125"
	}
}
local t_camp_battle_coin_mode = {
	[187001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		}
	},
	[187002] = {
		{
			dataList[7],
			dataList[8],
			dataList[9]
		},
		{
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_camp_battle_coin_mode.dataList = dataList

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

return t_camp_battle_coin_mode
