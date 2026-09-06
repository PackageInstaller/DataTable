-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_farnas_clg_extreme_buff.lua

module("logicconfig.config.t_divine_farnas_clg_extreme_buff", package.seeall)

local title = {
	raceCount = 3,
	activityId = 1,
	buffId = 2,
	buffDesc = 4
}
local dataList = {
	{
		522001,
		1,
		2,
		"己方闪避率+0%"
	},
	{
		522001,
		2,
		5,
		"己方闪避率+10%"
	},
	{
		522001,
		3,
		8,
		"己方闪避率+20%"
	},
	{
		522001,
		4,
		11,
		"己方闪避率+30%"
	},
	{
		522001,
		5,
		14,
		"己方闪避率+40%"
	},
	{
		522001,
		6,
		17,
		"己方闪避率+50%"
	},
	{
		522001,
		7,
		23,
		"己方闪避率+60%"
	},
	{
		522001,
		8,
		24,
		"己方闪避率+80%"
	}
}
local t_divine_farnas_clg_extreme_buff = {
	[522001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_divine_farnas_clg_extreme_buff.dataList = dataList

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

return t_divine_farnas_clg_extreme_buff
