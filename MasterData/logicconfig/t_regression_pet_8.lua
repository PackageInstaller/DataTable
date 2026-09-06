-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_regression_pet_8.lua

module("logicconfig.config.t_regression_pet_8", package.seeall)

local title = {
	mark = 5,
	getDescription = 4,
	skinId = 3,
	type = 2,
	startTime = 9,
	endTime = 10,
	redPoint = 11,
	reportBehavior = 12,
	sqContent = 13,
	resources = 8,
	jumpType = 6,
	funcId = 7,
	sort = 1
}
local dataList = {
	{
		1,
		1,
		17029,
		"源起龙尊圣主",
		0,
		1,
		"",
		"",
		"2026-04-17T09:00:00",
		nil,
		"",
		"",
		""
	},
	{
		2,
		1,
		17027,
		"薄伽丘",
		0,
		1,
		"",
		"",
		"2026-04-10T09:00:00",
		nil,
		"",
		"",
		""
	},
	{
		3,
		1,
		11037,
		"源起·秩序龙尊",
		0,
		1,
		"",
		"",
		"2026-03-13T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		4,
		1,
		11011,
		"神曜法则·秩序圣龙挑战",
		0,
		1,
		"func#5067",
		"",
		"2026-03-13T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		5,
		1,
		17015,
		"神曜龙尊圣主",
		0,
		1,
		"",
		"",
		"2024-03-08T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		6,
		1,
		15032,
		"路因加德",
		0,
		1,
		"",
		"",
		"2025-04-11T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		7,
		1,
		18011,
		"平行态夏因",
		0,
		1,
		"",
		"",
		"2024-10-01T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		8,
		1,
		17002,
		"龙尊圣主挑战",
		0,
		1,
		"",
		"",
		"2025-04-03T05:00:00",
		nil,
		"",
		"",
		""
	},
	{
		9,
		1,
		11002,
		"神罚·秩序圣龙",
		0,
		1,
		"",
		"",
		"2025-04-03T05:00:00",
		nil,
		"",
		"",
		""
	}
}
local t_regression_pet_8 = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_regression_pet_8.dataList = dataList

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

return t_regression_pet_8
