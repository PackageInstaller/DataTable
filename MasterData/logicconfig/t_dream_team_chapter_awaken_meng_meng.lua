-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_team_chapter_awaken_meng_meng.lua

module("logicconfig.config.t_dream_team_chapter_awaken_meng_meng", package.seeall)

local title = {
	challengeId = 9,
	skinId = 4,
	posNScale = 5,
	mmName = 8,
	awakenCost = 3,
	tipStr = 10,
	mengMengId = 2,
	jumpViewName = 6,
	activityId = 1,
	ruleTip = 7
}
local dataList = {
	{
		595001,
		1,
		"10:595004:100",
		11041,
		{
			-250,
			-685,
			1
		},
		"dreamteamchaptermultmainview",
		"originlongzhumainview_rule",
		82056079,
		2,
		82056690
	},
	{
		595001,
		2,
		"10:595006:100",
		15050,
		{
			-220,
			-425,
			1
		},
		"dreamteamchaptermultmainview",
		"originlongzhumainview_rule",
		82055858,
		4,
		82056691
	},
	{
		595001,
		3,
		"10:595003:100",
		12046,
		{
			-195,
			-545,
			1
		},
		"dreamteamchapterhotmmmainview",
		"originlongzhumainview_rule",
		82055859,
		1,
		82056692
	},
	{
		595001,
		4,
		"10:595002:100",
		11042,
		{
			-165,
			-485,
			1
		},
		"dreamteamchapterduolammmainview",
		"originlongzhumainview_rule",
		82055845,
		0,
		82056693
	},
	{
		595001,
		5,
		"10:595001:100",
		13031,
		{
			0,
			0,
			1
		},
		"dreamteamchapteralchemymmmainview",
		"originlongzhumainview_rule",
		82055846,
		0,
		82056693
	},
	{
		595001,
		6,
		"10:595005:100",
		14044,
		{
			-245,
			-550,
			1
		},
		"dreamteamchaptermultmainview",
		"originlongzhumainview_rule",
		82037432,
		3,
		82056694
	}
}
local t_dream_team_chapter_awaken_meng_meng = {
	[595001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_dream_team_chapter_awaken_meng_meng.dataList = dataList

local multiLanguageCells = {
	mmName = true,
	tipStr = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_dream_team_chapter_awaken_meng_meng
