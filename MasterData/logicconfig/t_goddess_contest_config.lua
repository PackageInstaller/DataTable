-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_config.lua

module("logicconfig.config.t_goddess_contest_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"GODDESS_VOTE_RATE",
		"1"
	},
	{
		"DIRECTOR_VOTE_RATE",
		"1"
	},
	{
		"REFUND_RATE",
		"1"
	},
	{
		"CAMPAIGN_SHOW_NUMS",
		"5"
	},
	{
		"CAMPAIGN_ZDL_LIMIT",
		"800000"
	},
	{
		"CAMPAIGN_POPULARITY_VALUE_LIMIT",
		"240"
	},
	{
		"CAMPAIGN_COST",
		"105:6055:200"
	},
	{
		"CHAT_TEXT_ID",
		"57"
	},
	{
		"CHAT_CD",
		"60"
	},
	{
		"DECLARATION_MAX_LENGTH",
		"30"
	},
	{
		"RANDOM_JOINS_TIPS",
		"您已错过手动入团时间，为保持各粉丝团人数平衡，根据随机分配原则，您将加入【%s】粉丝团。\r\n入团后可为团内的女神投票，并且可能会有钻石红包可以抢哦！"
	},
	{
		"MAIN_RULE",
		"goddess_contest_main_rule"
	},
	{
		"SHOP_GO_TO",
		"func#191#17#17106"
	},
	{
		"GROUP_RULE",
		"goddess_contest_main_rule"
	},
	{
		"RANK_MAIL_ID",
		"194"
	},
	{
		"VOTE_DESC_1",
		"3月24日投票结束，优胜女神将定制冠军专属皮肤"
	},
	{
		"VOTE_DESC_2",
		"从3月22日开始，将开启人气狂潮活动"
	},
	{
		"FRENZY_RULE",
		"goddess_contest_frenzy_rule"
	},
	{
		"WINNER_DESC_1",
		"优胜女神将在后续推出定制冠军专属皮肤"
	}
}
local t_goddess_contest_config = {
	GODDESS_VOTE_RATE = dataList[1],
	DIRECTOR_VOTE_RATE = dataList[2],
	REFUND_RATE = dataList[3],
	CAMPAIGN_SHOW_NUMS = dataList[4],
	CAMPAIGN_ZDL_LIMIT = dataList[5],
	CAMPAIGN_POPULARITY_VALUE_LIMIT = dataList[6],
	CAMPAIGN_COST = dataList[7],
	CHAT_TEXT_ID = dataList[8],
	CHAT_CD = dataList[9],
	DECLARATION_MAX_LENGTH = dataList[10],
	RANDOM_JOINS_TIPS = dataList[11],
	MAIN_RULE = dataList[12],
	SHOP_GO_TO = dataList[13],
	GROUP_RULE = dataList[14],
	RANK_MAIL_ID = dataList[15],
	VOTE_DESC_1 = dataList[16],
	VOTE_DESC_2 = dataList[17],
	FRENZY_RULE = dataList[18],
	WINNER_DESC_1 = dataList[19]
}

t_goddess_contest_config.dataList = dataList

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

return t_goddess_contest_config
