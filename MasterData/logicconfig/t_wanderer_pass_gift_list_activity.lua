-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wanderer_pass_gift_list_activity.lua

module("logicconfig.config.t_wanderer_pass_gift_list_activity", package.seeall)

local title = {
	id = 2,
	prize = 3,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		582001,
		1,
		"4:90530:1",
		"5周年专属主题服装"
	},
	{
		582001,
		2,
		"4:1041:1",
		"5周年专属主题坐骑免费领"
	},
	{
		582001,
		3,
		"4:510764:1",
		"5周年版本新精灵各领神器一件"
	},
	{
		582001,
		4,
		"4:510765:1",
		"5周年版本指定类型皮肤抽奖各送2抽"
	},
	{
		582001,
		5,
		"4:510766:1",
		"领周年商城抵扣券"
	},
	{
		582001,
		6,
		"1004:1627:1",
		"领1个月金钻特权"
	},
	{
		582001,
		7,
		"1004:1628:1",
		"5周年版本新精灵直购/神曜币兑换神曜材料享折扣"
	},
	{
		582001,
		8,
		"1004:1629:1",
		"5周年版本新精灵专属红星立减20神钻，每只精灵限购1个"
	},
	{
		582001,
		9,
		"1004:1630:1",
		"指定圣品/性转/绝品/臻品/精品分别选1个皮肤，直购立减神钻"
	},
	{
		582001,
		10,
		"1004:1631:1",
		"指定精灵或神曜/源起材料可分别选2个，直购立减神钻"
	}
}
local t_wanderer_pass_gift_list_activity = {
	[582001] = {
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
}

t_wanderer_pass_gift_list_activity.dataList = dataList

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

return t_wanderer_pass_gift_list_activity
