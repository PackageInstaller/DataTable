-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_final_echo_creeps_master.lua

module("logicconfig.config.t_final_echo_creeps_master", package.seeall)

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
		"神曜梵天BOSS",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"神曜梵天：BOSS攻击时若目标拥有护盾，则本个大回合内己阵伤害提高30%"
	},
	{
		1002,
		"神曜女帝BOSS",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"神曜女帝：BOSS攻击时若被免疫，则本个大回合内己阵伤害提高30%"
	},
	{
		1003,
		"音织BOSS",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"音织：BOSS攻击时若被嘲讽，则本个大回合内己阵伤害提高30%"
	},
	{
		1004,
		"命渊圣龙BOSS",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"命渊圣龙：BOSS攻击时若击杀目标，则本个大回合内己阵伤害提高30%"
	}
}
local t_final_echo_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4]
}

t_final_echo_creeps_master.dataList = dataList

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

return t_final_echo_creeps_master
