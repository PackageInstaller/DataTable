-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_chen_clg_activity.lua

module("logicconfig.config.t_divine_chen_clg_activity", package.seeall)

local title = {
	junpStr3 = 8,
	junpStr1 = 6,
	normalSupportPetNum = 4,
	skinId = 9,
	ruleTip = 5,
	showPrize = 10,
	showPrizeDesc = 11,
	openTime = 12,
	junpStr2 = 7,
	extremeOpenTime = 14,
	redPointId = 2,
	endTime = 13,
	extremeEndTime = 15,
	activityId = 1,
	extremePrize = 3
}
local dataList = {
	{
		457001,
		678,
		"4:510447:100",
		15,
		"divinechenclgmainview_rule",
		"func#618#16031",
		"ui#lottery",
		"func#43#132",
		16031,
		"4:510447:100",
		"通关获得\r\n神曜材料×100",
		"2025-03-07T05:00:00",
		"2025-04-03T05:00:00",
		"2025-04-25T05:00:00",
		"2038-12-31T05:00:00"
	},
	{
		457002,
		0,
		"8:1:100",
		15,
		"divinechenclgmainview_rule",
		"func#618#16031",
		"ui#lottery",
		"func#43#132",
		16031,
		"4:510447:100",
		"通关获得\r\n神曜材料×100",
		"2026-04-25T05:00:00",
		"2026-09-09T05:00:00",
		"2026-04-25T05:00:00",
		"2038-12-31T05:00:00"
	}
}
local t_divine_chen_clg_activity = {
	[457001] = dataList[1],
	[457002] = dataList[2]
}

t_divine_chen_clg_activity.dataList = dataList

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

return t_divine_chen_clg_activity
