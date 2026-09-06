-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ao_qi_attack_force_activity.lua

module("logicconfig.config.t_ao_qi_attack_force_activity", package.seeall)

local title = {
	heroPrizeDailyLimit = 16,
	dailyStrength = 2,
	refreshStoreCost = 5,
	taskGotoStr = 9,
	coinIconPath = 12,
	playerHp = 4,
	refreshBuffCost = 6,
	exchangeGotoStr = 10,
	playerModel = 13,
	heroPrizeKey = 15,
	useEquipmentLimit = 3,
	ruleKey = 8,
	unlockLimit = 14,
	tiliIconPath = 11,
	activityId = 1,
	getAllBuffCost = 7
}
local dataList = {
	{
		436001,
		50,
		8,
		100,
		15,
		15,
		60,
		"ao_qi_attack_force_rule",
		"ui#commongrouptaskmainview#436001",
		"func#191#436#436001",
		"icon_yangnailao",
		"icon_youqianbi",
		1,
		4,
		"8:1",
		300
	},
	{
		436002,
		50,
		8,
		100,
		15,
		15,
		60,
		"ao_qi_attack_force_rule",
		"ui#commongrouptaskmainview#436002",
		"func#191#436#436002",
		"icon_yangnailao",
		"icon_youqianbi",
		1,
		4,
		"10:436008",
		2000
	}
}
local t_ao_qi_attack_force_activity = {
	[436001] = dataList[1],
	[436002] = dataList[2]
}

t_ao_qi_attack_force_activity.dataList = dataList

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

return t_ao_qi_attack_force_activity
