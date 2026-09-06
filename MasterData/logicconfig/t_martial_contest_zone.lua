-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_martial_contest_zone.lua

module("logicconfig.config.t_martial_contest_zone", package.seeall)

local title = {
	activityId = 1,
	areaIds = 3,
	zoneId = 2,
	name = 4
}
local dataList = {
	{
		583001,
		0,
		{
			0,
			0
		},
		"000战区"
	},
	{
		583001,
		1,
		{
			1,
			15
		},
		"001战区"
	},
	{
		583001,
		2,
		{
			16,
			61
		},
		"002战区"
	},
	{
		583001,
		3,
		{
			62,
			116
		},
		"003战区"
	},
	{
		583001,
		4,
		{
			117,
			147
		},
		"004战区"
	},
	{
		583001,
		5,
		{
			148,
			170
		},
		"005战区"
	},
	{
		583001,
		6,
		{
			171,
			185
		},
		"006战区"
	},
	{
		583001,
		7,
		{
			186,
			195
		},
		"007战区"
	},
	{
		583001,
		8,
		{
			196,
			999
		},
		"008战区"
	}
}
local t_martial_contest_zone = {
	[583001] = {
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

t_martial_contest_zone.dataList = dataList

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

return t_martial_contest_zone
