-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_nuo_ya_sister_extreme_clg_prize.lua

module("logicconfig.config.t_divine_nuo_ya_sister_extreme_clg_prize", package.seeall)

local title = {
	stageId = 2,
	prize = 3,
	activityId = 1
}
local dataList = {
	{
		407001,
		1,
		"4:510360:10"
	},
	{
		407001,
		2,
		"4:510360:10"
	},
	{
		407001,
		3,
		"4:510360:10"
	},
	{
		407001,
		4,
		"4:510360:15"
	},
	{
		407001,
		5,
		"4:510360:15"
	},
	{
		407001,
		6,
		"4:510360:20"
	},
	{
		407001,
		7,
		"4:510360:20"
	},
	{
		407002,
		1,
		"8:1:1"
	},
	{
		407002,
		2,
		"8:1:1"
	},
	{
		407002,
		3,
		"8:1:1"
	},
	{
		407002,
		4,
		"8:1:1"
	},
	{
		407002,
		5,
		"8:1:1"
	},
	{
		407002,
		6,
		"8:1:1"
	},
	{
		407002,
		7,
		"8:1:1"
	}
}
local t_divine_nuo_ya_sister_extreme_clg_prize = {
	[407001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[407002] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_divine_nuo_ya_sister_extreme_clg_prize.dataList = dataList

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

return t_divine_nuo_ya_sister_extreme_clg_prize
