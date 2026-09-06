-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_heart_of_ao_jiu_clg_monster.lua

module("logicconfig.config.t_heart_of_ao_jiu_clg_monster", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	ruleDesc = 11,
	skipTime = 3,
	retreatMsgType = 7,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		1001,
		"敖九之心-1",
		5,
		"",
		"",
		117,
		0,
		411,
		0,
		"416033",
		"敌阵死亡时会满血复活，玩家需在5个大回合内尽力击杀敌阵精灵，最终根据击杀精灵数量进行排名"
	},
	{
		1002,
		"敖九之心-2",
		5,
		"",
		"",
		117,
		0,
		411,
		0,
		"414033",
		"敌阵死亡时会满血复活，玩家需在5个大回合内尽力击杀敌阵精灵，最终根据击杀精灵数量进行排名"
	},
	{
		1003,
		"敖九之心-3",
		5,
		"",
		"",
		117,
		0,
		411,
		0,
		"416036",
		"敌阵死亡时会满血复活，玩家需在5个大回合内尽力击杀敌阵精灵，最终根据击杀精灵数量进行排名"
	},
	{
		1004,
		"敖九之心-4",
		5,
		"",
		"",
		117,
		0,
		411,
		0,
		"412036",
		"敌阵死亡时会满血复活，玩家需在5个大回合内尽力击杀敌阵精灵，最终根据击杀精灵数量进行排名"
	}
}
local t_heart_of_ao_jiu_clg_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4]
}

t_heart_of_ao_jiu_clg_monster.dataList = dataList

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

return t_heart_of_ao_jiu_clg_monster
