-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_power_challenge_chapter.lua

module("logic.config.t_power_challenge_chapter", package.seeall)

local title = {
	imageGuideId = 9,
	openTime = 7,
	name = 3,
	chapterId = 2,
	dungeonIds = 5,
	id = 1,
	recommendLv = 4,
	tasks = 6,
	guideVideoName = 8
}
local dataList = {
	{
		120001,
		1,
		"追击试炼",
		{
			20,
			40,
			60
		},
		{
			190101,
			190102,
			190103
		},
		{
			131200011,
			131200012,
			131200013
		},
		0,
		"yntz_zhuiji",
		8101
	},
	{
		120001,
		2,
		"振荡试炼",
		{
			20,
			40,
			60
		},
		{
			190201,
			190202,
			190203
		},
		{
			131200021,
			131200022,
			131200023
		},
		1,
		"yntz_zhendang",
		8102
	},
	{
		120001,
		3,
		"超感试炼",
		{
			20,
			40,
			60
		},
		{
			190301,
			190302,
			190303
		},
		{
			131200031,
			131200032,
			131200033
		},
		2,
		"yntz_chaogan",
		8103
	},
	{
		120001,
		4,
		"援护试炼",
		{
			20,
			40,
			60
		},
		{
			190401,
			190402,
			190403
		},
		{
			131200041,
			131200042,
			131200043
		},
		3,
		"yntz_yuanhu",
		8104
	},
	{
		120001,
		5,
		"锥刺试炼",
		{
			20,
			40,
			60
		},
		{
			190501,
			190502,
			190503
		},
		{
			131200051,
			131200052,
			131200053
		},
		4,
		"yntz_zhuici",
		8105
	},
	{
		120001,
		6,
		"弧光试炼",
		{
			20,
			40,
			60
		},
		{
			190601,
			190602,
			190603
		},
		{
			131200061,
			131200062,
			131200063
		},
		5,
		"yntz_huguang",
		8106
	}
}
local t_power_challenge_chapter = {}

t_power_challenge_chapter.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	local parent1 = t_power_challenge_chapter[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_power_challenge_chapter[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_power_challenge_chapter
