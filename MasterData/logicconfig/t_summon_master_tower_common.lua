-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_tower_common.lua

module("logicconfig.config.t_summon_master_tower_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_FREE_TIMES",
		"1"
	},
	{
		"WISH_NEED_DRAGON_PERL_COUNT",
		"7"
	},
	{
		"EXCHANGE_PUSH_ITEM",
		"4:12102:5"
	},
	{
		"SELF_MAX_PET_COUNT",
		"15"
	},
	{
		"MYRANK_DESC_TIPS",
		"1.按通关数由高到低排序，通关数相同，积分高排前面。\r\n2.此为全服务器排名，榜单显示前100名，每10分钟刷新1次。"
	},
	{
		"INIT_GAME_TIMES",
		"2"
	},
	{
		"MAX_TIMES",
		"5"
	},
	{
		"GAME_TIMES_RULE",
		"1.活动开始获得2次挑战次数，后续每天增加1次，每天可额外花费钻石购买2次。"
	},
	{
		"RESET_RULE",
		"2.活动每周五5点重置进度，除已存储次数、已获得冒险积分、迷域商店外均会重置。"
	},
	{
		"ACT_SHOP_ID",
		"func#191#85#85008"
	},
	{
		"PET_NUM_LIMIT_TIP",
		"你的队伍过于庞大，会引起终极守卫的警觉，请选择一个队员离开你的队伍！\n召唤师和契约精灵除外，队伍精灵最多15只，超过15只，将选择1只精灵离开，新加入的精灵不能选择离开"
	},
	{
		"PET_NUM_LIMIT_TIP1",
		"确定选择Lv.%d%s成为你的队员吗？\n※召唤师和契约精灵除外，队伍精灵最多为15只\n※超过15只，将选择1只精灵离开，新加入的精灵不能选择离开"
	}
}
local t_summon_master_tower_common = {
	DAILY_FREE_TIMES = dataList[1],
	WISH_NEED_DRAGON_PERL_COUNT = dataList[2],
	EXCHANGE_PUSH_ITEM = dataList[3],
	SELF_MAX_PET_COUNT = dataList[4],
	MYRANK_DESC_TIPS = dataList[5],
	INIT_GAME_TIMES = dataList[6],
	MAX_TIMES = dataList[7],
	GAME_TIMES_RULE = dataList[8],
	RESET_RULE = dataList[9],
	ACT_SHOP_ID = dataList[10],
	PET_NUM_LIMIT_TIP = dataList[11],
	PET_NUM_LIMIT_TIP1 = dataList[12]
}

t_summon_master_tower_common.dataList = dataList

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

return t_summon_master_tower_common
