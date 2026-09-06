-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fuben_world.lua

module("logicconfig.config.t_annual_fuben_world", package.seeall)

local title = {
	progressId = 2,
	openTime = 3,
	progress = 4,
	progressPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"2025-12-19T05:00:00",
		0
	},
	{
		1,
		2,
		"2025-12-19T09:54:35",
		80000
	},
	{
		1,
		3,
		"2025-12-19T21:21:00",
		150000
	},
	{
		1,
		4,
		"2025-12-20T06:18:09",
		200000
	},
	{
		1,
		5,
		"2025-12-20T13:47:32",
		250000
	},
	{
		1,
		6,
		"2026-01-04T16:29:50",
		1024687
	},
	{
		2,
		1,
		"2026-01-01T05:00:00",
		0
	},
	{
		2,
		2,
		"2026-01-04T16:29:50",
		100
	}
}
local t_annual_fuben_world = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8]
	}
}

t_annual_fuben_world.dataList = dataList

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

return t_annual_fuben_world
