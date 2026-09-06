-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wish_list_day.lua

module("logicconfig.config.t_wish_list_day", package.seeall)

local title = {
	prize = 3,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		65001,
		1,
		"104:2:88"
	},
	{
		65001,
		2,
		"104:2:128"
	},
	{
		65001,
		3,
		"104:2:188"
	},
	{
		65001,
		4,
		"4:31:1"
	},
	{
		65001,
		5,
		"4:36:1"
	},
	{
		65002,
		1,
		"4:12102:10#4:11002:30000"
	},
	{
		65002,
		2,
		"4:60005:1"
	},
	{
		65002,
		3,
		"4:90090:1"
	},
	{
		65002,
		4,
		"4:111:10"
	},
	{
		65002,
		5,
		"4:7008:100"
	}
}
local t_wish_list_day = {
	[65001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[65002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_wish_list_day.dataList = dataList

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

return t_wish_list_day
