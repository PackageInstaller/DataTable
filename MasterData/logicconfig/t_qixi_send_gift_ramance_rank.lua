-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qixi_send_gift_ramance_rank.lua

module("logicconfig.config.t_qixi_send_gift_ramance_rank", package.seeall)

local title = {
	romancePlanId = 1,
	text = 5,
	rightTop = 3,
	id = 2,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		1,
		"13:128:1",
		"1、收到好友信物即可获得浪漫值；\r\n2、战区排行榜前300名可获得启动态头像；\r\n3、排行榜将在活动结束时通过邮件结算奖励。"
	},
	{
		1,
		2,
		10,
		"13:128:1",
		"1、收到好友信物即可获得浪漫值；\r\n2、战区排行榜前300名可获得启动态头像；\r\n3、排行榜将在活动结束时通过邮件结算奖励。"
	},
	{
		1,
		3,
		300,
		"13:128:1",
		"1、收到好友信物即可获得浪漫值；\r\n2、战区排行榜前300名可获得启动态头像；\r\n3、排行榜将在活动结束时通过邮件结算奖励。"
	},
	{
		2,
		1,
		1,
		"13:188:1",
		"1、收到好友信物即可获得友爱值；\r\n2、战区排行榜前300名可获得阿瑞头像；\r\n3、排行榜将在活动结束时通过邮件结算奖励。"
	},
	{
		2,
		2,
		10,
		"13:188:1",
		"1、收到好友信物即可获得友爱值；\r\n2、战区排行榜前300名可获得阿瑞头像；\r\n3、排行榜将在活动结束时通过邮件结算奖励。"
	},
	{
		2,
		3,
		300,
		"13:188:1",
		"1、收到好友信物即可获得友爱值；\r\n2、战区排行榜前300名可获得阿瑞头像；\r\n3、排行榜将在活动结束时通过邮件结算奖励。"
	}
}
local t_qixi_send_gift_ramance_rank = {
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

t_qixi_send_gift_ramance_rank.dataList = dataList

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

return t_qixi_send_gift_ramance_rank
