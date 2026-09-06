-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_regression_pet_5.lua

module("logicconfig.config.t_regression_pet_5", package.seeall)

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
		10328,
		"辛西娅挑战",
		5,
		2,
		"func#5014",
		"",
		"2022-08-26T05:00:00",
		"2022-09-09T05:00:00",
		"146",
		"",
		""
	}
}
local t_regression_pet_5 = {
	dataList[1]
}

t_regression_pet_5.dataList = dataList

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

return t_regression_pet_5
