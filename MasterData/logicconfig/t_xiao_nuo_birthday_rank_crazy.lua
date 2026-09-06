-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_birthday_rank_crazy.lua

module("logicconfig.config.t_xiao_nuo_birthday_rank_crazy", package.seeall)

local title = {
	prize = 3,
	desc = 4,
	activityId = 1,
	rightTop = 2
}
local dataList = {
	{
		220001,
		5000,
		"13:111:1",
		"1、排行榜每2周重置，奖励将在重置时根据排名结算；\r\n2、全服排名前5000名可领取Q版洛世琦头像奖励；\r\n3、相同单次通关数的情况下，达成时间越早排名越高。"
	},
	{
		220002,
		5000,
		"13:111:1",
		"1、排行榜每2周重置，奖励将在重置时根据排名结算；\r\n2、全服排名前5000名可领取Q版洛世琦头像奖励；\r\n3、相同单次通关数的情况下，达成时间越早排名越高。"
	},
	{
		220003,
		5000,
		"13:111:1",
		"1、奖励将在活动结束时根据排名结算；\r\n2、全服排名前5000名可领取Q版洛世琦头像奖励；\r\n3、相同单次通关数的情况下，达成时间越早排名越高。"
	},
	{
		220004,
		5000,
		"13:111:1",
		"1、奖励将在活动结束时根据排名结算；\r\n2、全服排名前5000名可领取Q版洛世琦头像奖励；\r\n3、相同单次通关数的情况下，达成时间越早排名越高。"
	}
}
local t_xiao_nuo_birthday_rank_crazy = {
	[220001] = dataList[1],
	[220002] = dataList[2],
	[220003] = dataList[3],
	[220004] = dataList[4]
}

t_xiao_nuo_birthday_rank_crazy.dataList = dataList

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

return t_xiao_nuo_birthday_rank_crazy
