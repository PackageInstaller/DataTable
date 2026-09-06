-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_potluck_dinner_food.lua

module("logicconfig.config.t_potluck_dinner_food", package.seeall)

local title = {
	allAreaLimit = 5,
	name = 3,
	icon = 7,
	desc = 8,
	dailyTimes = 4,
	broadcastLimit = 6,
	activityId = 1,
	foodType = 2
}
local dataList = {
	{
		196001,
		1,
		"顶级美食-火锅",
		3,
		10000,
		{
			10000,
			9000,
			8000,
			7000,
			6000,
			5000,
			4000,
			3000,
			2000,
			1000,
			500,
			100
		},
		"icon_meishi_01",
		"描述1"
	},
	{
		196001,
		2,
		"美食-牛排",
		5,
		0,
		nil,
		"icon_meishi_02",
		"描述2"
	},
	{
		196001,
		3,
		"美食-沙拉",
		5,
		0,
		nil,
		"icon_meishi_03",
		"描述3"
	}
}
local t_potluck_dinner_food = {
	[196001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_potluck_dinner_food.dataList = dataList

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

return t_potluck_dinner_food
