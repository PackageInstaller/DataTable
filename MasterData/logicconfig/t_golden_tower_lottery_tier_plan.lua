-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_golden_tower_lottery_tier_plan.lua

module("logicconfig.config.t_golden_tower_lottery_tier_plan", package.seeall)

local title = {
	tierPlanId = 1,
	tier = 2,
	prizePlanId = 3
}
local dataList = {
	{
		1,
		1,
		1004
	},
	{
		1,
		2,
		1003
	},
	{
		1,
		3,
		1002
	},
	{
		1,
		4,
		1001
	},
	{
		2,
		1,
		2004
	},
	{
		2,
		2,
		2003
	},
	{
		2,
		3,
		2002
	},
	{
		2,
		4,
		2001
	},
	{
		3,
		1,
		3004
	},
	{
		3,
		2,
		3003
	},
	{
		3,
		3,
		3002
	},
	{
		3,
		4,
		3001
	}
}
local t_golden_tower_lottery_tier_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_golden_tower_lottery_tier_plan.dataList = dataList

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

return t_golden_tower_lottery_tier_plan
