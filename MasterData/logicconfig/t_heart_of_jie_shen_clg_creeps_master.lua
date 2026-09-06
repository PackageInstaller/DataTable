-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_heart_of_jie_shen_clg_creeps_master.lua

module("logicconfig.config.t_heart_of_jie_shen_clg_creeps_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	ruleDesc = 11,
	skipTime = 3,
	retreatMsgType = 7,
	fmtType = 12,
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
		"亦之阵",
		5,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"①8个大回合后结束战斗\r\n②光怪怪或暗怪怪全部死亡时，亦每次受击最多受到100万伤害\r\n③亦每次超杀后，满血复活光怪怪与暗怪怪",
		1
	},
	{
		1002,
		"赤之阵",
		5,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"①8个大回合后结束战斗 \r\n②水怪怪或火怪怪或草怪怪全部死亡时，赤每次受击最多受到100万伤害\r\n③赤每次超杀后，满血复活水怪怪与火怪怪与草怪怪",
		2
	},
	{
		2001,
		"离阳",
		5,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"①8个大回合后结束战斗\r\n②光怪怪或暗怪怪全部死亡时，敖九每次受击最多受到100万伤害\r\n③敖九每次超杀后，满血复活光怪怪与暗怪怪",
		1
	},
	{
		2002,
		"龙脉",
		5,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"①8个大回合后结束战斗\r\n②水怪怪或火怪怪或草怪怪全部死亡时，敖九每次受击最多受到100万伤害\r\n③敖九每次超杀后，满血复活水怪怪与火怪怪与草怪怪",
		2
	}
}
local t_heart_of_jie_shen_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[2001] = dataList[3],
	[2002] = dataList[4]
}

t_heart_of_jie_shen_clg_creeps_master.dataList = dataList

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

return t_heart_of_jie_shen_clg_creeps_master
