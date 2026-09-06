-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ao_qi_attack_force_final_challenge.lua

module("logicconfig.config.t_ao_qi_attack_force_final_challenge", package.seeall)

local title = {
	monsterPlan = 4,
	startCoin = 3,
	storePlan = 5,
	openDateTime = 2,
	buffPlan = 6,
	addMonsterBuff = 8,
	activityId = 1,
	buffTime = 7
}
local dataList = {
	{
		436001,
		"2025-01-27T05:00:00",
		800,
		21,
		2,
		1,
		20,
		10043
	}
}
local t_ao_qi_attack_force_final_challenge = {
	[436001] = dataList[1]
}

t_ao_qi_attack_force_final_challenge.dataList = dataList

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

return t_ao_qi_attack_force_final_challenge
