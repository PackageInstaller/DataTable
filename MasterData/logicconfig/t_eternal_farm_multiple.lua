-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_farm_multiple.lua

module("logicconfig.config.t_eternal_farm_multiple", package.seeall)

local title = {
	multiple = 4,
	zoneId = 3,
	dayOfWeek = 2,
	activityId = 1
}
local dataList = {
	{
		296007,
		5,
		{
			1,
			6
		},
		2
	},
	{
		296007,
		6,
		{
			2,
			5
		},
		2
	},
	{
		296007,
		7,
		{
			3,
			4
		},
		2
	},
	{
		296008,
		5,
		{
			1,
			6
		},
		2
	},
	{
		296008,
		6,
		{
			2,
			5
		},
		2
	},
	{
		296008,
		7,
		{
			3,
			4
		},
		2
	}
}
local t_eternal_farm_multiple = {
	[296007] = {
		[5] = dataList[1],
		[6] = dataList[2],
		[7] = dataList[3]
	},
	[296008] = {
		[5] = dataList[4],
		[6] = dataList[5],
		[7] = dataList[6]
	}
}

t_eternal_farm_multiple.dataList = dataList

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

return t_eternal_farm_multiple
