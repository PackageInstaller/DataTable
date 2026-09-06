-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_final_echo_boss.lua

module("logicconfig.config.t_final_echo_boss", package.seeall)

local title = {
	bossId = 2,
	ruleDesc = 4,
	activityId = 1,
	creepsMasterId = 3
}
local dataList = {
	{
		495001,
		1,
		1001,
		"神曜梵天：BOSS攻击时若目标拥有护盾，则本个大回合内己阵伤害提高30%"
	},
	{
		495001,
		2,
		1002,
		"神曜女帝：BOSS攻击时若被免疫，则本个大回合内己阵伤害提高30%"
	},
	{
		495001,
		3,
		1003,
		"音织：BOSS攻击时若被嘲讽，则本个大回合内己阵伤害提高30%"
	},
	{
		495001,
		4,
		1004,
		"命渊圣龙：BOSS攻击时若击杀目标，则本个大回合内己阵伤害提高30%"
	}
}
local t_final_echo_boss = {
	[495001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_final_echo_boss.dataList = dataList

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

return t_final_echo_boss
