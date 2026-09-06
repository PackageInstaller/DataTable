-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_lun_challenge_extreme_card_group.lua

module("logicconfig.config.t_kun_lun_challenge_extreme_card_group", package.seeall)

local title = {
	groupId = 2,
	iconPath = 3,
	activityId = 1
}
local dataList = {
	{
		304001,
		1,
		"expevents/icon_expedition_kaichangqishi"
	},
	{
		304001,
		2,
		"expevents/icon_expedition_kaichanghuixue"
	},
	{
		304001,
		3,
		"expevents/icon_expedition_chushouqianjianshang"
	},
	{
		304001,
		4,
		"expevents/icon_expedition_guijia01"
	},
	{
		304001,
		5,
		"expevents/icon_expedition_wushang"
	},
	{
		304001,
		6,
		"expevents/icon_expedition_yadao01"
	},
	{
		304002,
		1,
		"expevents/icon_expedition_kaichangqishi"
	},
	{
		304002,
		2,
		"expevents/icon_expedition_kaichanghuixue"
	},
	{
		304002,
		3,
		"expevents/icon_expedition_chushouqianjianshang"
	},
	{
		304002,
		4,
		"expevents/icon_expedition_guijia01"
	},
	{
		304002,
		5,
		"expevents/icon_expedition_wushang"
	},
	{
		304002,
		6,
		"expevents/icon_expedition_yadao01"
	}
}
local t_kun_lun_challenge_extreme_card_group = {
	[304001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[304002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_kun_lun_challenge_extreme_card_group.dataList = dataList

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

return t_kun_lun_challenge_extreme_card_group
