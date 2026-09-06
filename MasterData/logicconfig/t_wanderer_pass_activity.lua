-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wanderer_pass_activity.lua

module("logicconfig.config.t_wanderer_pass_activity", package.seeall)

local title = {
	payGoodsId = 2,
	prizeDesc_3 = 9,
	prizeDesc_5 = 11,
	skinId = 6,
	goldenDiamondDays = 4,
	prize = 3,
	desc = 5,
	prizeDesc_2 = 8,
	prizeDesc_4 = 10,
	activityId = 1,
	prizeDesc_1 = 7
}
local dataList = {
	{
		582001,
		"rmb_18",
		"4:90530:1#4:1041:1#4:510764:1#9:1300056:1#4:510766:1",
		30,
		"18元解锁，尊享10重好礼",
		"1702503",
		"5周年主题时装[侠客行]",
		"属性坐骑追云·墨玉驹",
		"版本精灵神器各1件",
		"皮肤抽奖券各2张",
		"江湖集市1250神钻抵扣券"
	}
}
local t_wanderer_pass_activity = {
	[582001] = dataList[1]
}

t_wanderer_pass_activity.dataList = dataList

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

return t_wanderer_pass_activity
