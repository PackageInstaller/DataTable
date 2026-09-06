-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_god_dragon_progress.lua

module("logicconfig.config.t_divine_god_dragon_progress", package.seeall)

local title = {
	prizeId = 2,
	killNum = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		346001,
		1,
		2,
		"4:510022:1#8:1:2000000"
	},
	{
		346001,
		2,
		4,
		"4:510022:1#8:1:2000000"
	},
	{
		346001,
		3,
		6,
		"4:510022:1#8:1:2000000"
	},
	{
		346001,
		4,
		8,
		"4:510022:1#8:1:2000000"
	},
	{
		346001,
		5,
		10,
		"4:510022:1#8:1:2000000"
	},
	{
		346002,
		1,
		3,
		"8:1:1000000"
	},
	{
		346002,
		2,
		6,
		"4:111:10"
	},
	{
		346002,
		3,
		9,
		"4:30006:50"
	},
	{
		346002,
		4,
		12,
		"4:510022:5"
	},
	{
		346002,
		5,
		15,
		"4:30006:50"
	}
}
local t_divine_god_dragon_progress = {
	[346001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[346002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_divine_god_dragon_progress.dataList = dataList

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

return t_divine_god_dragon_progress
