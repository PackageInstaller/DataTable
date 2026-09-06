-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiumum_challenge_buff.lua

module("logicconfig.config.t_xiumum_challenge_buff", package.seeall)

local title = {
	name = 2,
	buffId = 1,
	des = 3
}
local dataList = {
	{
		1,
		"巫毒",
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>60%</color>（1回合）"
	},
	{
		2,
		"医疗专家",
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>60%</color>"
	},
	{
		3,
		"凝神一击",
		"超杀伤害增加<color=#c54949>30%</color>"
	},
	{
		4,
		"普通一击",
		"普攻伤害增加<color=#c54949>45%</color>"
	},
	{
		5,
		"附伤",
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>18%</color>的伤害"
	},
	{
		6,
		"吸血",
		"攻击时吸血<color=#c54949>18%</color>"
	},
	{
		7,
		"齐射",
		"群攻伤害增加<color=#c54949>30%</color>"
	},
	{
		8,
		"暴伤",
		"暴击伤害增加<color=#c54949>30%</color>"
	},
	{
		9,
		"攻击降气",
		"攻击后，降低目标精灵<color=#c54949>30</color>点气势"
	},
	{
		10,
		"受击降气",
		"受击时，降低目标精灵<color=#c54949>12</color>点气势"
	}
}
local t_xiumum_challenge_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_xiumum_challenge_buff.dataList = dataList

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

return t_xiumum_challenge_buff
