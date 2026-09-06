-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teen_champion_king_zone.lua

module("logicconfig.config.t_teen_champion_king_zone", package.seeall)

local title = {
	activityId = 1,
	areaIds = 3,
	zoneId = 2,
	name = 4
}
local dataList = {
	{
		501001,
		0,
		{
			0,
			0
		},
		"000战区"
	},
	{
		501001,
		1,
		{
			1,
			13
		},
		"001战区"
	},
	{
		501001,
		2,
		{
			14,
			51
		},
		"002战区"
	},
	{
		501001,
		3,
		{
			52,
			103
		},
		"003战区"
	},
	{
		501001,
		4,
		{
			104,
			130
		},
		"004战区"
	},
	{
		501001,
		5,
		{
			131,
			150
		},
		"005战区"
	},
	{
		501001,
		6,
		{
			151,
			167
		},
		"006战区"
	},
	{
		501001,
		7,
		{
			168,
			175
		},
		"007战区"
	},
	{
		501001,
		8,
		{
			176,
			999
		},
		"008战区"
	}
}
local t_teen_champion_king_zone = {
	[501001] = {
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

t_teen_champion_king_zone.dataList = dataList

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

return t_teen_champion_king_zone
