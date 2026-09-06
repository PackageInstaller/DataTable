-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qixi_send_gift_sugar_rank.lua

module("logicconfig.config.t_qixi_send_gift_sugar_rank", package.seeall)

local title = {
	text = 5,
	prize = 4,
	rightTop = 3,
	id = 2,
	sugarPlanId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		"13:127:1",
		"1、向好友赠送信物即可获得甜蜜值；\r\n2、战区排行榜前300名可获得艾希动态头像；\r\n3、排行榜将在活动结束时通过邮件结算奖励。"
	},
	{
		1,
		2,
		10,
		"13:127:1",
		"1、向好友赠送信物即可获得甜蜜值；\r\n2、战区排行榜前300名可获得艾希动态头像；\r\n3、排行榜将在活动结束时通过邮件结算奖励。"
	},
	{
		1,
		3,
		300,
		"13:127:1",
		"1、向好友赠送信物即可获得甜蜜值；\r\n2、战区排行榜前300名可获得艾希动态头像；\r\n3、排行榜将在活动结束时通过邮件结算奖励。"
	},
	{
		2,
		1,
		1,
		"13:187:1",
		"1、向好友赠送信物即可获得情义值；\r\n2、战区排行榜前300名可获得小梵头像；\r\n3、排行榜将在活动结束时通过邮件结算奖励。"
	},
	{
		2,
		2,
		10,
		"13:187:1",
		"1、向好友赠送信物即可获得情义值；\r\n2、战区排行榜前300名可获得小梵头像；\r\n3、排行榜将在活动结束时通过邮件结算奖励。"
	},
	{
		2,
		3,
		300,
		"13:187:1",
		"1、向好友赠送信物即可获得情义值；\r\n2、战区排行榜前300名可获得小梵头像；\r\n3、排行榜将在活动结束时通过邮件结算奖励。"
	}
}
local t_qixi_send_gift_sugar_rank = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_qixi_send_gift_sugar_rank.dataList = dataList

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

return t_qixi_send_gift_sugar_rank
