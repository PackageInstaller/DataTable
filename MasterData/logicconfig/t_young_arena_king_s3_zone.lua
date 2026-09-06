-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_arena_king_s3_zone.lua

module("logicconfig.config.t_young_arena_king_s3_zone", package.seeall)

local title = {
	activityId = 1,
	areaIds = 3,
	zoneId = 2,
	name = 4
}
local dataList = {
	{
		624001,
		0,
		{
			0,
			0
		},
		"000战区"
	},
	{
		624001,
		1,
		{
			1,
			15
		},
		"001战区"
	},
	{
		624001,
		2,
		{
			16,
			60
		},
		"002战区"
	},
	{
		624001,
		3,
		{
			61,
			114
		},
		"003战区"
	},
	{
		624001,
		4,
		{
			115,
			146
		},
		"004战区"
	},
	{
		624001,
		5,
		{
			147,
			170
		},
		"005战区"
	},
	{
		624001,
		6,
		{
			171,
			185
		},
		"006战区"
	},
	{
		624001,
		7,
		{
			186,
			197
		},
		"007战区"
	},
	{
		624001,
		8,
		{
			198,
			999
		},
		"008战区"
	}
}
local t_young_arena_king_s3_zone = {
	[624001] = {
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

t_young_arena_king_s3_zone.dataList = dataList

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

return t_young_arena_king_s3_zone
