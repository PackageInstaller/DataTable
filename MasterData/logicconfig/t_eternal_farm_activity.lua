-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_farm_activity.lua

module("logicconfig.config.t_eternal_farm_activity", package.seeall)

local title = {
	redPointId = 5,
	costIcon = 3,
	jumpTo = 4,
	activityId = 1,
	dailyPrize = 2
}
local dataList = {
	{
		296001,
		"10:296009:2400",
		"10:296009#104:2",
		"",
		515
	},
	{
		296002,
		"10:296019:2400",
		"10:296019#104:2",
		"func#992",
		515
	},
	{
		296003,
		"10:296028:2400",
		"10:296028#104:2",
		"",
		515
	},
	{
		296004,
		"10:296037:2400",
		"10:296037#104:2",
		"",
		515
	},
	{
		296005,
		"10:296046:2400",
		"10:296046#104:2",
		"",
		515
	},
	{
		296006,
		"10:296055:2400",
		"10:296055#104:2",
		"",
		515
	},
	{
		296007,
		"10:296070:4800",
		"10:296070#104:2",
		"func#191#296#296007",
		515
	},
	{
		296008,
		"10:296088:4800",
		"10:296088#104:2",
		"func#191#296#296008",
		515
	}
}
local t_eternal_farm_activity = {
	[296001] = dataList[1],
	[296002] = dataList[2],
	[296003] = dataList[3],
	[296004] = dataList[4],
	[296005] = dataList[5],
	[296006] = dataList[6],
	[296007] = dataList[7],
	[296008] = dataList[8]
}

t_eternal_farm_activity.dataList = dataList

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

return t_eternal_farm_activity
