-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_aolaishi_linkstrategy.lua

module("logicconfig.config.t_activity_aolaishi_linkstrategy", package.seeall)

local title = {
	id = 2,
	res = 5,
	strategycellid = 1,
	title = 3,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"联动套餐",
		"奇迹联动套餐来袭，超值优惠等你来",
		"ui/bigbg/views/aolaishilink/board_ldhualaishi_02.png"
	},
	{
		1,
		2,
		"饿了么APP活动",
		"下单兑换双面绒帽小蓝盒，更可参与周边抽奖",
		"ui/bigbg/views/aolaishilink/board_ldhualaishi_03.png"
	},
	{
		1,
		3,
		"饿了么优惠券",
		"手游&页游参与活动立得华莱士10元优惠券",
		"ui/bigbg/views/aolaishilink/board_ldhualaishi_04.png"
	},
	{
		1,
		4,
		"主题店限时打卡",
		"线下主题店打卡限时得小诺摇摇乐周边，赠完即止",
		"ui/bigbg/views/aolaishilink/board_ldhualaishi_06.png"
	}
}
local t_activity_aolaishi_linkstrategy = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_activity_aolaishi_linkstrategy.dataList = dataList

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

return t_activity_aolaishi_linkstrategy
