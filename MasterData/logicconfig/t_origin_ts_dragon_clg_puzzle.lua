-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ts_dragon_clg_puzzle.lua

module("logicconfig.config.t_origin_ts_dragon_clg_puzzle", package.seeall)

local title = {
	activityId = 1,
	puzImageName = 5,
	phaseId = 2,
	roundChange = 7,
	puzEffectDesc = 6,
	puzzleType = 4,
	puzzleId = 3
}
local dataList = {
	{
		591001,
		1,
		1,
		1,
		"board_tzyqsk_05",
		"己阵战力前二的精灵进入战斗时获得无法行动，己阵造成8次克制伤害后解除",
		0
	},
	{
		591001,
		1,
		2,
		1,
		"board_tzyqsk_05",
		"己阵群攻伤害降低50%",
		0
	},
	{
		591001,
		1,
		3,
		2,
		"board_tzyqsk_06",
		"回合数+1",
		1
	},
	{
		591001,
		2,
		1,
		1,
		"board_tzyqsk_05",
		"己阵战力前二的精灵进入战斗时获得无法行动，己阵造成8次克制伤害后解除",
		0
	},
	{
		591001,
		2,
		2,
		1,
		"board_tzyqsk_05",
		"己阵群攻伤害降低50%",
		0
	},
	{
		591001,
		2,
		3,
		1,
		"board_tzyqsk_05",
		"己阵精灵获得永久禁疗",
		0
	},
	{
		591001,
		2,
		4,
		2,
		"board_tzyqsk_06",
		"回合数+1",
		1
	},
	{
		591001,
		2,
		5,
		2,
		"board_tzyqsk_06",
		"己阵战力前三的精灵单体伤害增加20%",
		0
	},
	{
		591001,
		3,
		1,
		1,
		"board_tzyqsk_05",
		"前两位死亡的敌方精灵解除禁疗并满血复活，第3-5位死亡满血复活",
		0
	},
	{
		591001,
		3,
		2,
		1,
		"board_tzyqsk_05",
		"敌阵精灵受到非克制伤害降低50%，受到克制伤害降低30%",
		0
	},
	{
		591001,
		3,
		3,
		2,
		"board_tzyqsk_06",
		"己阵精灵进入战斗时获得30气势",
		0
	}
}
local t_origin_ts_dragon_clg_puzzle = {
	[591001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11]
		}
	}
}

t_origin_ts_dragon_clg_puzzle.dataList = dataList

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

return t_origin_ts_dragon_clg_puzzle
