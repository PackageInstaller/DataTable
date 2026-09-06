-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_game_common.lua

module("logicconfig.config.t_camp_game_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"OPEN_TIME",
		"09:00:00#13:00:00,18:00:00#23:00:00"
	},
	{
		"FUN_OPEN_TIME",
		"09:00:00#23:00:00"
	},
	{
		"CHALLENGE_REWARD_CEILING",
		"800"
	},
	{
		"WIN_REWARD",
		"10:187002:200"
	},
	{
		"LOSE_REWARD",
		"10:187002:100"
	},
	{
		"TIE_REWARD",
		"10:187002:150"
	},
	{
		"BEFORE_MATCH_TIME",
		"2"
	},
	{
		"MATCH_TIME",
		"30"
	},
	{
		"AFTER_MATCH_TIME",
		"1.5"
	},
	{
		"BAN_TIME",
		"30"
	},
	{
		"DISTRIBUTE_PET_TIME",
		"7"
	},
	{
		"READY_TIME",
		"75"
	},
	{
		"INIT_PET_NUM",
		"2"
	},
	{
		"SYSTEM_PET_NUM",
		"26"
	},
	{
		"BAN_PET_NUM",
		"4"
	},
	{
		"FUN_MATCH_RULE_ID",
		"3"
	},
	{
		"LOSE_STREAK_TRIGGER",
		"3"
	},
	{
		"SHOP_ACTIVITYTYPE",
		"37"
	},
	{
		"SHOP_ACTIVITYID",
		"37005"
	},
	{
		"OPEN_TIME_TIPS",
		"开放时间：09:00-13:00，18:00-23:00！"
	},
	{
		"FUN_OPEN_TIME_TIPS",
		"开放时间：9:00-23:00！"
	},
	{
		"ACTIVITY_RULE",
		"1.本活动使用的精灵均为系统精灵。\r\n\r\n2.匹配规则：与其他阵营的人实时匹配，匹配成功后可获得阵营积分和阵营代币\r\n\r\n3.匹配时间：每日<color=#EB4642FF>09:00-13:00，18:00-23:00</color>开放，参与匹配对战，根据胜负结算，获得<color=#EB4642FF>阵营积分、阵营代币</color>和段位升阶积分。\r\n\r\n\r\n5.对战规则\r\n①匹配成功，进入对战\r\n②先给对战双方随机各发<color=#EB4642FF>3只</color>精灵\r\n③系统给出<color=#EB4642FF>26只</color>精灵，双方可在这<color=#EB4642FF>26</color>只精灵上选择禁用精灵，每人最多可禁用<color=#EB4642FF>4只</color>\r\n④去掉禁用的精灵，剩余系统精灵随机给双方各发<color=#EB4642FF>9只</color>\r\n⑤使用派发的<color=#EB4642FF>11只</color>精灵和<color=#EB4642FF>助阵精灵</color>布阵，进行<color=#EB4642FF>6V6</color>战斗\r\n⑥根据胜负结算，获得奖励\r\n\r\n6.阵营币获得\r\n参与对战，获胜1场<color=#EB4642FF>+200</color>、平局1场<color=#EB4642FF>+150</color>、失败1场<color=#EB4642FF>+100</color>\r\n注意：阵营币活动结束后将<color=#EB4642FF>清空</color>，请及时兑换奖励哦！\r\n\r\n7、每日可购买挑战次数，最多可购买<color=#EB4642FF>10次</color>"
	},
	{
		"PRIZE_RULE",
		"1.每次挑战都可获得欢乐币\r\n2.胜利获得<color=#EB4642FF>100</color>欢乐币\r\n3.平局获得<color=#EB4642FF>75</color>欢乐币\r\n4.失败获得<color=#EB4642FF>50</color>欢乐币\r\n5.通过挑战，欢乐币每日获得上限<color=#EB4642FF>500</color>"
	},
	{
		"SHOP_EXPLICIT_ID",
		"17:1033801:-1:1"
	},
	{
		"RANDOM_BUFF_NUM",
		"3"
	},
	{
		"PET_NUM",
		"6"
	},
	{
		"PERMANENT_BUFFS",
		""
	},
	{
		"DAILY_TIME_LIMIT",
		"3"
	}
}
local t_camp_game_common = {
	OPEN_TIME = dataList[1],
	FUN_OPEN_TIME = dataList[2],
	CHALLENGE_REWARD_CEILING = dataList[3],
	WIN_REWARD = dataList[4],
	LOSE_REWARD = dataList[5],
	TIE_REWARD = dataList[6],
	BEFORE_MATCH_TIME = dataList[7],
	MATCH_TIME = dataList[8],
	AFTER_MATCH_TIME = dataList[9],
	BAN_TIME = dataList[10],
	DISTRIBUTE_PET_TIME = dataList[11],
	READY_TIME = dataList[12],
	INIT_PET_NUM = dataList[13],
	SYSTEM_PET_NUM = dataList[14],
	BAN_PET_NUM = dataList[15],
	FUN_MATCH_RULE_ID = dataList[16],
	LOSE_STREAK_TRIGGER = dataList[17],
	SHOP_ACTIVITYTYPE = dataList[18],
	SHOP_ACTIVITYID = dataList[19],
	OPEN_TIME_TIPS = dataList[20],
	FUN_OPEN_TIME_TIPS = dataList[21],
	ACTIVITY_RULE = dataList[22],
	PRIZE_RULE = dataList[23],
	SHOP_EXPLICIT_ID = dataList[24],
	RANDOM_BUFF_NUM = dataList[25],
	PET_NUM = dataList[26],
	PERMANENT_BUFFS = dataList[27],
	DAILY_TIME_LIMIT = dataList[28]
}

t_camp_game_common.dataList = dataList

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

return t_camp_game_common
