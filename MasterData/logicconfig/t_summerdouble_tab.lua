-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summerdouble_tab.lua

module("logicconfig.config.t_summerdouble_tab", package.seeall)

local title = {
	endTime = 4,
	tabName = 2,
	timeDesc = 5,
	tabId = 1,
	startTime = 3
}
local dataList = {
	{
		1,
		"翻倍福利",
		"2023-10-27T05:00:00",
		"2023-11-17T05:00:00",
		"活动时间：2023/10/27 05:00:00 - 2023/11/17 05:00:00"
	},
	{
		2,
		"宠物特权",
		"2023-10-27T05:00:00",
		"2023-11-17T05:00:00",
		"活动时间：2023/10/27 05:00:00 - 2023/11/17 05:00:00"
	}
}
local t_summerdouble_tab = {
	dataList[1],
	dataList[2]
}

t_summerdouble_tab.dataList = dataList

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

return t_summerdouble_tab
