-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_params.lua

module("logicconfig.config.t_camp_battle_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"COIN_INSPIRE_LANTERN",
		"41"
	},
	{
		"COIN_PLUNDER_LANTERN",
		"42"
	},
	{
		"TIPS1",
		"当前鼓舞值：%d\n BUFF触发机制：根据阵营鼓舞值触发 %s \n BUFF生效幻境：在后续阵营比拼阶段的击败入侵者和阵营大乱斗中生效"
	},
	{
		"CURRENCY",
		"104:2#10:187002"
	},
	{
		"INIT_CAMP_SCORE",
		"1000"
	},
	{
		"GET_PRICE_SCORE",
		"1000"
	},
	{
		"RANK_TEXT1",
		"1、排行榜根据阵营总积分排名\r\n2、每位玩家参与阵营比拼玩法都能给阵营增加总积分"
	},
	{
		"RANK_TEXT2",
		"1、排行榜根据阵营个人积分排名\r\n2、每个玩家参与阵营比拼玩法都能获得阵营个人积分"
	},
	{
		"COIN_INSPIRE_DESC1",
		"到达一定金币消耗量，可为阵营增加<color=#ebad32>阵营鼓舞值</color>"
	},
	{
		"COIN_INSPIRE_DESC2",
		"到达一定金币消耗量，可对其他阵营进行<color=#ebad32>掠夺积分</color>"
	},
	{
		"ITEM_ID",
		"187002"
	},
	{
		"DAILY_LIMIT_TEXT",
		"今日获得代币上限:%s/%s"
	}
}
local t_camp_battle_params = {
	COIN_INSPIRE_LANTERN = dataList[1],
	COIN_PLUNDER_LANTERN = dataList[2],
	TIPS1 = dataList[3],
	CURRENCY = dataList[4],
	INIT_CAMP_SCORE = dataList[5],
	GET_PRICE_SCORE = dataList[6],
	RANK_TEXT1 = dataList[7],
	RANK_TEXT2 = dataList[8],
	COIN_INSPIRE_DESC1 = dataList[9],
	COIN_INSPIRE_DESC2 = dataList[10],
	ITEM_ID = dataList[11],
	DAILY_LIMIT_TEXT = dataList[12]
}

t_camp_battle_params.dataList = dataList

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

return t_camp_battle_params
