-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miya_challenge_num.lua

module("logicconfig.config.t_miya_challenge_num", package.seeall)

local title = {
	id = 2,
	num = 3,
	desc = 4,
	type = 1
}
local dataList = {
	{
		1,
		1,
		1,
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>20%</color>（1回合）"
	},
	{
		1,
		2,
		2,
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>40%</color>（1回合）"
	},
	{
		1,
		3,
		3,
		"出手后，使目标精灵生命恢复效果降低<color=#c54949>60%</color>（1回合）"
	},
	{
		1,
		4,
		4,
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>20%</color>"
	},
	{
		1,
		5,
		5,
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>40%</color>"
	},
	{
		1,
		6,
		6,
		"进入战斗时，永久提升己阵精灵生命恢复效果<color=#c54949>60%</color>"
	},
	{
		1,
		7,
		1,
		"超杀伤害增加<color=#c54949>10%</color>"
	},
	{
		1,
		8,
		2,
		"超杀伤害增加<color=#c54949>20%</color>"
	},
	{
		1,
		9,
		3,
		"超杀伤害增加<color=#c54949>30%</color>"
	},
	{
		1,
		10,
		4,
		"普攻伤害增加<color=#c54949>15%</color>"
	},
	{
		1,
		11,
		5,
		"普攻伤害增加<color=#c54949>30%</color>"
	},
	{
		1,
		12,
		6,
		"普攻伤害增加<color=#c54949>45%</color>"
	},
	{
		1,
		13,
		1,
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>6%</color>的伤害"
	},
	{
		1,
		14,
		2,
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>12%</color>的伤害"
	},
	{
		1,
		15,
		3,
		"攻击后，对目标精灵额外造成攻击伤害*<color=#c54949>18%</color>的伤害"
	},
	{
		1,
		16,
		4,
		"攻击时吸血<color=#c54949>6%</color>"
	},
	{
		1,
		17,
		5,
		"攻击时吸血<color=#c54949>12%</color>"
	},
	{
		1,
		18,
		6,
		"攻击时吸血<color=#c54949>18%</color>"
	},
	{
		1,
		19,
		1,
		"群攻伤害增加<color=#c54949>10%</color>"
	},
	{
		1,
		20,
		2,
		"群攻伤害增加<color=#c54949>20%</color>"
	},
	{
		1,
		21,
		3,
		"群攻伤害增加<color=#c54949>30%</color>"
	},
	{
		1,
		22,
		4,
		"暴击伤害增加<color=#c54949>10%</color>"
	},
	{
		1,
		23,
		5,
		"暴击伤害增加<color=#c54949>20%</color>"
	},
	{
		1,
		24,
		6,
		"暴击伤害增加<color=#c54949>30%</color>"
	},
	{
		1,
		25,
		1,
		"攻击后，降低目标精灵<color=#c54949>10</color>点气势"
	},
	{
		1,
		26,
		2,
		"攻击后，降低目标精灵<color=#c54949>20</color>点气势"
	},
	{
		1,
		27,
		3,
		"攻击后，降低目标精灵<color=#c54949>30</color>点气势"
	},
	{
		1,
		28,
		4,
		"受击时，降低目标精灵<color=#c54949>4</color>点气势"
	},
	{
		1,
		29,
		5,
		"受击时，降低目标精灵<color=#c54949>8</color>点气势"
	},
	{
		1,
		30,
		6,
		"受击时，降低目标精灵<color=#c54949>12</color>点气势"
	},
	{
		2,
		9,
		7,
		"玩家只可使用草系精灵破阵"
	},
	{
		2,
		10,
		8,
		"玩家只可使用水系精灵破阵"
	},
	{
		2,
		11,
		9,
		"玩家只可使用火系精灵破阵"
	},
	{
		2,
		12,
		10,
		"玩家只可使用光系精灵破阵"
	},
	{
		2,
		13,
		11,
		"玩家只可使用暗系精灵破阵"
	},
	{
		2,
		135,
		12,
		"玩家必须上阵一个通灵师精灵"
	},
	{
		3,
		57,
		13,
		"我方精灵存活>=3"
	},
	{
		3,
		55,
		14,
		"我方精灵存活>=5"
	},
	{
		3,
		56,
		15,
		"我方精灵存活>=4"
	},
	{
		3,
		73,
		16,
		"在5回合内破阵"
	},
	{
		3,
		112,
		17,
		"在7回合内破阵"
	},
	{
		3,
		131,
		18,
		"击败敌方全阵即为胜利"
	}
}
local t_miya_challenge_num = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	},
	{
		[9] = dataList[31],
		[10] = dataList[32],
		[11] = dataList[33],
		[12] = dataList[34],
		[13] = dataList[35],
		[135] = dataList[36]
	},
	{
		[57] = dataList[37],
		[55] = dataList[38],
		[56] = dataList[39],
		[73] = dataList[40],
		[112] = dataList[41],
		[131] = dataList[42]
	}
}

t_miya_challenge_num.dataList = dataList

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

return t_miya_challenge_num
