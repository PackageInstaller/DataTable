-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_war_order.lua

module("logicconfig.config.t_season_mode_war_order", package.seeall)

local title = {
	buyPlan = 3,
	lotteryEnergy = 12,
	finalPrize = 10,
	payGoodsId = 9,
	levelPlan = 2,
	showSkinIdList = 17,
	showTabNameA = 18,
	superPrizePlan = 7,
	maxBuyLevel = 8,
	normalPrizePlan = 6,
	seasonId = 1,
	showTabNameB = 19,
	showSpiritMatId = 21,
	taskPlan = 4,
	sellTime = 23,
	recoverPlan = 5,
	textureNameB = 15,
	rolePosLists = 16,
	maxRecoverDay = 11,
	textureNameA = 14,
	showSpiritId = 20,
	rewardBtnDesc = 22,
	lotteryPrize = 13
}
local dataList = {
	{
		1,
		1,
		1,
		1,
		1,
		1,
		2,
		10,
		"rmb_60",
		"100:17004:1:1",
		2,
		150,
		"9:1300001:1",
		"board_saijiwanfa_50",
		"board_saijiwanfa_63",
		nil,
		nil,
		"",
		"",
		17004,
		1700401,
		"领取达克诺斯",
		"时段|2022-11-18 05:00:00,2022-11-25 05:00:00"
	},
	{
		2,
		2,
		2,
		2,
		2,
		3,
		4,
		10,
		"rmb_30",
		"17:1014603:-1:1",
		2,
		150,
		"9:1300001:1",
		"",
		"",
		nil,
		nil,
		"",
		"",
		0,
		1014603,
		"领取醒狮皮肤",
		"时段|2023-02-10 05:00:00,2023-02-17 05:00:00"
	},
	{
		3,
		3,
		3,
		3,
		3,
		5,
		6,
		10,
		"rmb_30",
		"100:17012:1:1",
		2,
		150,
		"9:1300001:1",
		"",
		"",
		{
			{
				-25.1,
				-500.4,
				1
			},
			{
				-486,
				-358.1,
				1
			}
		},
		{
			17012,
			1701201
		},
		"",
		"",
		17012,
		0,
		"领取撒达",
		"时段|2023-11-17 05:00:00,2023-11-24 05:00:00"
	}
}
local t_season_mode_war_order = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_season_mode_war_order.dataList = dataList

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

return t_season_mode_war_order
