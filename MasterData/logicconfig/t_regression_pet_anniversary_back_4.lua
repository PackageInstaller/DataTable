-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_regression_pet_anniversary_back_4.lua

module("logicconfig.config.t_regression_pet_anniversary_back_4", package.seeall)

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
		11036,
		"源起星绛",
		0,
		1,
		"",
		"",
		"2026-04-24T05:00:00",
		"2026-05-01T05:00:00",
		"",
		"",
		""
	},
	{
		2,
		1,
		11038,
		"源起冰灵王",
		0,
		1,
		"",
		"",
		"2026-04-24T05:00:00",
		"2026-05-01T05:00:00",
		"",
		"",
		""
	},
	{
		3,
		1,
		11039,
		"源起帝释天",
		0,
		1,
		"",
		"",
		"2026-04-24T05:00:00",
		"2026-05-01T05:00:00",
		"",
		"",
		""
	},
	{
		4,
		1,
		11040,
		"源起王者秩序",
		0,
		1,
		"",
		"",
		"2026-04-24T05:00:00",
		"2026-05-01T05:00:00",
		"",
		"",
		""
	},
	{
		5,
		1,
		15032,
		"路因加德",
		0,
		1,
		"",
		"",
		"2026-04-24T05:00:00",
		"2026-05-01T05:00:00",
		"",
		"",
		""
	}
}
local t_regression_pet_anniversary_back_4 = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_regression_pet_anniversary_back_4.dataList = dataList

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

return t_regression_pet_anniversary_back_4
