-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_totem.lua

module("logicconfig.config.t_family_totem", package.seeall)

local title = {
	totemType = 2,
	totemId = 1,
	costFamilyMoney = 4,
	effectTimes = 5,
	icon = 6,
	desc = 3
}
local dataList = {
	{
		1,
		"NEW_FAMILY_BATTLE_DEFENCE",
		"神柱之战，敌对阵营攻击我方阵营时，我方守阵的伤害减免<color=#0C9729>40%</color>",
		50000,
		3600,
		"jiazu_tuteng01"
	},
	{
		2,
		"NEW_FAMILY_BATTLE_ATTACK",
		"神柱之战，攻击敌对阵营守阵时，伤害提升 <color=#0C9729>40%</color>",
		50000,
		3600,
		"jiazu_tuteng02"
	},
	{
		3,
		"NEW_FAMILY_BATTLE_NEST",
		"神柱之战，攻击巢穴 BOSS时，伤害提升 <color=#0C9729>40%</color>",
		50000,
		3600,
		"jiazu_tuteng03"
	}
}
local t_family_totem = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_family_totem.dataList = dataList

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

return t_family_totem
