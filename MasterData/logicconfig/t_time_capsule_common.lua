-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_capsule_common.lua

module("logicconfig.config.t_time_capsule_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"ACT_START_TIME",
		"2021-04-15 05:00:00"
	},
	{
		"ACT_END_TIME",
		"2021-04-29 05:00:00"
	},
	{
		"FUNC_OPEN_ID",
		"173"
	},
	{
		"DAILY_REWARD",
		"4:601:3"
	},
	{
		"MAX_COLLECT_COUNT",
		"90"
	},
	{
		"DIG_TIP",
		"确定要花费<color=#cd7800>1张藏宝图</color>，开始挖宝吗？"
	},
	{
		"DIG_TIP_MAX",
		"确定要花费<color=#cd7800>1张藏宝图</color>，开始挖宝吗？/n当前愿望<color=#cd7800>已集齐90个</color>，/n继续挖宝不会再获得时间胶囊"
	},
	{
		"NONE_DIG",
		"没有藏宝图了，先去获得藏宝图，再来挖宝吧"
	},
	{
		"HIGH_PERCENT_COUNT",
		"1000"
	},
	{
		"HIGH_PERCENT",
		"70"
	}
}
local t_time_capsule_common = {
	ACT_START_TIME = dataList[1],
	ACT_END_TIME = dataList[2],
	FUNC_OPEN_ID = dataList[3],
	DAILY_REWARD = dataList[4],
	MAX_COLLECT_COUNT = dataList[5],
	DIG_TIP = dataList[6],
	DIG_TIP_MAX = dataList[7],
	NONE_DIG = dataList[8],
	HIGH_PERCENT_COUNT = dataList[9],
	HIGH_PERCENT = dataList[10]
}

t_time_capsule_common.dataList = dataList

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

return t_time_capsule_common
