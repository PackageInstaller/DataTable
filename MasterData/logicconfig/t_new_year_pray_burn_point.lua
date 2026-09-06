-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_year_pray_burn_point.lua

module("logicconfig.config.t_new_year_pray_burn_point", package.seeall)

local title = {
	score = 3,
	name = 4,
	burnPointId = 2,
	burnPlanId = 1,
	showRatio = 5
}
local dataList = {
	{
		1,
		1,
		0,
		"0.15",
		0.25
	},
	{
		1,
		2,
		0,
		"0.45",
		0.5
	},
	{
		1,
		3,
		0.1,
		"0.75",
		0.75
	},
	{
		1,
		4,
		0.5,
		"1",
		1
	}
}
local t_new_year_pray_burn_point = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_new_year_pray_burn_point.dataList = dataList

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

return t_new_year_pray_burn_point
