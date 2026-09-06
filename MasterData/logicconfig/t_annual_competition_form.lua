-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_competition_form.lua

module("logicconfig.config.t_annual_competition_form", package.seeall)

local title = {
	posList = 3,
	name = 5,
	activityId = 1,
	buff = 4,
	formId = 2,
	desc = 6
}
local dataList = {
	{
		133033,
		1,
		{
			2,
			4,
			5,
			6,
			8
		},
		"20074401:99",
		82057675,
		82056496
	},
	{
		133033,
		2,
		{
			1,
			4,
			5,
			6,
			9
		},
		"20074402:99",
		82057676,
		82056497
	},
	{
		133033,
		3,
		{
			2,
			3,
			4,
			6,
			7
		},
		"20074403:99",
		82057677,
		82056498
	},
	{
		133033,
		4,
		{
			1,
			2,
			3,
			5,
			8
		},
		"20074404:99",
		82057678,
		82056499
	},
	{
		133033,
		5,
		{
			1,
			3,
			4,
			6,
			8
		},
		"20074405:99",
		82057679,
		82056500
	},
	{
		133033,
		6,
		{
			2,
			4,
			6,
			7,
			9
		},
		"20074406:99",
		82057680,
		82056501
	},
	{
		133033,
		7,
		{
			1,
			3,
			5,
			7,
			9
		},
		"20074407:99",
		82057681,
		82056502
	},
	{
		133033,
		8,
		{
			3,
			4,
			5,
			7,
			9
		},
		"20074408:99#20074409:99",
		82057682,
		82056503
	},
	{
		133034,
		1,
		{
			2,
			4,
			5,
			6,
			8
		},
		"20074401:99",
		82057675,
		82056496
	},
	{
		133034,
		2,
		{
			1,
			4,
			5,
			6,
			9
		},
		"20074402:99",
		82057676,
		82056497
	},
	{
		133034,
		3,
		{
			2,
			3,
			4,
			6,
			7
		},
		"20074403:99",
		82057677,
		82056498
	},
	{
		133034,
		4,
		{
			1,
			2,
			3,
			5,
			8
		},
		"20074404:99",
		82057678,
		82056499
	},
	{
		133034,
		5,
		{
			1,
			3,
			4,
			6,
			8
		},
		"20074405:99",
		82057679,
		82056500
	},
	{
		133034,
		6,
		{
			2,
			4,
			6,
			7,
			9
		},
		"20074406:99",
		82057680,
		82056501
	},
	{
		133034,
		7,
		{
			1,
			3,
			5,
			7,
			9
		},
		"20074407:99",
		82057681,
		82056502
	},
	{
		133034,
		8,
		{
			3,
			4,
			5,
			7,
			9
		},
		"20074408:99#20074409:99",
		82057682,
		82056503
	}
}
local t_annual_competition_form = {
	[133033] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[133034] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_annual_competition_form.dataList = dataList

local multiLanguageCells = {
	desc = true,
	name = true
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

return t_annual_competition_form
