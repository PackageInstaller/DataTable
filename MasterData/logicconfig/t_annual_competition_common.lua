-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_competition_common.lua

module("logicconfig.config.t_annual_competition_common", package.seeall)

local title = {
	value = 2,
	key = 1,
	value2 = 3
}
local dataList = {
	{
		"CURR_ACT_ID",
		"133034",
		0
	},
	{
		"ENTER_EXCHANGE_JUMP",
		"func#191#133#133034",
		0
	},
	{
		"ACT_RULE",
		"skinstryoutsview",
		0
	},
	{
		"ACT_TIME_OVER",
		"活动已结束",
		82055786
	},
	{
		"NOT_IN_OPEN_TIME",
		"当天活动还没开始",
		82055787
	},
	{
		"COST_TICKET_CONTENT",
		"是否消耗%s进行比赛？",
		82055788
	},
	{
		"PET_CHECK_ITEM_DESC",
		"您至少需要一个%s职业的精灵",
		82055789
	},
	{
		"PET_CHECK_CONNECT",
		"或",
		82055790
	},
	{
		"MAIN_VIEW_FORM_EMPTY",
		"请先进行布阵",
		82055791
	},
	{
		"MAIN_VIEW_GIVE_UP",
		"是否确定放弃比赛？",
		82055792
	},
	{
		"MAIN_VIWE_START",
		"开始匹配",
		82055793
	},
	{
		"MAIN_VIEW_SELECT_BUFF",
		"选择BUFF",
		82055794
	},
	{
		"BATTLE_WIN_GO_NEXT",
		"恭喜获得胜利，请再接再厉！",
		82055795
	},
	{
		"BATTLE_WIN_GO_PRIZE",
		"恭喜您已经达到8场胜利，即将结算奖励！",
		82055796
	},
	{
		"BATTLE_FAIL_GO_NEXT",
		"通过布阵，可以增加提高胜利的几率。",
		82055797
	},
	{
		"BATTLE_FAIL_GO_PRIZE",
		"很遗憾，您已经达到3败，即将结算奖励。",
		82055798
	},
	{
		"TASK_VIWE_NOT_ENOUTH",
		"未完成任务",
		82055799
	},
	{
		"RANK_VIEW_DESC",
		"只显示上榜的前100名",
		82055800
	},
	{
		"ENTER_BEGIN",
		"开始比赛",
		82055801
	},
	{
		"ENTER_CONTINUE",
		"继续比赛",
		82055802
	},
	{
		"TASK_VIWE_PROGRESS",
		"（%s/%s）",
		0
	},
	{
		"MAIN_VIWE_TIPS",
		"本轮比赛挑战失败可以点击下方区域\n任选一个精灵更换",
		82055803
	},
	{
		"MAIN_VIEW_EMPTY",
		"请先进行布阵再进入战斗",
		82055804
	},
	{
		"USER_BAN_PET_NUM",
		"5",
		0
	},
	{
		"SYS_BAN_PET_NUM",
		"5",
		0
	},
	{
		"CAN_BAN_PET_WIN_TIMES",
		"9",
		0
	},
	{
		"BAN_PET_RULE_KEY",
		"skinstryoutsview_rule",
		0
	},
	{
		"BAN_PET_RULE_TIP",
		"1、全服进入淘汰赛的玩家参与投票\r\n2、每人拥有5张票,可对5只不同的精灵进行投票,相同的精灵不可重复投票,完成投票后不可修改,5张票可以不用完,投票时间结束前都可以投票\r\n3、投票时间结束时,统计各精灵的票数,排名前5的精灵ban掉,在下赛季不可上阵(海选赛、淘汰赛都不可用)",
		82055805
	},
	{
		"SYS_COST_MAT_STR",
		"1004:1573:1",
		0
	}
}
local t_annual_competition_common = {
	CURR_ACT_ID = dataList[1],
	ENTER_EXCHANGE_JUMP = dataList[2],
	ACT_RULE = dataList[3],
	ACT_TIME_OVER = dataList[4],
	NOT_IN_OPEN_TIME = dataList[5],
	COST_TICKET_CONTENT = dataList[6],
	PET_CHECK_ITEM_DESC = dataList[7],
	PET_CHECK_CONNECT = dataList[8],
	MAIN_VIEW_FORM_EMPTY = dataList[9],
	MAIN_VIEW_GIVE_UP = dataList[10],
	MAIN_VIWE_START = dataList[11],
	MAIN_VIEW_SELECT_BUFF = dataList[12],
	BATTLE_WIN_GO_NEXT = dataList[13],
	BATTLE_WIN_GO_PRIZE = dataList[14],
	BATTLE_FAIL_GO_NEXT = dataList[15],
	BATTLE_FAIL_GO_PRIZE = dataList[16],
	TASK_VIWE_NOT_ENOUTH = dataList[17],
	RANK_VIEW_DESC = dataList[18],
	ENTER_BEGIN = dataList[19],
	ENTER_CONTINUE = dataList[20],
	TASK_VIWE_PROGRESS = dataList[21],
	MAIN_VIWE_TIPS = dataList[22],
	MAIN_VIEW_EMPTY = dataList[23],
	USER_BAN_PET_NUM = dataList[24],
	SYS_BAN_PET_NUM = dataList[25],
	CAN_BAN_PET_WIN_TIMES = dataList[26],
	BAN_PET_RULE_KEY = dataList[27],
	BAN_PET_RULE_TIP = dataList[28],
	SYS_COST_MAT_STR = dataList[29]
}

t_annual_competition_common.dataList = dataList

local multiLanguageCells = {
	value2 = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_annual_competition_common
