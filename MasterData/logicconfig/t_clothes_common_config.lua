-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_clothes_common_config.lua

module("logicconfig.config.t_clothes_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DECOMPOSE_GAIN_SCORE_ID",
		"14"
	},
	{
		"FOREVER_EQUALS_HOURS",
		"240"
	},
	{
		"DECOMPOSE_PARAM_Y",
		"24"
	},
	{
		"SKELETON_0",
		"1"
	},
	{
		"SKELETON_1",
		"2"
	},
	{
		"DEFAULTSUIT_0",
		"1"
	},
	{
		"DEFAULTSUIT_1",
		"2"
	},
	{
		"TRANSFORM_GENDER_INTERVAL_DAYS",
		"7"
	},
	{
		"TRANSFORM_GENDER_CONSUME",
		"4:110:1"
	},
	{
		"CLOTHES_PRESET_COUNT",
		"10"
	}
}
local t_clothes_common_config = {
	DECOMPOSE_GAIN_SCORE_ID = dataList[1],
	FOREVER_EQUALS_HOURS = dataList[2],
	DECOMPOSE_PARAM_Y = dataList[3],
	SKELETON_0 = dataList[4],
	SKELETON_1 = dataList[5],
	DEFAULTSUIT_0 = dataList[6],
	DEFAULTSUIT_1 = dataList[7],
	TRANSFORM_GENDER_INTERVAL_DAYS = dataList[8],
	TRANSFORM_GENDER_CONSUME = dataList[9],
	CLOTHES_PRESET_COUNT = dataList[10]
}

t_clothes_common_config.dataList = dataList

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

return t_clothes_common_config
