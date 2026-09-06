-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_btl_awaken_skill_effect.lua

module("logicconfig.config.t_btl_awaken_skill_effect", package.seeall)

local title = {
	name = 2,
	awakenSkillId = 1,
	raceId = 3,
	progressLimit = 4,
	maxTriggerCount = 5
}
local dataList = {
	{
		616010,
		"本体觉醒",
		{
			16010,
			46010
		},
		5,
		99
	},
	{
		61601001,
		"皮肤觉醒",
		{
			16010,
			46010
		},
		5,
		99
	},
	{
		61601002,
		"冠军皮觉醒",
		{
			16010,
			46010
		},
		5,
		99
	},
	{
		61601003,
		"冠军皮觉醒",
		{
			16010,
			46010
		},
		5,
		99
	},
	{
		616028,
		"本体觉醒",
		{
			16028,
			46028
		},
		5,
		99
	},
	{
		61602801,
		"本体觉醒",
		{
			16028,
			46028
		},
		5,
		99
	},
	{
		61602802,
		"本体觉醒",
		{
			16028,
			46028
		},
		5,
		99
	},
	{
		916040,
		"本体觉醒",
		{
			16040,
			46040
		},
		5,
		99
	},
	{
		91604001,
		"本体觉醒",
		{
			16040,
			46040
		},
		5,
		99
	},
	{
		91604002,
		"本体觉醒",
		{
			16040,
			46040
		},
		5,
		99
	},
	{
		91604003,
		"本体觉醒",
		{
			16040,
			46040
		},
		5,
		99
	},
	{
		916044,
		"本体觉醒",
		{
			16044,
			46044
		},
		5,
		99
	},
	{
		91604401,
		"本体觉醒",
		{
			16044,
			46044
		},
		5,
		99
	},
	{
		91604402,
		"本体觉醒",
		{
			16044,
			46044
		},
		5,
		99
	}
}
local t_btl_awaken_skill_effect = {
	[616010] = dataList[1],
	[61601001] = dataList[2],
	[61601002] = dataList[3],
	[61601003] = dataList[4],
	[616028] = dataList[5],
	[61602801] = dataList[6],
	[61602802] = dataList[7],
	[916040] = dataList[8],
	[91604001] = dataList[9],
	[91604002] = dataList[10],
	[91604003] = dataList[11],
	[916044] = dataList[12],
	[91604401] = dataList[13],
	[91604402] = dataList[14]
}

t_btl_awaken_skill_effect.dataList = dataList

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

return t_btl_awaken_skill_effect
