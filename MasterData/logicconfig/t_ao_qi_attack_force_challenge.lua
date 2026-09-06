-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ao_qi_attack_force_challenge.lua

module("logicconfig.config.t_ao_qi_attack_force_challenge", package.seeall)

local title = {
	startCoin = 4,
	challengeId = 2,
	showPrize = 5,
	enterName = 6,
	itemPath = 7,
	activityId = 1,
	strength = 3
}
local dataList = {
	{
		436001,
		1,
		5,
		15,
		"10:436001:2000",
		"物理提升",
		"icon_brzs_wlrk"
	},
	{
		436001,
		2,
		5,
		15,
		"10:436002:2000",
		"魔法提升",
		"icon_brzs_mfrk"
	},
	{
		436001,
		3,
		5,
		15,
		"10:436003:2000",
		"防具提升",
		"icon_brzs_fjrk"
	},
	{
		436002,
		1,
		5,
		15,
		"10:436005:8000",
		"物理提升",
		"icon_brzs_wlrk"
	},
	{
		436002,
		2,
		5,
		15,
		"10:436006:8000",
		"魔法提升",
		"icon_brzs_mfrk"
	},
	{
		436002,
		3,
		5,
		15,
		"10:436007:8000",
		"防具提升",
		"icon_brzs_fjrk"
	}
}
local t_ao_qi_attack_force_challenge = {
	[436001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[436002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_ao_qi_attack_force_challenge.dataList = dataList

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

return t_ao_qi_attack_force_challenge
