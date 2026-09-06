-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mo_yan_challenge_boss_damage_score.lua

module("logicconfig.config.t_mo_yan_challenge_boss_damage_score", package.seeall)

local title = {
	id = 2,
	needDamageWanPercent = 3,
	planId = 1,
	score = 4
}
local dataList = {
	{
		1,
		1,
		400,
		40
	},
	{
		1,
		2,
		800,
		40
	},
	{
		1,
		3,
		1200,
		40
	},
	{
		1,
		4,
		2000,
		40
	},
	{
		1,
		5,
		3500,
		40
	},
	{
		1,
		6,
		6000,
		40
	},
	{
		1,
		7,
		10000,
		80
	}
}
local t_mo_yan_challenge_boss_damage_score = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_mo_yan_challenge_boss_damage_score.dataList = dataList

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

return t_mo_yan_challenge_boss_damage_score
