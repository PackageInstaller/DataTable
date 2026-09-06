-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_regression_pet_3.lua

module("logicconfig.config.t_regression_pet_3", package.seeall)

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
		11007,
		"圣骑卡池",
		0,
		1,
		"",
		"",
		nil,
		nil,
		"",
		"",
		""
	},
	{
		2,
		1,
		15011,
		"圣骑卡池",
		0,
		1,
		"",
		"",
		nil,
		nil,
		"",
		"",
		""
	},
	{
		3,
		1,
		13001,
		"圣骑卡池",
		0,
		1,
		"",
		"",
		nil,
		nil,
		"",
		"",
		""
	},
	{
		4,
		1,
		14008,
		"圣骑卡池",
		0,
		1,
		"",
		"",
		nil,
		nil,
		"",
		"",
		""
	},
	{
		5,
		1,
		12008,
		"圣骑卡池",
		0,
		1,
		"",
		"",
		nil,
		nil,
		"",
		"",
		""
	},
	{
		6,
		1,
		12007,
		"圣骑卡池",
		0,
		2,
		"func#43#94",
		"",
		"2023-04-14T05:00:00",
		"2023-04-28T05:00:00",
		"",
		"",
		""
	}
}
local t_regression_pet_3 = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_regression_pet_3.dataList = dataList

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

return t_regression_pet_3
