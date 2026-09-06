-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ao_qi_attack_force_hero_challenge_lottery.lua

module("logicconfig.config.t_ao_qi_attack_force_hero_challenge_lottery", package.seeall)

local title = {
	lotteryCost = 3,
	lotteryPlanId = 1,
	count = 2
}
local dataList = {
	{
		1,
		1,
		20
	},
	{
		1,
		2,
		20
	},
	{
		1,
		3,
		40
	},
	{
		1,
		4,
		40
	},
	{
		1,
		5,
		80
	},
	{
		1,
		6,
		80
	}
}
local t_ao_qi_attack_force_hero_challenge_lottery = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_ao_qi_attack_force_hero_challenge_lottery.dataList = dataList

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

return t_ao_qi_attack_force_hero_challenge_lottery
