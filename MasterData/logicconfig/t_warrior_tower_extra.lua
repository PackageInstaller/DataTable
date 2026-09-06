-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_warrior_tower_extra.lua

module("logicconfig.config.t_warrior_tower_extra", package.seeall)

local title = {
	paramValue = 2,
	paramKey = 1
}
local dataList = {
	{
		"videoUnlockLevel",
		"50"
	},
	{
		"profitTimeUnit",
		"300"
	},
	{
		"profitMaxTimes",
		"288"
	},
	{
		"timeBox_Title",
		"每5分钟产出"
	},
	{
		"timeBox_Fast_Content",
		"拨动时间的指针\r\n立即获得120分钟的快速收益"
	},
	{
		"profitSpeedTimes",
		"24"
	},
	{
		"MaxLayer",
		"1000"
	},
	{
		"nextCountDown",
		"5"
	},
	{
		"timeBox_showReward_0",
		"9:4101#9:4102#9:4103#9:4201#9:4202#9:4203"
	}
}
local t_warrior_tower_extra = {
	videoUnlockLevel = dataList[1],
	profitTimeUnit = dataList[2],
	profitMaxTimes = dataList[3],
	timeBox_Title = dataList[4],
	timeBox_Fast_Content = dataList[5],
	profitSpeedTimes = dataList[6],
	MaxLayer = dataList[7],
	nextCountDown = dataList[8],
	timeBox_showReward_0 = dataList[9]
}

t_warrior_tower_extra.dataList = dataList

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

return t_warrior_tower_extra
