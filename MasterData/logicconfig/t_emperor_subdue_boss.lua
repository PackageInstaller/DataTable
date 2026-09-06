-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_emperor_subdue_boss.lua

module("logicconfig.config.t_emperor_subdue_boss", package.seeall)

local title = {
	ruleDesc = 5,
	supportPetPlan = 4,
	creepsMasterId = 3,
	activityId = 1,
	times = 2
}
local dataList = {
	{
		547001,
		1,
		1006,
		6,
		"挑战规则<color=#FF2929FF>第一轮</color>念\r\n能力：闪避率提升30%\r\n按照累计伤害领取奖励"
	},
	{
		547001,
		2,
		1007,
		6,
		"挑战规则<color=#FF2929FF>第二轮</color>念\r\n能力：格挡率提升50%\r\n按照累计伤害领取奖励"
	},
	{
		547001,
		3,
		1008,
		6,
		"挑战规则<color=#FF2929FF>第三轮</color>念\r\n能力：防御提升20%\r\n按照累计伤害领取奖励"
	},
	{
		547001,
		4,
		1009,
		6,
		"挑战规则<color=#FF2929FF>第四轮</color>念\r\n能力：防暴率提升30%\r\n按照累计伤害领取奖励"
	},
	{
		547001,
		5,
		1010,
		6,
		"挑战规则<color=#FF2929FF>第五轮</color>念\r\n能力：命中率提升20%\r\n按照累计伤害领取奖励"
	}
}
local t_emperor_subdue_boss = {
	[547001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_emperor_subdue_boss.dataList = dataList

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

return t_emperor_subdue_boss
