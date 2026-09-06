-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ciyuan_boss_challenge_plan.lua

module("logicconfig.config.t_king_ciyuan_boss_challenge_plan", package.seeall)

local title = {
	bossId = 2,
	name = 4,
	buffPlanId = 6,
	bossPlanId = 1,
	raceId = 5,
	monsterId = 3,
	rolePos = 8,
	dmgPlanId = 7
}
local dataList = {
	{
		1,
		1,
		1001,
		"赤焰龙皇试炼",
		10326,
		1,
		1,
		{
			60,
			-40,
			0.6
		}
	},
	{
		1,
		2,
		1002,
		"次元龙试炼",
		10313,
		1,
		1,
		{
			80,
			-60,
			0.6
		}
	},
	{
		1,
		3,
		1003,
		"黄金龙试炼",
		10324,
		1,
		1,
		{
			40,
			-50,
			0.7
		}
	},
	{
		1,
		4,
		1004,
		"圣光飞龙试炼",
		10027,
		1,
		1,
		{
			140,
			60,
			0.7
		}
	},
	{
		1,
		5,
		1005,
		"星蓝龙试炼",
		10127,
		1,
		1,
		{
			60,
			-120,
			0.6
		}
	}
}
local t_king_ciyuan_boss_challenge_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_king_ciyuan_boss_challenge_plan.dataList = dataList

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

return t_king_ciyuan_boss_challenge_plan
