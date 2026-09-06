-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_abyss_gold_rush_score_level.lua

module("logicconfig.config.t_abyss_gold_rush_score_level", package.seeall)

local title = {
	matchRange = 4,
	holyStripeDropId = 5,
	score = 3,
	holyStripeDropDesc = 7,
	id = 2,
	activityId = 1,
	desc = 6
}
local dataList = {
	{
		612001,
		1,
		0,
		{
			0,
			300
		},
		1,
		"新手",
		"10%获得红色灵纹"
	},
	{
		612001,
		2,
		300,
		{
			0,
			200
		},
		2,
		"青铜",
		"20%获得红色灵纹"
	},
	{
		612001,
		3,
		500,
		{
			-100,
			500
		},
		3,
		"白银",
		"40%获得红色灵纹"
	},
	{
		612001,
		4,
		1000,
		{
			-100,
			1000
		},
		4,
		"黄金",
		"60%获得红色灵纹"
	},
	{
		612001,
		5,
		2000,
		{
			-100,
			99999
		},
		5,
		"铂金",
		"80%获得红色灵纹"
	}
}
local t_abyss_gold_rush_score_level = {
	[612001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_abyss_gold_rush_score_level.dataList = dataList

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

return t_abyss_gold_rush_score_level
