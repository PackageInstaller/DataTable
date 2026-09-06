-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ao_qi_attack_force_hero_challenge_info.lua

module("logicconfig.config.t_ao_qi_attack_force_hero_challenge_info", package.seeall)

local title = {
	startCoin = 2,
	openDateTime = 4,
	activityId = 1,
	restartTime = 3
}
local dataList = {
	{
		436001,
		20,
		1,
		"2038-12-31T05:00:00"
	},
	{
		436002,
		20,
		1,
		"2026-05-15T05:00:00"
	}
}
local t_ao_qi_attack_force_hero_challenge_info = {
	[436001] = dataList[1],
	[436002] = dataList[2]
}

t_ao_qi_attack_force_hero_challenge_info.dataList = dataList

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

return t_ao_qi_attack_force_hero_challenge_info
