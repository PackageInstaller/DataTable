-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_golden_tower_lottery_pool.lua

module("logicconfig.config.t_golden_tower_lottery_pool", package.seeall)

local title = {
	lotteryCost = 4,
	openTime = 3,
	tierPlanId = 5,
	skinId = 7,
	name = 6,
	posNScale = 8,
	activityId = 1,
	poolId = 2
}
local dataList = {
	{
		606001,
		1,
		"2026-06-26T05:00:00",
		"10:606002:1",
		1,
		82056441,
		14046,
		{
			-270,
			-405,
			1
		}
	},
	{
		606001,
		2,
		"2026-07-03T05:00:00",
		"10:606001:1",
		2,
		82056440,
		14045,
		{
			-250,
			-575,
			1
		}
	},
	{
		606001,
		3,
		"2026-07-10T05:00:00",
		"10:606003:1",
		3,
		82056442,
		14049,
		{
			-250,
			-685,
			1
		}
	}
}
local t_golden_tower_lottery_pool = {
	[606001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_golden_tower_lottery_pool.dataList = dataList

local multiLanguageCells = {
	name = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_golden_tower_lottery_pool
