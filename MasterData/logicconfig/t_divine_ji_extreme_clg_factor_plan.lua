-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ji_extreme_clg_factor_plan.lua

module("logicconfig.config.t_divine_ji_extreme_clg_factor_plan", package.seeall)

local title = {
	range = 3,
	factorPlanId = 1,
	distId = 2,
	factor = 4
}
local dataList = {
	{
		1,
		1,
		{
			0,
			1
		},
		1
	},
	{
		1,
		2,
		{
			2,
			3
		},
		2
	},
	{
		1,
		3,
		{
			4,
			4
		},
		3
	},
	{
		1,
		4,
		{
			5,
			5
		},
		4
	},
	{
		1,
		5,
		{
			6,
			6
		},
		5
	}
}
local t_divine_ji_extreme_clg_factor_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_ji_extreme_clg_factor_plan.dataList = dataList

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

return t_divine_ji_extreme_clg_factor_plan
