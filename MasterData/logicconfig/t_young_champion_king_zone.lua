-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_champion_king_zone.lua

module("logicconfig.config.t_young_champion_king_zone", package.seeall)

local title = {
	activityId = 1,
	areaIds = 3,
	zoneId = 2,
	name = 4
}
local dataList = {
	{
		391001,
		0,
		{
			0,
			0
		},
		"000战区"
	},
	{
		391001,
		1,
		{
			1,
			15
		},
		"001战区"
	},
	{
		391001,
		2,
		{
			16,
			60
		},
		"002战区"
	},
	{
		391001,
		3,
		{
			61,
			109
		},
		"003战区"
	},
	{
		391001,
		4,
		{
			110,
			132
		},
		"004战区"
	},
	{
		391001,
		5,
		{
			133,
			145
		},
		"005战区"
	},
	{
		391001,
		6,
		{
			146,
			152
		},
		"006战区"
	},
	{
		391001,
		7,
		{
			153,
			156
		},
		"007战区"
	},
	{
		391001,
		8,
		{
			157,
			999
		},
		"008战区"
	}
}
local t_young_champion_king_zone = {
	[391001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_young_champion_king_zone.dataList = dataList

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

return t_young_champion_king_zone
