-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_explore_under_fight_event.lua

module("logicconfig.config.t_explore_under_fight_event", package.seeall)

local title = {
	iconId = 5,
	planId = 1,
	prize = 4,
	ratio = 3,
	difficulty = 2
}
local dataList = {
	{
		1,
		1,
		8000,
		"4:510017:1",
		5
	},
	{
		1,
		2,
		9000,
		"4:510016:1",
		5
	},
	{
		1,
		3,
		10000,
		"4:510015:1",
		5
	},
	{
		1,
		4,
		11000,
		"4:510014:1",
		5
	},
	{
		2,
		1,
		8000,
		"10:459001:8",
		5
	},
	{
		2,
		2,
		9000,
		"10:459001:12",
		5
	},
	{
		2,
		3,
		10000,
		"10:459001:16",
		5
	},
	{
		2,
		4,
		11000,
		"10:459001:20",
		5
	},
	{
		3,
		1,
		8000,
		"10:459002:8",
		5
	},
	{
		3,
		2,
		9000,
		"10:459002:12",
		5
	},
	{
		3,
		3,
		10000,
		"10:459002:16",
		5
	},
	{
		3,
		4,
		11000,
		"10:459002:20",
		5
	},
	{
		4,
		1,
		8000,
		"10:459003:8",
		5
	},
	{
		4,
		2,
		9000,
		"10:459003:12",
		5
	},
	{
		4,
		3,
		10000,
		"10:459003:16",
		5
	},
	{
		4,
		4,
		11000,
		"10:459003:20",
		5
	},
	{
		5,
		1,
		8000,
		"10:459004:8",
		5
	},
	{
		5,
		2,
		9000,
		"10:459004:12",
		5
	},
	{
		5,
		3,
		10000,
		"10:459004:16",
		5
	},
	{
		5,
		4,
		11000,
		"10:459004:20",
		5
	}
}
local t_explore_under_fight_event = {
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
	},
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
	},
	{
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_explore_under_fight_event.dataList = dataList

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

return t_explore_under_fight_event
