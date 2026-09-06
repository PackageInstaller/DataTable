-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_city_common.lua

module("logicconfig.config.t_eternal_city_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MAP_LENGTH",
		"12"
	},
	{
		"MAP_WIDTH",
		"10"
	},
	{
		"MAX_HOLD_BUILDING",
		"150"
	},
	{
		"GOD_TREE_X_POSITION",
		"6"
	},
	{
		"GOD_TREE_Y_POSITION",
		"6"
	},
	{
		"MIN_GAIN_PROFIT_TIME",
		"20"
	},
	{
		"GOD_TREE_LENGTH",
		"1"
	},
	{
		"GOD_TREE_WIDTH",
		"1"
	}
}
local t_eternal_city_common = {
	MAP_LENGTH = dataList[1],
	MAP_WIDTH = dataList[2],
	MAX_HOLD_BUILDING = dataList[3],
	GOD_TREE_X_POSITION = dataList[4],
	GOD_TREE_Y_POSITION = dataList[5],
	MIN_GAIN_PROFIT_TIME = dataList[6],
	GOD_TREE_LENGTH = dataList[7],
	GOD_TREE_WIDTH = dataList[8]
}

t_eternal_city_common.dataList = dataList

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

return t_eternal_city_common
