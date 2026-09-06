-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_nine_place_stage.lua

module("logicconfig.config.t_nine_place_stage", package.seeall)

local title = {
	stageId = 1,
	name = 2,
	description = 4,
	openCondition = 3,
	challengeViewResName = 12,
	mainIconResName = 11,
	battleTip = 6,
	lights = 9,
	formationIcon = 13,
	lockTip = 5,
	NpcId = 14,
	upLvViewResName = 10,
	raceId = 8,
	buffLockTip = 7
}
local dataList = {
	{
		1,
		"格挡阵",
		"1,5,3",
		"格挡率提升",
		"<color=#ffa429>【剧情 序章-精灵天赋】</color>完成后可解锁\n通过弹弹挑战第1关后解锁",
		"九宫八阵挑战中，仅固定位置可以上阵精灵",
		"暂未解锁，请前往九宫八阵挑战开启",
		10030,
		{
			2,
			4,
			5,
			6,
			8
		},
		"board_jgbz_07",
		"icon_smll_sx12",
		"board_jgbz_07",
		"icon_smll_sx12",
		1041001
	},
	{
		2,
		"攻击阵",
		"2,5",
		"攻击提升",
		"训练师等级到达5级可解锁\n通过魔魔挑战第1关后解锁",
		"九宫八阵挑战中，仅固定位置可以上阵精灵",
		"暂未解锁，请前往九宫八阵挑战开启",
		10037,
		{
			1,
			4,
			5,
			6,
			9
		},
		"board_jgbz_16",
		"icon_smll_sx01",
		"board_jgbz_16",
		"icon_smll_sx01",
		1041002
	},
	{
		3,
		"暴击阵",
		"2,10",
		"暴击率提升",
		"训练师等级到达10级可解锁\n通过双双挑战第1关后解锁",
		"九宫八阵挑战中，仅固定位置可以上阵精灵",
		"暂未解锁，请前往九宫八阵挑战开启",
		10034,
		{
			2,
			3,
			4,
			6,
			7
		},
		"board_jgbz_11",
		"icon_smll_sx13",
		"board_jgbz_11",
		"icon_smll_sx13",
		1041003
	},
	{
		4,
		"防御阵",
		"2,10",
		"防御提升",
		"训练师等级到达10级可解锁\n通过当当挑战第1关后解锁",
		"九宫八阵挑战中，仅固定位置可以上阵精灵",
		"暂未解锁，请前往九宫八阵挑战开启",
		10032,
		{
			1,
			3,
			4,
			6,
			8
		},
		"board_jgbz_17",
		"icon_smll_sx03",
		"board_jgbz_17",
		"icon_smll_sx03",
		1041004
	},
	{
		5,
		"闪避阵",
		"2,15",
		"闪避率提升",
		"训练师等级到达15级可解锁\n通过闪闪挑战第1关后解锁",
		"九宫八阵挑战中，仅固定位置可以上阵精灵",
		"暂未解锁，请前往九宫八阵挑战开启",
		10035,
		{
			2,
			4,
			6,
			7,
			9
		},
		"board_jgbz_12",
		"icon_smll_sx10",
		"board_jgbz_12",
		"icon_smll_sx10",
		1041005
	},
	{
		6,
		"命中阵",
		"2,15",
		"命中率提升",
		"训练师等级到达15级可解锁\n通过准准挑战第1关后解锁",
		"九宫八阵挑战中，仅固定位置可以上阵精灵",
		"暂未解锁，请前往九宫八阵挑战开启",
		10036,
		{
			1,
			3,
			5,
			7,
			9
		},
		"board_jgbz_13",
		"icon_smll_sx09",
		"board_jgbz_13",
		"icon_smll_sx09",
		1041006
	},
	{
		7,
		"防暴阵",
		"2,20",
		"防暴率提升",
		"训练师等级到达20级可解锁\n通过绝绝挑战第1关后解锁",
		"九宫八阵挑战中，仅固定位置可以上阵精灵",
		"暂未解锁，请前往九宫八阵挑战开启",
		10033,
		{
			1,
			2,
			3,
			5,
			8
		},
		"board_jgbz_15",
		"icon_smll_sx14",
		"board_jgbz_15",
		"icon_smll_sx14",
		1041007
	},
	{
		8,
		"破击阵",
		"2,20",
		"破击率提升",
		"训练师等级到达20级可解锁\n通过问问挑战第1关后解锁",
		"九宫八阵挑战中，仅固定位置可以上阵精灵",
		"暂未解锁，请前往九宫八阵挑战开启",
		10031,
		{
			1,
			4,
			5,
			8,
			9
		},
		"board_jgbz_18",
		"icon_smll_sx11",
		"board_jgbz_18",
		"icon_smll_sx11",
		1041008
	}
}
local t_nine_place_stage = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_nine_place_stage.dataList = dataList

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

return t_nine_place_stage
