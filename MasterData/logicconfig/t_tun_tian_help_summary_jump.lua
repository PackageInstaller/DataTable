-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tun_tian_help_summary_jump.lua

module("logicconfig.config.t_tun_tian_help_summary_jump", package.seeall)

local title = {
	jumpId = 2,
	name = 4,
	gotoStr = 8,
	endTime = 6,
	jumpPlanId = 1,
	activityParams = 7,
	showTypeIdx = 3,
	startTime = 5
}
local dataList = {
	{
		1,
		1,
		0,
		"萌宠大作战",
		"2023-07-28T05:00:00",
		"2023-08-04T05:00:00",
		{
			17,
			17082
		},
		"func#921"
	},
	{
		1,
		2,
		0,
		"棋魂幻旅",
		"2023-07-28T05:00:00",
		"2023-08-04T05:00:00",
		{
			17,
			17082
		},
		"func#914"
	},
	{
		1,
		3,
		0,
		"萌宠大作战",
		"2023-08-04T05:00:00",
		"2023-08-11T05:00:00",
		{
			17,
			17083
		},
		"func#921"
	},
	{
		1,
		4,
		0,
		"棋魂幻旅",
		"2023-08-04T05:00:00",
		"2023-08-11T05:00:00",
		{
			17,
			17083
		},
		"func#914"
	},
	{
		1,
		5,
		1,
		"以上功能脆筒已翻倍",
		"2023-07-28T05:00:00",
		"2023-08-11T05:00:00",
		nil,
		""
	},
	{
		2,
		1,
		0,
		"萌宠大作战",
		"2023-07-28T05:00:00",
		"2023-08-04T05:00:00",
		{
			17,
			17082
		},
		"func#921"
	},
	{
		2,
		2,
		0,
		"棋魂幻旅",
		"2023-07-28T05:00:00",
		"2023-08-04T05:00:00",
		{
			17,
			17082
		},
		"func#914"
	},
	{
		2,
		3,
		0,
		"萌宠大作战",
		"2023-08-04T05:00:00",
		"2023-08-11T05:00:00",
		{
			17,
			17083
		},
		"func#921"
	},
	{
		2,
		4,
		0,
		"棋魂幻旅",
		"2023-08-04T05:00:00",
		"2023-08-11T05:00:00",
		{
			17,
			17083
		},
		"func#914"
	},
	{
		2,
		5,
		1,
		"以上功能脆筒已翻倍",
		"2023-07-28T05:00:00",
		"2023-08-11T05:00:00",
		nil,
		""
	}
}
local t_tun_tian_help_summary_jump = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_tun_tian_help_summary_jump.dataList = dataList

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

return t_tun_tian_help_summary_jump
