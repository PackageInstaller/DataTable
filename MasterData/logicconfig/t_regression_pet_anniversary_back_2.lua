-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_regression_pet_anniversary_back_2.lua

module("logicconfig.config.t_regression_pet_anniversary_back_2", package.seeall)

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
		13025,
		"源起盖希瑞",
		0,
		1,
		"",
		"",
		"2026-04-10T05:00:00",
		"2026-04-17T05:00:00",
		"",
		"",
		""
	},
	{
		2,
		1,
		13026,
		"源起阿瑞斯",
		0,
		1,
		"",
		"",
		"2026-04-10T05:00:00",
		"2026-04-17T05:00:00",
		"",
		"",
		""
	},
	{
		3,
		1,
		13027,
		"源起天蛮王",
		0,
		1,
		"",
		"",
		"2026-04-10T05:00:00",
		"2026-04-17T05:00:00",
		"",
		"",
		""
	},
	{
		4,
		1,
		13028,
		"源起永恒龙",
		0,
		1,
		"",
		"",
		"2026-04-10T05:00:00",
		"2026-04-17T05:00:00",
		"",
		"",
		""
	},
	{
		5,
		1,
		13029,
		"源起卡雅",
		0,
		1,
		"",
		"",
		"2026-04-10T05:00:00",
		"2026-04-17T05:00:00",
		"",
		"",
		""
	},
	{
		6,
		1,
		10313,
		"",
		0,
		1,
		"",
		"",
		"2026-04-10T05:00:00",
		"2026-04-17T05:00:00",
		"",
		"",
		""
	}
}
local t_regression_pet_anniversary_back_2 = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_regression_pet_anniversary_back_2.dataList = dataList

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

return t_regression_pet_anniversary_back_2
