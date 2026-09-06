-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_regression_pet_11.lua

module("logicconfig.config.t_regression_pet_11", package.seeall)

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
		12040,
		"源起维蕾塔",
		0,
		1,
		"",
		"",
		"2026-04-17T05:00:00",
		"2026-04-24T05:00:00",
		"",
		"",
		""
	},
	{
		2,
		1,
		12042,
		"源起龙炎",
		0,
		1,
		"",
		"",
		"2026-04-17T05:00:00",
		"2026-04-24T05:00:00",
		"",
		"",
		""
	},
	{
		3,
		1,
		12041,
		"源起无烬龙",
		0,
		1,
		"",
		"",
		"2026-04-17T05:00:00",
		"2026-04-24T05:00:00",
		"",
		"",
		""
	},
	{
		4,
		1,
		12043,
		"召唤师末炎",
		0,
		1,
		"",
		"",
		"2026-04-17T05:00:00",
		"2026-04-24T05:00:00",
		"",
		"",
		""
	},
	{
		5,
		1,
		12044,
		"王者末炎",
		0,
		1,
		"",
		"",
		"2026-04-17T05:00:00",
		"2026-04-24T05:00:00",
		"",
		"",
		""
	},
	{
		6,
		1,
		12045,
		"源起火次元",
		0,
		1,
		"",
		"",
		"2026-04-17T05:00:00",
		"2026-04-24T05:00:00",
		"",
		"",
		""
	},
	{
		7,
		1,
		16001,
		"挑战获得解神之心",
		0,
		1,
		"",
		"",
		"2026-04-17T05:00:00",
		"2026-04-24T05:00:00",
		"",
		"",
		""
	}
}
local t_regression_pet_11 = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_regression_pet_11.dataList = dataList

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

return t_regression_pet_11
