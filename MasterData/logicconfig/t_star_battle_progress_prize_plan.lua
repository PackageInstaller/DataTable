-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_battle_progress_prize_plan.lua

module("logicconfig.config.t_star_battle_progress_prize_plan", package.seeall)

local title = {
	progressId = 2,
	prize = 4,
	totalDamage = 3,
	progressPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"100000",
		"10:510001:100"
	},
	{
		1,
		2,
		"300000",
		"10:510001:100"
	},
	{
		1,
		3,
		"500000",
		"10:510001:100"
	},
	{
		1,
		4,
		"800000",
		"10:510001:100"
	},
	{
		1,
		5,
		"1000000",
		"10:510001:100"
	},
	{
		1,
		6,
		"3000000",
		"10:510001:100"
	},
	{
		1,
		7,
		"5000000",
		"10:510001:100"
	},
	{
		1,
		8,
		"8000000",
		"10:510001:100"
	},
	{
		1,
		9,
		"10000000",
		"10:510001:100"
	},
	{
		1,
		10,
		"15000000",
		"10:510001:100"
	}
}
local t_star_battle_progress_prize_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_star_battle_progress_prize_plan.dataList = dataList

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

return t_star_battle_progress_prize_plan
