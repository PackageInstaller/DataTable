-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_roguelike_activity.lua

module("logicconfig.config.t_roguelike_activity", package.seeall)

local title = {
	rankTip = 6,
	globalBuffMaxCount = 3,
	redPointId = 4,
	globalBuffCoin = 5,
	activityId = 1,
	rentPetMaxCount = 2
}
local dataList = {
	{
		393001,
		3,
		2,
		595,
		"10:393001",
		"1、速通榜：根据通关普通难度的时间排行\r\n2、击杀榜：根据混沌难度内【究或解神】击杀敌阵精灵数量排行\r\n3、排行榜奖励在活动结束后通过邮件发送，排行榜非实时刷新"
	},
	{
		393002,
		3,
		2,
		595,
		"10:393002",
		"1、速通榜：根据通关普通难度的时间排行\r\n2、击杀榜：根据混沌难度内【神曜梵天/神曜无序】\r\n击杀敌阵精灵数量排行，达到10击杀数后才可上榜\r\n3、排行榜奖励在活动结束后通过邮件发送，排行榜非实时刷新"
	},
	{
		393003,
		3,
		2,
		595,
		"10:393003",
		"1、速通榜：根据通关普通难度的时间排行\r\n2、击杀榜：根据混沌难度内【源起龙脉诺/源起超神】\r\n击杀敌阵精灵数量排行，达到10击杀数后才可上榜\r\n3、排行榜奖励在活动结束后通过邮件发送，排行榜非实时刷新"
	}
}
local t_roguelike_activity = {
	[393001] = dataList[1],
	[393002] = dataList[2],
	[393003] = dataList[3]
}

t_roguelike_activity.dataList = dataList

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

return t_roguelike_activity
